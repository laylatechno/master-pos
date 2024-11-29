<?php

namespace App\Http\Controllers;

use App\Models\Cash;
use App\Models\LogHistori;
use App\Models\Product;
use App\Models\Profil;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Customer;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;


class OrderController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:order-list|order-create|order-edit|order-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:order-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:order-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:order-delete', ['only' => ['destroy']]);
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


    public function index()
    {
        $title = "Halaman Penjualan";
        $subtitle = "Menu Penjualan";

        // Eager loading customer dan user
        $data_orders = Order::with(['customer', 'user'])->orderBy('id', 'desc')->get();

        $data_products = Product::all();

        // Kirim semua data ke view
        return view('order.index', compact('data_orders', 'data_products', 'title', 'subtitle'));
    }

    public function printInvoice($id)
    {
        // Ambil data pembelian berdasarkan ID
        $order = Order::with(['customer', 'user', 'orderItems.product'])->findOrFail($id);

        // Kirim data pembelian ke view
        return view('order.print', compact('order'));
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $title = "Halaman Tambah Penjualan";
        $subtitle = "Menu Tambah Penjualan";

        // Mengambil data yang diperlukan
        $data_users = User::all();
        $data_products = Product::all();
        $data_customers = Customer::all();
        $data_orders = Order::all();
        $data_cashes = Cash::all();

        // Mendapatkan kode pembelian terbaru dari database
        $latestOrder = Order::latest()->first();
        $no_order = '';

        // Mengambil alias dari tabel profil
        $alias = Profil::first()->alias ?? 'LTPOS'; // Default 'LTPOS' jika alias kosong

        // Jika belum ada pembelian sebelumnya
        if (!$latestOrder) {
            $no_order = $alias . '-' . date('Ymd') . '-000001-ORD';
        } else {
            // Memecah kode pembelian untuk mendapatkan nomor urut
            $parts = explode('-', $latestOrder->no_order);
            $nomor_urut = intval($parts[2]) + 1;

            // Format ulang nomor urut agar memiliki panjang 6 digit
            $nomor_urut_format = str_pad($nomor_urut, 6, '0', STR_PAD_LEFT);

            // Menggabungkan kode pembelian baru
            $no_order = $alias . '-' . date('Ymd') . '-' . $nomor_urut_format . '-ORD';
        }

        // Menampilkan view dengan data yang diperlukan
        return view('order.create', compact('data_cashes', 'data_orders', 'data_products', 'data_users', 'data_customers', 'title', 'subtitle', 'no_order'));
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validasi data pembelian
        $request->validate([
            'order_date' => 'required|date',
            'total_cost' => 'required|numeric',
            'product_id' => 'required|array',
            'quantity' => 'required|array',
            'image' => 'mimes:jpg,jpeg,png,gif|max:4048', // Max 4 MB
        ], [
            'image.mimes' => 'Bukti yang dimasukkan hanya diperbolehkan berekstensi JPG, JPEG, PNG dan GIF',
            'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
        ]);

        // Menangani gambar (jika ada)
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/orders/';
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
                    $data['image'] = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';
                } else {
                    throw new \Exception('Gagal membaca gambar asli.');
                }
            } else {
                throw new \Exception('Tipe MIME gambar tidak didukung.');
            }
        } else {
            $data['image'] = ''; // Jika tidak ada image yang diupload
        }

        // Simpan data pembelian ke dalam database
        $order = new Order();
        $order->image = $data['image'];  // Perbaikan disini, bukan $request->image
        $order->type_payment = $request->type_payment;
        $order->order_date = $request->order_date;
        $order->no_order = $request->no_order;
        $order->customer_id = $request->customer_id;
        $order->user_id = Auth::id(); // Ganti dengan field yang sesuai dengan pic
        $order->cash_id = $request->cash_id;
        $order->total_cost = str_replace(['.', ','], '', $request->total_cost);
        $order->status = $request->status;
        $order->description = $request->description;
        $order->save();

        // Mendapatkan ID dari order yang baru saja disimpan
        $orderId = $order->id;

        // Simpan detail order ke dalam database
        $productIds = $request->product_id;
        $quantitys = $request->quantity;
        $orderprice = $request->cost_price;

        foreach ($productIds as $key => $productId) {
            $hargaBeliWithoutSeparator = str_replace(['.', ','], '', $orderprice[$key]);
            $detail = new OrderItem();
            $detail->order_id = $orderId;
            $detail->product_id = $productId;
            $detail->order_price = $hargaBeliWithoutSeparator;
            $detail->quantity = $quantitys[$key];
            $detail->total_price = $quantitys[$key] * $hargaBeliWithoutSeparator;
            $detail->save();
        }

        // Mengecek saldo cash sebelum melanjutkan transaksi
        $cash = Cash::find($request->cash_id);
        if ($cash && $cash->amount < $request->total_cost) {
            return response()->json([
                'success' => false,
                'message' => 'Saldo cash tidak mencukupi untuk transaksi ini.',
            ], 400); // 400 adalah kode status HTTP untuk permintaan yang salah
        }

        // Proses pembayaran dan pembaruan stok hanya jika status pembelian 'Lunas'
        if ($order->status === 'Lunas') {
            // Update stock produk: kurangi stok produk berdasarkan quantity yang dipesan
            foreach ($request->product_id as $key => $productId) {
                $product = Product::find($productId);
                if ($product) {
                    // Kurangi stok produk sesuai dengan quantity yang dipesan
                    $product->stock -= $request->quantity[$key];
                    $product->save();
                }
            }

            // Tambahkan saldo cash berdasarkan cash_id (hanya update saldo, tanpa pengecekan saldo)
            $cash = Cash::find($request->cash_id); // Menemukan data cash berdasarkan cash_id
            if ($cash) {
                $cash->amount += $order->total_cost; // Tambahkan saldo cash sesuai total_cost dari order
                $cash->save();
            } else {
                // Jika cash_id tidak ditemukan, batalkan transaksi dan kirimkan error
                $order->delete();
                return response()->json([
                    'success' => false,
                    'message' => 'Cash ID tidak ditemukan. Silakan periksa input data Anda.'
                ], 400);  // 400 adalah kode status HTTP untuk permintaan yang salah
            }
        }



        // Mendapatkan ID user yang sedang login
        $loggedInUserId = Auth::id();

        // Simpan log histori untuk operasi Create dengan user_id yang sedang login
        $this->simpanLogHistori('Create', 'Order', $order->id, $loggedInUserId, null, json_encode($order));

        // Kembalikan respons sukses
        return response()->json(['success' => true, 'message' => 'Penjualan berhasil disimpan'], 200);
    }









    /**
     * Display the specified resource.
     */
    // Controller Method (Show Penjualan)
    public function show($id)
    {
        $title = "Halaman Lihat Penjualan";
        $subtitle = "Menu Lihat Penjualan";
        // Ambil data pembelian berdasarkan ID
        $order = Order::with(['customer', 'user', 'orderItems.product'])->findOrFail($id);

        // Kirim data ke view
        return view('order.show', compact('order', 'title', 'subtitle'));
    }


    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $title = "Halaman Lihat Penjualan";
        $subtitle = "Menu Lihat Penjualan";
        // Ambil data pembelian berdasarkan ID
        $order = Order::with('orderItems.product')->findOrFail($id);


        // Ambil data lainnya yang dibutuhkan untuk dropdown
        $data_customers = Customer::all();
        $data_products = Product::all();
        $data_cashes = Cash::all();

        // Kirim data ke view
        return view('order.edit', compact('order', 'title', 'subtitle', 'data_customers', 'data_products', 'data_cashes'));
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        // Validasi input dari form
        $request->validate([
            'order_date' => 'required|date',
            'image' => 'mimes:jpg,jpeg,png,gif|max:4048',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.order_price' => 'required|regex:/^\d+([.,]\d+)*$/',
            'items.*.quantity' => 'required|integer|min:1',
        ], [
            'image.mimes' => 'Bukti yang dimasukkan hanya diperbolehkan berekstensi JPG, JPEG, PNG, dan GIF',
            'image.max' => 'Ukuran image tidak boleh lebih dari 4 MB',
            'items.*.product_id.required' => 'Produk harus dipilih.',
            'items.*.order_price.required' => 'Harga pembelian harus diisi.',
            'items.*.quantity.required' => 'Jumlah harus diisi.',
        ]);

        // Temukan data pembelian berdasarkan ID
        $order = Order::findOrFail($id);

        // Simpan status dan data awal sebelum update
        $oldStatus = $order->status;
        $oldData = $order->toArray();

        // Menangani gambar (jika ada)
        if ($image = $request->file('image')) {
            $destinationPath = 'upload/orders/';
            $originalFileName = $image->getClientOriginalName();
            $imageMimeType = $image->getMimeType();

            // Hapus gambar lama jika ada
            if ($order->image && file_exists(public_path($destinationPath . $order->image))) {
                @unlink(public_path($destinationPath . $order->image));
            }

            // Proses upload gambar baru
            $imageName = date('YmdHis') . '_' . str_replace(' ', '_', $originalFileName);
            $image->move($destinationPath, $imageName);

            $sourceImagePath = public_path($destinationPath . $imageName);
            $webpImagePath = $destinationPath . pathinfo($imageName, PATHINFO_FILENAME) . '.webp';

            // Konversi gambar ke WebP
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
                @unlink($sourceImagePath); // Menghapus file gambar asli
                $order->image = pathinfo($imageName, PATHINFO_FILENAME) . '.webp';
            } else {
                throw new \Exception('Gagal membaca gambar asli.');
            }
        }

        // Update data pembelian
        $order->description = $request->description;
        $order->type_payment = $request->type_payment;
        $order->order_date = $request->order_date;
        $order->status = $request->status;
        $order->cash_id = $request->cash_id;
        $order->customer_id = $request->customer_id;
        $order->no_order = $request->no_order;
        $order->user_id = Auth::id();
        $order->total_cost = str_replace(['.', ','], '', $request->total_cost);
        $order->save();

        // Mendapatkan ID dari order yang baru saja disimpan
        $orderId = $order->id;

        // Update atau simpan detail order ke dalam database
        $items = $request->items;
        foreach ($items as $itemId => $itemData) {
            $hargaBeliWithoutSeparator = str_replace(['.', ','], '', $itemData['order_price']);
            $orderItem = OrderItem::findOrNew($itemId); // Update jika item ada, buat baru jika tidak ada
            $orderItem->order_id = $orderId;
            $orderItem->product_id = $itemData['product_id'];
            $orderItem->order_price = $hargaBeliWithoutSeparator;
            $orderItem->quantity = $itemData['quantity'];
            $orderItem->total_price = $itemData['quantity'] * $hargaBeliWithoutSeparator;
            $orderItem->save();
        }

        // Jika status berubah menjadi "Lunas", tambah saldo kas dan kurangi stok produk
        if ($oldStatus !== 'Lunas' && $order->status === 'Lunas') {
            // Mengurangi stok produk
            foreach ($items as $itemId => $itemData) {
                $orderItem = OrderItem::findOrFail($itemId);
                $product = Product::find($orderItem->product_id);

                if ($product) {
                    $product->stock -= $orderItem->quantity;  // Mengurangi stok
                    $product->save();
                }
            }

            // Menambahkan saldo kas
            $cash = Cash::find($request->cash_id);
            if ($cash) {
                $cash->amount += $order->total_cost;  // Menambah saldo kas
                $cash->save();  // Simpan perubahan kas
            } else {
                return response()->json(['error' => 'Kas tidak ditemukan'], 404);
            }
        }

        // Simpan log histori
        $loggedInUserId = Auth::id();
        $this->simpanLogHistori('Update', 'Order', $order->id, $loggedInUserId, json_encode($oldData), json_encode($order->toArray()));

        // Return response JSON
        return response()->json([
            'status' => 'success',
            'message' => 'Penjualan berhasil diperbarui!',
        ]);
    }




    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        // Ambil data order yang akan dihapus
        $order = Order::findOrFail($id);

        // Mulai transaksi untuk memastikan semuanya atau tidak sama sekali
        DB::beginTransaction();

        try {
            // Cek status pembelian, hanya jika status "Lunas" yang mempengaruhi stok dan cash
            if ($order->status == 'Lunas') {
                // Kembalikan stok produk berdasarkan order_items yang ada
                foreach ($order->orderItems as $item) {
                    // Mengembalikan stok produk berdasarkan quantity yang dibeli
                    $product = $item->product;
                    $product->stock += $item->quantity; // Menambah stok produk
                    $product->save();
                }

                // Mengurangi kembali jumlah cash yang digunakan dalam order
                $cash = $order->cash;
                $cash->amount -= $order->total_cost; // Mengurangi cash yang digunakan
                $cash->save();
            }

            // Hapus gambar terkait pembelian jika ada
            if ($order->image) {
                $imagePath = public_path('upload/orders/' . $order->image);
                if (file_exists($imagePath)) {
                    unlink($imagePath); // Menghapus file gambar
                }
            }

            // Hapus semua order_items terkait
            $order->orderItems()->delete();

            // Hapus order
            $order->delete();

            // Commit transaksi
            DB::commit();

            // Mendapatkan ID pengguna yang sedang login
            $loggedInUserId = Auth::id();

            // Simpan log histori untuk operasi Delete
            $this->simpanLogHistori('Delete', 'Order', $id, $loggedInUserId, json_encode($order), null);

            return redirect()->route('orders.index')->with('success', 'Penjualan berhasil dihapus dan data terkait telah diperbarui.');
        } catch (\Exception $e) {
            // Rollback transaksi jika ada error
            DB::rollback();

            // Log error jika diperlukan
            Log::error("Error menghapus pembelian: " . $e->getMessage());

            return back()->with('error', 'Terjadi kesalahan saat menghapus pembelian.');
        }
    }
}
