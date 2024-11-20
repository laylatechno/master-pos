<?php

namespace App\Http\Controllers;

use App\Models\LogHistori;
use App\Models\Stimuli;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class StimuliController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:stimuli-list|stimuli-create|stimuli-edit|stimuli-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:stimuli-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:stimuli-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:stimuli-delete', ['only' => ['destroy']]);
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
        $title = "Halaman Stimulus";
        $subtitle = "Menu Stimulus";
        $data_stimuli = Stimuli::all();
        return view('stimuli.index', compact('data_stimuli', 'title', 'subtitle'));
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Stimulus";
        $subtitle = "Menu Tambah Stimulus";
        return view('stimuli.create', compact('title', 'subtitle'));
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
            'name' => 'required|unique:stimuli,name',
            'description' => 'required',
            'position' => 'required',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'description.required' => 'Deskripsi wajib diisi.',
            'position.required' => 'Urutan wajib diisi.',
        ]);

        $stimuli = Stimuli::create($request->all());

        $loggedInUserId = Auth::id();
        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Stimulus', $stimuli->id, $loggedInUserId, null, json_encode($stimuli));
        return redirect()->route('stimuli.index')
            ->with('success', 'Stimulus berhasil dibuat.');
    }





    /**
     * Display the specified resource.
     *
     * @param  \App\Stimuli  $stimuli
     * @return \Illuminate\Http\Response
     */
    public function show($id): View

    {
        $title = "Halaman Lihat Stimulus";
        $subtitle = "Menu Lihat Stimulus";
        $data_stimuli = Stimuli::find($id);
        return view('stimuli.show', compact('data_stimuli', 'title', 'subtitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Stimuli  $stimuli
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Stimulus";
        $subtitle = "Menu Edit Stimulus";
        $data_stimuli = Stimuli::findOrFail($id); // Data menu item yang sedang diedit

        return view('stimuli.edit', compact('data_stimuli', 'title', 'subtitle'));
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Stimuli  $stimuli
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
        $stimuli = Stimuli::find($id);

        // Jika data tidak ditemukan
        if (!$stimuli) {
            return redirect()->route('stimuli.index')
                ->with('error', 'Data Stimulus tidak ditemukan.');
        }

        // Menyimpan data lama sebelum update
        $oldAspekPerkembanganData = $stimuli->toArray();

        // Melakukan update data
        $stimuli->update($request->all());

        // Mendapatkan ID pengguna yang sedang login
        $loggedInUserId = Auth::id();

        // Mendapatkan data baru setelah update
        $newAspekPerkembanganData = $stimuli->fresh()->toArray();

        // Menyimpan log histori untuk operasi Update
        $this->simpanLogHistori('Update', 'Stimulus', $stimuli->id, $loggedInUserId, json_encode($oldAspekPerkembanganData), json_encode($newAspekPerkembanganData));

        return redirect()->route('stimuli.index')
            ->with('success', 'Stimulus berhasil diperbaharui');
    }



    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Stimuli  $stimuli
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $stimuli = Stimuli::find($id);
        $stimuli->delete();
        $loggedInStimuliId = Auth::id();
        // Simpan log histori untuk operasi Delete dengan stimuli_id yang sedang login dan informasi data yang dihapus
        $this->simpanLogHistori('Delete', 'Stimulus', $id, $loggedInStimuliId, json_encode($stimuli), null);
        // Redirect kembali dengan pesan sukses
        return redirect()->route('stimuli.index')->with('success', 'Stimulus berhasil dihapus');
    }
}
