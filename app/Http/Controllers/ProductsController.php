<?php

namespace App\Http\Controllers;

use App\Models\LogHistori;
use App\Models\Product;
use App\Models\Products;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;

class ProductsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:product-list|product-create|product-edit|product-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:product-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:product-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:product-delete', ['only' => ['destroy']]);
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
        $title = "Halaman Produk";
        $subtitle = "Menu Produk";
        $data_product = Product::all();
        return view('product.index', compact('data_product', 'title', 'subtitle'));
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Produk";
        $subtitle = "Menu Tambah Produk";
        return view('product.create', compact('title', 'subtitle'));
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
            'name' => 'required|unique:products,name',
            'description' => 'required',
            'price' => 'required',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:4048',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'description.required' => 'Deskripsi wajib diisi.',
            'price.required' => 'Harga wajib diisi.',
            'image.required' => 'Gambar Sldier wajib diisi.',
            'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
            'image.mimes' => 'Format image harus jpeg, jpg, atau png',
            'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
        ]);

        // Menghapus separator koma/titik dari input price
        $request->merge([
            'price' => str_replace(',', '', $request->price),
        ]);

        $input = $request->all();



        // Jika ada file image, proses image
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/products/';

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

        $product = Product::create($input);
        $loggedInUserId = Auth::id();
        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Produk', $product->id, $loggedInUserId, null, json_encode($product));

        return redirect()->route('products.index')
            ->with('success', 'Produk berhasil dibuat.');
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Products  $product
     * @return \Illuminate\Http\Response
     */
    public function show($id): View

    {
        $title = "Halaman Lihat Produk";
        $subtitle = "Menu Lihat Produk";
        $data_product = Product::find($id);
        return view('product.show', compact('data_product', 'title', 'subtitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Products  $product
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Produk";
        $subtitle = "Menu Edit Produk";
        $data_product = Product::findOrFail($id); // Data menu item yang sedang diedit

        return view('product.edit', compact('data_product', 'title', 'subtitle'));
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Products  $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id): RedirectResponse
    {
        $this->validate($request, [
            'name' => 'required',
            'description' => 'required',
            'price' => 'required',
            'image' => 'image|mimes:jpeg,png,jpg,gif,webp|max:4048',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'description.required' => 'Deskripsi wajib diisi.',
            'price.required' => 'Harga wajib diisi.',
            'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
            'image.mimes' => 'Format image harus jpeg, jpg, atau png',
            'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
        ]);

        // Ambil data produk yang akan diupdate
        $products = Product::findOrFail($id);

        // Simpan data lama sebelum update
        $oldData = $products->toArray();

        $request->merge([
            'price' => str_replace(',', '', $request->price),
        ]);
        // Inisialisasi input dari request
        $input = $request->all();

        // Jika ada file image, proses image
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/products/';

            // Hapus image lama jika ada
            if ($products->image) {
                $oldImagePath = public_path($destinationPath . $products->image);
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
        $products->update($input);

        // Simpan data baru setelah update
        $newData = $products->toArray();

        // Mendapatkan ID pengguna yang sedang login
        $loggedInUserId = Auth::id();

        // Simpan log histori untuk operasi Update dengan data lama dan baru
        $this->simpanLogHistori('Update', 'Produk', $products->id, $loggedInUserId, json_encode($oldData), json_encode($newData));

        return redirect()->route('products.index')
            ->with('success', 'Produk berhasil diperbaharui');
    }




    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Products  $product
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $product = Product::find($id);
    
        if (!$product) {
            return response()->json(['message' => 'Data produk tidak ditemukan'], 404);
        }
    
        // Periksa apakah ada data terkait di tabel achievement_products
        $relatedAchievements = \DB::table('achievement_products')
            ->where('product_id', $id)
            ->exists();
    
        if ($relatedAchievements) {
            return redirect()->route('products.index')->with('error', 'Produk tidak dapat dihapus karena masih terkait dengan data pencapaian.');
        }
    
        $oldimageFileName = $product->image; // Nama file saja
        $oldfilePath = public_path('upload/products/' . $oldimageFileName);
    
        if ($oldimageFileName && file_exists($oldfilePath)) {
            unlink($oldfilePath);
        }
    
        $product->delete();
        $loggedInProductsId = Auth::id();
        
        // Simpan log histori untuk operasi Delete dengan product_id yang sedang login dan informasi data yang dihapus
        $this->simpanLogHistori('Delete', 'Produk', $id, $loggedInProductsId, json_encode($product), null);
    
        // Redirect kembali dengan pesan sukses
        return redirect()->route('products.index')->with('success', 'Produk berhasil dihapus.');
    }
    
}
