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
        $tableName = $request->input('nama_table');
        $fields = $request->input('fields');

        // Validasi: cek apakah tabel sudah ada di database
        if (Schema::hasTable($tableName)) {
            return redirect()->back()->withErrors(['nama_table' => 'Tabel dengan nama tersebut sudah ada di database.'])->withInput();
        }

        // Validasi: cek apakah migrasi sudah ada
        $migrationFile = database_path('migrations/' . now()->format('Y_m_d_His') . "_create_{$tableName}_table.php");
        if (File::exists($migrationFile)) {
            return redirect()->back()->withErrors(['nama_table' => 'Migrasi untuk tabel ini sudah ada.'])->withInput();
        }

        // Lanjutkan proses pembuatan resource
        Log::info('Fields received:', $fields);

        // Menggunakan nama tabel langsung untuk model dan controller tanpa perubahan singular/plural
        $modelName = Str::studly($tableName);
        $controllerName = "{$modelName}Controller";
        $controllerNamespace = "App\\Http\\Controllers\\{$controllerName}";
        $resourceRoute = "    Route::resource('{$tableName}', {$controllerName}::class);\n";
        $useController = "use {$controllerNamespace};\n";

        // Membuat migration
        Artisan::call('make:migration', [
            'name' => "create_{$tableName}_table"
        ]);

        // Mengisi migration dengan field-field
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

        // Membuat model tanpa perubahan nama
        Artisan::call('make:model', [
            'name' => $modelName
        ]);

        // Membuat controller dengan resource
        Artisan::call('make:controller', [
            'name' => $controllerName,
            '--resource' => true
        ]);

        // Membuat folder views jika belum ada
        $viewFolderPath = resource_path("views/{$tableName}");
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

        // Menjalankan migrasi untuk membuat tabel di database
        Artisan::call('migrate');

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

        return redirect()->route('resource.create')->with('success', "Resource untuk tabel {$tableName} berhasil dibuat dan route ditambahkan.");
    }
}
