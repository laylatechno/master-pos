<?php

namespace App\Http\Controllers;

use App\Models\LogHistori;
use App\Models\Slider;
use App\Models\Sliders;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class SlidersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:slider-list|slider-create|slider-edit|slider-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:slider-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:slider-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:slider-delete', ['only' => ['destroy']]);
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
        $title = "Halaman Slider";
        $subtitle = "Menu Slider";
        $data_slider = Slider::all();
        return view('slider.index', compact('data_slider', 'title', 'subtitle'));
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Slider";
        $subtitle = "Menu Tambah Slider";
        return view('slider.create', compact('title', 'subtitle'));
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
            'name' => 'required|unique:sliders,name',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:4048',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'image.required' => 'Gambar Slider wajib diisi.',
            'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
            'image.mimes' => 'Format image harus jpeg, jpg, atau png',
            'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
        ]);


        $input = $request->all();

       

        // Jika ada file image, proses image
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/sliders/';

            $originalFileName = $image->getClientOriginalName();
            $imageMimeType = $image->getMimeType();

            if (strpos($imageMimeType, 'image/') === 0) {
                $imageName = date('YmdHis') . '_' . str_replace(' ', '_', $originalFileName);
                $image->move($destinationPath, $imageName);

                $sourceImagePath = public_path($destinationPath . $imageName);
                $webpImagePath = $destinationPath . pathinfo($imageName, PATHINFO_FILENAME) . '.webp';

                switch ($imageMimeType) {
                    case 'image/jpeg':
                        $sourceImage = @imagecreatefromjpeg($sourceImagePath);
                        break;
                    case 'image/png':
                        $sourceImage = @imagecreatefrompng($sourceImagePath);
                        break;
                    default:
                        throw new \Exception('Tipe MIME tidak didukung.');
                }

                if ($sourceImage !== false) {
                    imagewebp($sourceImage, $webpImagePath);
                    imagedestroy($sourceImage);
                    @unlink($sourceImagePath);
                    $input['image'] = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';
                } else {
                    throw new \Exception('Gagal membaca image asli.');
                }
            } else {
                throw new \Exception('Tipe MIME image tidak didukung.');
            }
        } else {
            $input['image'] = ''; // Jika tidak ada image yang diunggah
        }

        $slider = Slider::create($input);
        $loggedInUserId = Auth::id();
        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Slider', $slider->id, $loggedInUserId, null, json_encode($slider));

        return redirect()->route('sliders.index')
            ->with('success', 'Slider berhasil dibuat.');
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Sliders  $slider
     * @return \Illuminate\Http\Response
     */
    public function show($id): View

    {
        $title = "Halaman Lihat Slider";
        $subtitle = "Menu Lihat Slider";
        $data_slider = Slider::find($id);
        return view('slider.show', compact('data_slider', 'title', 'subtitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Sliders  $slider
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Slider";
        $subtitle = "Menu Edit Slider";
        $data_slider = Slider::findOrFail($id); // Data menu item yang sedang diedit

        return view('slider.edit', compact('data_slider', 'title', 'subtitle'));
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Sliders  $slider
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id): RedirectResponse
{
    $this->validate($request, [
        'name' => 'required',
        'image' => 'image|mimes:jpeg,png,jpg,gif,webp|max:4048',
    ], [
        'name.required' => 'Nama wajib diisi.',
        'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
        'image.mimes' => 'Format image harus jpeg, jpg, atau png',
        'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
    ]);

    // Ambil data produk yang akan diupdate
    $sliders = Slider::findOrFail($id);

    // Simpan data lama sebelum update
    $oldData = $sliders->toArray();

  
    // Inisialisasi input dari request
    $input = $request->all();

    // Jika ada file image, proses image
    if ($image = $request->file('image')) {
        $destinationPath = 'upload/sliders/';

        // Hapus image lama jika ada
        if ($sliders->image) {
            $oldImagePath = public_path($destinationPath . $sliders->image);
            if (file_exists($oldImagePath)) {
                @unlink($oldImagePath); // Hapus image lama
            }
        }

        // Ambil nama file asli dan ekstensinya
        $originalFileName = $image->getClientOriginalName();
        $imageMimeType = $image->getMimeType();

        // Hanya tipe MIME image yang didukung
        if (strpos($imageMimeType, 'image/') === 0) {
            // Generate nama file baru
            $imageName = date('YmdHis') . '_' . str_replace(' ', '_', $originalFileName);
            $image->move($destinationPath, $imageName);

            // Path file asli dan WebP
            $sourceImagePath = public_path($destinationPath . $imageName);
            $webpImagePath = $destinationPath . pathinfo($imageName, PATHINFO_FILENAME) . '.webp';

            // Konversi image ke WebP
            switch ($imageMimeType) {
                case 'image/jpeg':
                    $sourceImage = @imagecreatefromjpeg($sourceImagePath);
                    break;
                case 'image/png':
                    $sourceImage = @imagecreatefrompng($sourceImagePath);
                    break;
                default:
                    throw new \Exception('Tipe MIME tidak didukung.');
            }

            if ($sourceImage !== false) {
                // Simpan sebagai WebP dan hapus file asli
                imagewebp($sourceImage, $webpImagePath);
                imagedestroy($sourceImage);
                @unlink($sourceImagePath);

                // Simpan nama file WebP ke database
                $input['image'] = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';
            } else {
                throw new \Exception('Gagal membaca image asli.');
            }
        } else {
            throw new \Exception('Tipe MIME image tidak didukung.');
        }
    }

    // Update data produk
    $sliders->update($input);

    // Simpan data baru setelah update
    $newData = $sliders->toArray();

    // Mendapatkan ID pengguna yang sedang login
    $loggedInUserId = Auth::id();

    // Simpan log histori untuk operasi Update dengan data lama dan baru
    $this->simpanLogHistori('Update', 'Slider', $sliders->id, $loggedInUserId, json_encode($oldData), json_encode($newData));

    return redirect()->route('sliders.index')
        ->with('success', 'Slider berhasil diperbaharui');
}




    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Sliders  $slider
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $slider = Slider::find($id);

        if (!$slider) {
            return response()->json(['message' => 'Data slider not found'], 404);
        }

        $oldimageFileName = $slider->image; // Nama file saja
        $oldfilePath = public_path('upload/sliders/' . $oldimageFileName);

        if ($oldimageFileName && file_exists($oldfilePath)) {
            unlink($oldfilePath);
        }

       
        $slider->delete();
        $loggedInSlidersId = Auth::id();
        // Simpan log histori untuk operasi Delete dengan slider_id yang sedang login dan informasi data yang dihapus
        $this->simpanLogHistori('Delete', 'Slider', $id, $loggedInSlidersId, json_encode($slider), null);
        // Redirect kembali dengan pesan sukses
        return redirect()->route('sliders.index')->with('success', 'Slider berhasil dihapus');
    }
}
