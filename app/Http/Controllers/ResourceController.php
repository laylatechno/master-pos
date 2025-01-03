<?php

// app/Http/Controllers/ResourceController.php
namespace App\Http\Controllers;

use App\Models\LogHistori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Illuminate\View\View; // Tambahkan ini
use Illuminate\Support\Facades\Schema;




class ResourceController extends Controller
{

    private function simpanLogHistori($aksi, $tabelAsal, $idEntitas, $pengguna, $dataLama, $dataBaru)
    {
        $log = new LogHistori();
        $log->tabel_asal = $tabelAsal;
        $log->id_entitas = $idEntitas;
        $log->aksi = $aksi;
        $log->waktu = now();
        $log->pengguna = $pengguna;
        $log->data_lama = $dataLama;
        $log->data_baru = $dataBaru;
        $log->save();
    }


    public function createForm(): View
    {
        $title = "Halaman Modul";
        $subtitle = "Menu Modul";
        return view('create_resource_form', compact('title', 'subtitle'));
    }



    public function createResource(Request $request)
    {
        $tableName = $request->input('nama_table'); // Nama tabel tetap jamak
        $fields = $request->input('fields');

        // Validasi: cek apakah tabel sudah ada di database
        if (Schema::hasTable($tableName)) {
            return redirect()->back()->withErrors(['nama_table' => 'Tabel dengan nama tersebut sudah ada di database.'])->withInput();
        }

        // Menggunakan nama tabel untuk model, controller, dan folder view dalam bentuk tunggal
        $resourceName = Str::singular($tableName); // Nama resource dalam bentuk tunggal
        $modelName = Str::studly($resourceName); // Nama model
        $controllerName = "{$modelName}Controller"; // Nama controller
        $controllerNamespace = "App\\Http\\Controllers\\{$controllerName}";
        $resourceRoute = "    Route::resource('{$resourceName}', {$controllerName}::class);\n";
        $useController = "use {$controllerNamespace};\n";

        // Membuat migration
        Artisan::call('make:migration', [
            'name' => "create_{$tableName}_table"
        ]);

        // Mengisi migration dengan field-field
        $migrationFile = database_path('migrations/' . now()->format('Y_m_d_His') . "_create_{$tableName}_table.php");
        if (File::exists($migrationFile)) {
            $content = File::get($migrationFile);
            $fieldsMigration = '';

            foreach ($fields as $field) {
                $fieldsMigration .= "\$table->{$field['type']}('{$field['name']}');\n            ";
            }

            $content = str_replace(
                '$table->id();',
                "\$table->id();\n            $fieldsMigration",
                $content
            );

            File::put($migrationFile, $content);
        }

        // Menjalankan migrasi hanya pada file migrasi baru
        $migrationRelativePath = 'database/migrations/' . basename($migrationFile);
        Artisan::call('migrate', [
            '--path' => $migrationRelativePath
        ]);

        // Membuat model dengan nama tunggal
        Artisan::call('make:model', [
            'name' => $modelName
        ]);

        // Menambahkan properti $table dan $guarded pada model
        $modelFile = app_path("Models/{$modelName}.php");
        if (File::exists($modelFile)) {
            $modelContent = File::get($modelFile);
            $modelContent = str_replace(
                'class ' . $modelName,
                "class {$modelName}\n{\n    protected \$table = '{$tableName}';\n    protected \$guarded = [];\n",
                $modelContent
            );
            File::put($modelFile, $modelContent);
        }

        // Membuat controller dengan resource
        Artisan::call('make:controller', [
            'name' => $controllerName,
            '--resource' => true
        ]);

        // Membuat folder views dengan nama tunggal
        $viewFolderPath = resource_path("views/{$resourceName}");
        if (!File::exists($viewFolderPath)) {
            File::makeDirectory($viewFolderPath, 0755, true);
        }

        // Membuat file view dasar (index, create, edit, show)
        $views = ['index', 'create', 'edit', 'show'];
        foreach ($views as $view) {
            File::put("$viewFolderPath/$view.blade.php", "<!-- Halaman $view untuk $modelName -->");
        }

        // Menambahkan use statement dan route baru di dalam grup middleware 'auth' di web.php
        $webRouteFile = base_path('routes/web.php');
        $routeGroupStart = "Route::group(['middleware' => ['auth']], function () {";

        if (File::exists($webRouteFile)) {
            $content = File::get($webRouteFile);

            // Tambahkan use statement di bagian atas file jika belum ada
            if (strpos($content, $useController) === false) {
                $content = preg_replace("/(<\?php\n)/", "$1$useController", $content);
            }

            // Cari posisi grup 'auth' dan tambahkan route resource baru di dalamnya
            if (strpos($content, $routeGroupStart) !== false) {
                $content = preg_replace(
                    "/(Route::group\(\['middleware' => \['auth'\]\], function \(\) \{)/",
                    "$1\n$resourceRoute",
                    $content
                );
                File::put($webRouteFile, $content);
            }
        }

        // Menyimpan log histori proses pembuatan resource
        $loggedInUserId = Auth::id();
        $this->simpanLogHistori(
            'Create',
            'Resource Creation',
            null,
            $loggedInUserId,
            json_encode(['table_name' => $tableName, 'fields' => $fields]),
            json_encode(['model' => $modelName, 'controller' => $controllerName, 'views' => $views])
        );

        return redirect()->route('resource.create')->with('success', "Resource untuk tabel {$tableName} berhasil dibuat dengan nama resource {$resourceName}.");
    }
}
