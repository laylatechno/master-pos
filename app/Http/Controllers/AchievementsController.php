<?php

namespace App\Http\Controllers;

use App\Models\Achievement;
use App\Models\LogHistori;
use App\Models\Achievements;
use App\Models\DevelopmentCategory;
use App\Models\Product;
use App\Models\Products;
use App\Models\Stimuli;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class AchievementsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:achievement-list|achievement-create|achievement-edit|achievement-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:achievement-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:achievement-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:achievement-delete', ['only' => ['destroy']]);
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
        $title = "Halaman Pencapaian";
        $subtitle = "Menu Pencapaian";

        // Ambil data untuk dropdown select
        $developmentCategories = DevelopmentCategory::all(); // Ambil semua kategori perkembangan
        $stimuli = Stimuli::all(); // Ambil semua stimuli
        $products = Product::all(); // Ambil semua produk

        // Ambil data pencapaian
        $data_achievement = Achievement::all();

        // Kirim semua data ke view
        return view('achievement.index', compact('data_achievement', 'developmentCategories', 'stimuli', 'products', 'title', 'subtitle'));
    }




    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Pencapaian";
        $subtitle = "Menu Tambah Pencapaian";
    
        // Ambil data untuk dropdown select
        $developmentCategories = DevelopmentCategory::all(); // Ambil semua kategori perkembangan
        $stimuli = Stimuli::all(); // Ambil semua stimuli
        $products = Product::all(); // Ambil semua produk
    
        // Kirim data ke view
        return view('achievement.create', compact('title', 'subtitle', 'developmentCategories', 'stimuli', 'products'));
    }
    



    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request): RedirectResponse
    {
        // Validasi data yang diperlukan
        $this->validate($request, [
            'name' => 'required|unique:achievements,name',
            'development_category_id' => 'required|exists:development_categories,id', // pastikan kategori perkembangan valid
            'stimuli_ids' => 'required|array', // Stimuli harus berupa array
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'development_category_id.required' => 'Aspek perkembangan wajib dipilih.',
            'stimuli_ids.required' => 'Stimuli wajib dipilih.',
        ]);
    
        // Menyaring input kecuali product_ids dan stimuli_ids
        $achievementData = $request->except(['product_ids', 'stimuli_ids']);
    
        // Membuat pencapaian baru
        $achievement = Achievement::create($achievementData);
    
         // Menyambungkan relasi many-to-many dengan tabel lainnya
         $achievement->stimuli()->sync($request->stimuli_ids); // Menyimpan Stimuli
         $achievement->products()->sync($request->product_ids); // Menyimpan Produk
    
        // Mendapatkan user yang sedang login
        $loggedInUserId = Auth::id();
    
        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Pencapaian', $achievement->id, $loggedInUserId, null, json_encode($achievement));
    
        // Redirect dengan pesan sukses
        return redirect()->route('achievements.index')
            ->with('success', 'Pencapaian berhasil dibuat.');
    }
    




    /**
     * Display the specified resource.
     *
     * @param  \App\Achievements  $achievement
     * @return \Illuminate\Http\Response
     */
    public function show($id): View

    {
        $title = "Halaman Lihat Pencapaian";
        $subtitle = "Menu Lihat Pencapaian";
        $data_achievement = Achievement::with(['stimuli', 'products'])->findOrFail($id);

        return view('achievement.show', compact('data_achievement', 'title', 'subtitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Achievements  $achievement
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Pencapaian";
        $subtitle = "Menu Edit Pencapaian";
    
        // Ambil data untuk dropdown select
        $developmentCategories = DevelopmentCategory::all(); // Ambil semua kategori perkembangan
        $stimuli = Stimuli::all(); // Ambil semua stimuli
        $products = Product::all(); // Ambil semua produk
    
        // Data pencapaian yang sedang diedit
        $data_achievement = Achievement::findOrFail($id);
    
        // Kirim data ke view
        return view('achievement.edit', compact('data_achievement', 'title', 'subtitle', 'developmentCategories', 'stimuli', 'products'));
    }
    
    
    



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Achievements  $achievement
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id): RedirectResponse
    {
        // Validasi input
        $this->validate($request, [
            'name' => 'required',
            'description' => 'required',
            'position' => 'required',
            'development_category_id' => 'required|exists:development_categories,id', // Validasi untuk kategori perkembangan
        ], [
            'name.required' => 'Nama wajib diisi.',
            'description.required' => 'Deskripsi wajib diisi.',
            'position.required' => 'Posisi wajib diisi.',
            'development_category_id.required' => 'Kategori Perkembangan wajib dipilih.',
            'development_category_id.exists' => 'Kategori Perkembangan tidak valid.',
        ]);
    
        // Cari data berdasarkan ID
        $achievement = Achievement::find($id);
    
        // Jika data tidak ditemukan
        if (!$achievement) {
            return redirect()->route('achievement.index')
                ->with('error', 'Data Pencapaian tidak ditemukan.');
        }
    
        // Menyimpan data lama sebelum update
        $oldAspekPerkembanganData = $achievement->toArray();
    
        // Melakukan update data
        $achievement->update([
            'name' => $request->input('name'),
            'description' => $request->input('description'),
            'position' => $request->input('position'),
            'duration' => $request->input('duration'),
            'age' => $request->input('age'),
            'development_category_id' => $request->input('development_category_id'),
        ]);
    
        // Update relasi many-to-many (Stimuli dan Produk)
        $achievement->stimuli()->sync($request->input('stimuli_ids', []));
        $achievement->products()->sync($request->input('product_ids', []));
    
        // Mendapatkan ID pengguna yang sedang login
        $loggedInUserId = Auth::id();
    
        // Mendapatkan data baru setelah update
        $newAspekPerkembanganData = $achievement->fresh()->toArray();
    
        // Menyimpan log histori untuk operasi Update
        $this->simpanLogHistori('Update', 'Pencapaian', $achievement->id, $loggedInUserId, json_encode($oldAspekPerkembanganData), json_encode($newAspekPerkembanganData));
    
        return redirect()->route('achievements.index')
            ->with('success', 'Pencapaian berhasil diperbaharui');
    }
    



    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Achievements  $achievement
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        // Cari pencapaian berdasarkan ID
        $achievement = Achievement::findOrFail($id);
    
        // Menghapus relasi many-to-many terlebih dahulu (jika ada)
        $achievement->stimuli()->detach(); // Menghapus relasi dengan stimuli
        $achievement->products()->detach(); // Menghapus relasi dengan produk
    
        // Hapus pencapaian dari tabel achievements
        $achievement->delete();
    
        // Mendapatkan ID pengguna yang sedang login
        $loggedInAchievementsId = Auth::id();
    
        // Simpan log histori untuk operasi Delete
        $this->simpanLogHistori('Delete', 'Pencapaian', $id, $loggedInAchievementsId, json_encode($achievement), null);
    
        // Redirect kembali dengan pesan sukses
        return redirect()->route('achievements.index')->with('success', 'Pencapaian berhasil dihapus');
    }
    
}
