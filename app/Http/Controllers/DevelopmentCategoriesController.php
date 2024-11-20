<?php

namespace App\Http\Controllers;

use App\Models\LogHistori;
use App\Models\DevelopmentCategory;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class DevelopmentCategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:developmentcategory-list|developmentcategory-create|developmentcategory-edit|developmentcategory-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:developmentcategory-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:developmentcategory-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:developmentcategory-delete', ['only' => ['destroy']]);
    }

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


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request): View
    {
        $title = "Halaman Aspek Perkembangan";
        $subtitle = "Menu Aspek Perkembangan";
        $data_development_categories = DevelopmentCategory::all();
        return view('development_category.index', compact('data_development_categories', 'title', 'subtitle'));
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Aspek Perkembangan";
        $subtitle = "Menu Tambah Aspek Perkembangan";
        return view('development_category.create', compact('title', 'subtitle'));
    }



    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request): RedirectResponse
    {
        $this->validate($request, [
            'name' => 'required|unique:development_categories,name',
            'description' => 'required',
            'position' => 'required',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'description.required' => 'Deskripsi wajib diisi.',
            'position.required' => 'Urutan wajib diisi.',
        ]);

        $development_categories = DevelopmentCategory::create($request->all());

        $loggedInUserId = Auth::id();
        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Aspek Perkembangan', $development_categories->id, $loggedInUserId, null, json_encode($development_categories));
        return redirect()->route('development_categories.index')
            ->with('success', 'Aspek Perkembangan berhasil dibuat.');
    }





    /**
     * Display the specified resource.
     *
     * @param  \App\DevelopmentCategory  $development_categories
     * @return \Illuminate\Http\Response
     */
    public function show($id): View

    {
        $title = "Halaman Lihat Aspek Perkembangan";
        $subtitle = "Menu Lihat Aspek Perkembangan";
        $data_development_categories = DevelopmentCategory::find($id);
        return view('development_category.show', compact('data_development_categories', 'title', 'subtitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\DevelopmentCategory  $development_categories
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Aspek Perkembangan";
        $subtitle = "Menu Edit Aspek Perkembangan";
        $data_development_categories = DevelopmentCategory::findOrFail($id); // Data menu item yang sedang diedit

        return view('development_category.edit', compact('data_development_categories', 'title', 'subtitle'));
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\DevelopmentCategory  $development_categories
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id): RedirectResponse
    {
        // Validasi input
        $this->validate($request, [
            'name' => 'required',
            'description' => 'required',
            'position' => 'required',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'description.required' => 'Deskripsi wajib diisi.',
            'position.required' => 'Posisi wajib diisi.',
        ]);

        // Cari data berdasarkan ID
        $development_categories = DevelopmentCategory::find($id);

        // Jika data tidak ditemukan
        if (!$development_categories) {
            return redirect()->route('development_categories.index')
                ->with('error', 'Data Aspek Perkembangan tidak ditemukan.');
        }

        // Menyimpan data lama sebelum update
        $oldAspekPerkembanganData = $development_categories->toArray();

        // Melakukan update data
        $development_categories->update($request->all());

        // Mendapatkan ID pengguna yang sedang login
        $loggedInUserId = Auth::id();

        // Mendapatkan data baru setelah update
        $newAspekPerkembanganData = $development_categories->fresh()->toArray();

        // Menyimpan log histori untuk operasi Update
        $this->simpanLogHistori('Update', 'Aspek Perkembangan', $development_categories->id, $loggedInUserId, json_encode($oldAspekPerkembanganData), json_encode($newAspekPerkembanganData));

        return redirect()->route('development_categories.index')
            ->with('success', 'Aspek Perkembangan berhasil diperbaharui');
    }



    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\DevelopmentCategory  $development_categories
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $development_categories = DevelopmentCategory::find($id);
        $development_categories->delete();
        $loggedInDevelopmentCategoryId = Auth::id();
        // Simpan log histori untuk operasi Delete dengan development_categories_id yang sedang login dan informasi data yang dihapus
        $this->simpanLogHistori('Delete', 'Aspek Perkembangan', $id, $loggedInDevelopmentCategoryId, json_encode($development_categories), null);
        // Redirect kembali dengan pesan sukses
        return redirect()->route('development_categories.index')->with('success', 'Aspek Perkembangan berhasil dihapus');
    }
}
