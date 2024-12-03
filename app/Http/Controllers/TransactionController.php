<?php

namespace App\Http\Controllers;

use App\Models\Cash;
use App\Models\LogHistori;
use App\Models\Transaction;
use App\Models\Category;
use App\Models\CustomerCategory;
use App\Models\TransactionCategory;
use App\Models\TransactionPrice;
use App\Models\Unit;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class TransactionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:transaction-list|transaction-create|transaction-edit|transaction-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:transaction-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:transaction-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:transaction-delete', ['only' => ['destroy']]);
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
        $title = "Halaman Transaksi";
        $subtitle = "Menu Transaksi";

        // Ambil data untuk dropdown select
        $data_transaction_categories = TransactionCategory::all(); // Ambil semua stimuli
        $data_cash = Cash::all(); // Ambil semua produk
        $data_transactions = Transaction::all();


        // Kirim semua data ke view
        return view('transaction.index', compact('data_transaction_categories', 'data_cash', 'data_transactions', 'title', 'subtitle'));
    }


   
    

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Transaksi";
        $subtitle = "Menu Tambah Transaksi";

        // Ambil data untuk dropdown select
        $data_units = Unit::all(); // Ambil semua kategori perkembangan
        $data_categories = Category::all(); // Ambil semua stimuli
        $data_customer_categories = CustomerCategory::all();

        // Kirim data ke view
        return view('transaction.create', compact('title', 'subtitle', 'data_customer_categories', 'data_units', 'data_categories'));
    }




    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */






    public function store(Request $request): RedirectResponse
    {
        // Validasi data produk utama
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:transactions,name',
            'category_id' => 'required|exists:categories,id',
            'unit_id' => 'required|exists:units,id',
            'purchase_price' => 'required',
            'cost_price' => 'required',
            'stock' => 'nullable|integer',
            'reminder' => 'nullable|integer',
            'description' => 'nullable|string',
            // Validasi untuk kategori dan harga konsumen
            'customer_category_id.*' => 'nullable|exists:customer_categories,id',
            'customer_price.*' => 'nullable',
            'image' => 'image|mimes:jpeg,png,jpg,gif,webp|max:4048',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.unique' => 'Nama sudah terdaftar.',
            'category_id.required' => 'Kategori produk wajib dipilih.',
            'category_id.exists' => 'Kategori tidak valid.',
            'unit_id.required' => 'Satuan produk wajib dipilih.',
            'unit_id.exists' => 'Satuan tidak valid.',
            'purchase_price.required' => 'Harga beli produk wajib diisi.',
            'purchase_price.required' => 'Harga jual produk wajib diisi.',
            'customer_category_id.*.exists' => 'Kategori konsumen tidak valid.',
            'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
            'image.mimes' => 'Format gambar harus jpeg, jpg, atau png',
            'image.max' => 'Ukuran gambar tidak boleh lebih dari 4 MB',
        ]);

        // Validasi khusus untuk duplikasi kategori konsumen
        $customerCategoryIds = $request->input('customer_category_id', []);
        if (count($customerCategoryIds) !== count(array_unique($customerCategoryIds))) {
            $validator->errors()->add('customer_category_id', 'Terdapat duplikasi kategori konsumen.');
        }

        // Jika validasi gagal
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        // Membersihkan data harga dari karakter koma
        $data = $request->all();
        $data['purchase_price'] = str_replace(',', '', $data['purchase_price']);
        if (!empty($data['cost_price'])) {
            $data['cost_price'] = str_replace(',', '', $data['cost_price']);
        }

        // Hilangkan data 'customer_category_id' dan 'customer_price' dari array sebelum menyimpan produk
        unset($data['customer_category_id']);
        unset($data['customer_price']);

        // Proses image jika ada file yang diupload
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/transactions/';
            $originalFileName = $image->getClientOriginalName();
            $imageMimeType = $image->getMimeType();

            // Memastikan file adalah gambar
            if (strpos($imageMimeType, 'image/') === 0) {
                $imageName = date('YmdHis') . '_' . str_replace(' ', '_', $originalFileName);
                $image->move($destinationPath, $imageName);

                $sourceImagePath = public_path($destinationPath . $imageName);
                $webpImagePath = $destinationPath . pathinfo($imageName, PATHINFO_FILENAME) . '.webp';

                // Mengubah gambar ke format webp
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

                // Jika gambar berhasil dibaca, konversi ke WebP dan hapus gambar asli
                if ($sourceImage !== false) {
                    imagewebp($sourceImage, $webpImagePath);
                    imagedestroy($sourceImage);
                    @unlink($sourceImagePath); // Menghapus file gambar asli
                    $data['image'] = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';  // Menggunakan $data, bukan $input
                } else {
                    throw new \Exception('Gagal membaca gambar asli.');
                }
            } else {
                throw new \Exception('Tipe MIME gambar tidak didukung.');
            }
        } else {
            $data['image'] = ''; // Jika tidak ada image yang diupload
        }

        // Menyimpan data produk ke database
        $transaction = Transaction::create($data);

        // Menyimpan harga konsumen tambahan jika ada
        if ($request->has('customer_category_id')) {
            foreach ($request->customer_category_id as $index => $categoryId) {
                $customerPrice = str_replace(',', '', $request->customer_price[$index] ?? null);
                if ($categoryId && $customerPrice) {
                    // Simpan harga untuk kategori pelanggan di tabel transaction_prices
                    $transaction->transactionPrices()->create([
                        'customer_category_id' => $categoryId,
                        'price' => $customerPrice,
                    ]);
                }
            }
        }

        $loggedInUserId = Auth::id();

        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Transaksi', $transaction->id, $loggedInUserId, null, json_encode($transaction));

        // Redirect ke halaman produk dengan pesan sukses
        return redirect()->route('transactions.index')
            ->with('success', 'Transaksi berhasil dibuat.');
    }







    /**
     * Display the specified resource.
     *
     * @param  \App\Transactions  $transaction
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        // Ambil data produk dengan relasi 'category', 'unit', dan 'transactionPrices.customerCategory'
        $data_transaction = Transaction::with(['category', 'unit', 'transactionPrices.customerCategory'])
            ->findOrFail($id);

        // Judul untuk halaman
        $title = "Halaman Lihat Transaksi";
        $subtitle = "Menu Lihat Transaksi";

        // Kembalikan view dengan membawa data produk
        return view('transaction.show', compact('data_transaction', 'title', 'subtitle'));
    }


    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Transactions  $transaction
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Transaksi";
        $subtitle = "Menu Edit Transaksi";

        // Ambil data produk yang sedang diedit
        $data_transaction = Transaction::findOrFail($id);

        // Ambil data terkait lainnya
        $data_units = Unit::all(); // Ambil semua unit
        $data_categories = Category::all(); // Ambil semua kategori
        $data_customer_categories = CustomerCategory::all(); // Ambil semua kategori konsumen
        $data_prices = TransactionPrice::where('transaction_id', $data_transaction->id)->get(); // Ambil harga berdasarkan ID produk yang sedang diedit

        // Kirim data ke view
        return view('transaction.edit', compact(
            'data_transaction',
            'title',
            'subtitle',
            'data_customer_categories',
            'data_units',
            'data_categories',
            'data_prices'
        ));
    }






    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Transactions  $transaction
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id): RedirectResponse
    {
        // Validasi data produk utama
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'category_id' => 'required|exists:categories,id',
            'unit_id' => 'required|exists:units,id',
            'purchase_price' => 'required',
            'cost_price' => 'required',
            'stock' => 'nullable|integer',
            'reminder' => 'nullable|integer',
            'description' => 'nullable|string',
            // Validasi untuk kategori dan harga konsumen
            'customer_category_id.*' => 'nullable|exists:customer_categories,id',
            'customer_price.*' => 'nullable',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:4048',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'category_id.required' => 'Kategori produk wajib dipilih.',
            'category_id.exists' => 'Kategori tidak valid.',
            'unit_id.required' => 'Satuan produk wajib dipilih.',
            'unit_id.exists' => 'Satuan tidak valid.',
            'purchase_price.required' => 'Harga beli produk wajib diisi.',
            'purchase_price.required' => 'Harga jual produk wajib diisi.',
            'customer_category_id.*.exists' => 'Kategori konsumen tidak valid.',
            'image.image' => 'Gambar harus dalam format jpeg, jpg, atau png',
            'image.mimes' => 'Format gambar harus jpeg, jpg, atau png',
            'image.max' => 'Ukuran gambar tidak boleh lebih dari 4 MB',
        ]);

        // Validasi khusus untuk duplikasi kategori konsumen
        $customerCategoryIds = $request->input('customer_category_id', []);
        if (count($customerCategoryIds) !== count(array_unique($customerCategoryIds))) {
            $validator->errors()->add('customer_category_id', 'Terdapat duplikasi kategori konsumen.');
        }

        // Jika validasi gagal
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        // Membersihkan data harga dari karakter koma
        $data = $request->all();
        $data['purchase_price'] = str_replace(',', '', $data['purchase_price']);
        if (!empty($data['cost_price'])) {
            $data['cost_price'] = str_replace(',', '', $data['cost_price']);
        }

        // Hilangkan data 'customer_category_id' dan 'customer_price' dari array sebelum menyimpan produk
        unset($data['customer_category_id']);
        unset($data['customer_price']);

        // Ambil produk yang akan diupdate
        $transaction = Transaction::find($id);

        // Pastikan produk ditemukan
        if (!$transaction) {
            return redirect()->route('transactions.index')->with('error', 'Transaksi tidak ditemukan.');
        }

        // Proses image jika ada file yang diupload
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/transactions/';
            $originalFileName = $image->getClientOriginalName();
            $imageMimeType = $image->getMimeType();

            // Memastikan file adalah gambar
            if (strpos($imageMimeType, 'image/') === 0) {
                $imageName = date('YmdHis') . '_' . str_replace(' ', '_', $originalFileName);
                $image->move($destinationPath, $imageName);

                $sourceImagePath = public_path($destinationPath . $imageName);
                $webpImagePath = $destinationPath . pathinfo($imageName, PATHINFO_FILENAME) . '.webp';

                // Mengubah gambar ke format webp
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

                // Jika gambar berhasil dibaca, konversi ke WebP dan hapus gambar asli
                if ($sourceImage !== false) {
                    imagewebp($sourceImage, $webpImagePath);
                    imagedestroy($sourceImage);
                    @unlink($sourceImagePath); // Menghapus file gambar asli
                    $data['image'] = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';  // Menggunakan $data, bukan $input
                } else {
                    throw new \Exception('Gagal membaca gambar asli.');
                }

                // Hapus gambar lama jika ada
                if ($transaction->image) {
                    $oldImagePath = public_path('upload/transactions/' . $transaction->image);
                    if (file_exists($oldImagePath)) {
                        @unlink($oldImagePath);  // Menghapus gambar lama
                    }
                }
            } else {
                throw new \Exception('Tipe MIME gambar tidak didukung.');
            }
        } else {
            $data['image'] = $transaction->image;  // Jika tidak ada gambar baru, gunakan gambar lama
        }

        // Menyimpan data produk yang diperbarui
        $transaction->update($data);

        // Menyimpan harga konsumen tambahan jika ada
        if ($request->has('customer_category_id') && !empty($request->customer_category_id)) {
            // Ambil semua kategori yang ada saat ini untuk produk ini
            $existingPrices = $transaction->transactionPrices()->pluck('customer_category_id')->toArray();

            // Loop untuk menyimpan atau memperbarui harga konsumen
            foreach ($request->customer_category_id as $index => $categoryId) {
                $customerPrice = str_replace(',', '', $request->customer_price[$index] ?? null);
                if ($categoryId && $customerPrice) {
                    // Simpan atau perbarui harga untuk kategori pelanggan di tabel transaction_prices
                    $transaction->transactionPrices()->updateOrCreate(
                        ['customer_category_id' => $categoryId], // Kondisi pencarian
                        ['price' => $customerPrice]               // Data yang akan diperbarui
                    );
                }
            }

            // Hapus harga konsumen yang tidak ada lagi di request
            $categoryIdsFromRequest = $request->input('customer_category_id', []);
            $transaction->transactionPrices()
                ->whereNotIn('customer_category_id', $categoryIdsFromRequest)
                ->delete();  // Menghapus harga konsumen yang sudah tidak ada dalam request
        } else {
            // Jika tidak ada kategori yang dipilih, hapus semua harga konsumen yang ada
            $transaction->transactionPrices()->delete();
        }

        $loggedInUserId = Auth::id();

        // Simpan log histori untuk operasi Update dengan user_id yang sedang login
        $this->simpanLogHistori('Update', 'Transaksi', $transaction->id, $loggedInUserId, json_encode($transaction), json_encode($data));

        // Redirect ke halaman produk dengan pesan sukses
        return redirect()->route('transactions.index')
            ->with('success', 'Transaksi berhasil diperbarui.');
    }






    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Transactions  $transaction
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        // Cari produk berdasarkan ID
        $transaction = Transaction::findOrFail($id);

        // Mulai transaksi database untuk memastikan konsistensi
        DB::beginTransaction();
        try {
            // Hapus file gambar dari folder upload/transactions jika ada
            if (!empty($transaction->image)) {
                $imagePath = public_path('upload/transactions/' . $transaction->image);
                if (file_exists($imagePath)) {
                    @unlink($imagePath); // Menghapus file gambar
                }
            }

            // Hapus semua harga konsumen terkait pada tabel transaction_prices
            $transaction->transactionPrices()->delete();

            // Hapus produk dari tabel transactions
            $transaction->delete();

            // Mendapatkan ID pengguna yang sedang login
            $loggedInUserId = Auth::id();

            // Simpan log histori untuk operasi Delete
            $this->simpanLogHistori('Delete', 'Transaksi', $id, $loggedInUserId, json_encode($transaction), null);

            // Commit transaksi
            DB::commit();

            // Redirect kembali dengan pesan sukses
            return redirect()->route('transactions.index')->with('success', 'Transaksi berhasil dihapus');
        } catch (\Exception $e) {
            // Rollback transaksi jika terjadi error
            DB::rollBack();

            // Kembalikan pesan error
            return redirect()->route('transactions.index')->with('error', 'Gagal menghapus produk: ' . $e->getMessage());
        }
    }
}
