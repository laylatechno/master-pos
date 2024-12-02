@extends('layouts.app')
@push('css')
<link rel="stylesheet" href="{{ asset('template/back') }}/dist/libs/select2/dist/css/select2.min.css">
<style>
    .select2-container--default .select2-selection--single .select2-selection__arrow b {
        border-color: #888 transparent transparent transparent;
        border-style: solid;
        border-width: 5px 4px 0 4px;
        height: 0;
        left: 50%;
        margin-left: -4px;
        margin-top: 20px;
        position: absolute;
        top: 50%;
        width: 0;
    }




    .product-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .product-item {
        width: 150px;
        text-align: center;
        cursor: pointer;
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        transition: transform 0.2s;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        /* Menjaga gambar dan teks tetap terpisah */
    }

    .product-item:hover {
        transform: scale(1.05);
        border-color: #aaa;
    }

    .product-item img {
        width: 100%;
        height: 100px;
        /* Tentukan tinggi gambar agar konsisten */
        object-fit: cover;
        /* Menjaga aspek rasio gambar */
    }

    .product-item p {
        font-size: 14px;
        margin-top: 10px;
        /* Jarak antara gambar dan nama */
        text-overflow: ellipsis;
        /* Memotong nama jika terlalu panjang */
        white-space: nowrap;
        /* Membatasi nama agar tidak terputus */
        overflow: hidden;
        /* Menyembunyikan teks yang melebihi kontainer */
        padding: 0 5px;
        /* Memberikan sedikit padding agar teks tidak menempel ke tepi */
    }
</style>
@endpush
@section('content')


<div class="container-fluid">
    <div class="card bg-light-info shadow-none position-relative overflow-hidden" style="border: solid 0.5px #ccc;">
        <div class="card-body px-4 py-3">
            <div class="row align-items-center">
                <div class="col-9">
                    <h4 class="fw-semibold mb-8">{{ $title }}</h4>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a class="text-muted text-decoration-none" href="/">Beranda</a></li>
                            <li class="breadcrumb-item" aria-current="page">
                                <a class="text-muted text-decoration-none" href="{{ route('orders.index') }}">Halaman Penjualan</a>
                            </li>
                            <li class="breadcrumb-item" aria-current="page">{{ $subtitle }}</li>
                        </ol>
                    </nav>
                </div>
                <div class="col-3 text-center mb-n5">
                    <img src="{{ asset('template/back') }}/dist/images/breadcrumb/ChatBc.png" alt="" class="img-fluid mb-n4">
                </div>
            </div>
        </div>
    </div>

    <section class="datatables">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        @if ($errors->any())
                        <div class="alert alert-danger">
                            <strong>Whoops!</strong> Ada beberapa masalah dengan data yang anda masukkan.
                            <ul>
                                @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                        @endif





                        <form id="form-edit-order" enctype="multipart/form-data">
                            @csrf
                            @method('PUT') {{-- Laravel Method Spoofing untuk method PUT --}}

                            <h5 class="card-title mb-0"><b style="color: blue;">Kode Penjualan : <input type="hidden"
                                        id="no_order" name="no_order"
                                        value="{{ $order->no_order }}">{{ $order->no_order }}</input></b></h5>

                            <br>
                            <hr>
                            <div class="form-group mb-3 col-md-6">
                                <label for="status" class="mb-2"> Status Pembayaran : </label><br>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Pesanan Penjualan" {{ old('status', $order->status) == 'Pesanan Penjualan' ? 'checked' : '' }}> Pesanan Penjualan
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Lunas" {{ old('status', $order->status) == 'Lunas' ? 'checked' : '' }}> Lunas
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Belum Lunas" {{ old('status', $order->status) == 'Belum Lunas' ? 'checked' : '' }}> Belum Lunas
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Pending" {{ old('status', $order->status) == 'Pending' ? 'checked' : '' }}> Pending
                                </label>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="hari">Tanggal Penjualan</label>
                                        <span class="text-danger">*</span>
                                        <input type="date" class="form-control" id="order_date" name="order_date" value="{{ old('order_date', $order->order_date ?? date('Y-m-d')) }}">
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="customer_id">Pelanggan</label>
                                        <select class="form-control" id="customer_id" name="customer_id">
                                            <option value="">--Pilih Pelanggan--</option>
                                            @foreach ($data_customers as $customerItem)
                                            <option value="{{ $customerItem->id }}"
                                                {{ old('customer_id', $order->customer_id) == $customerItem->id ? 'selected' : '' }}>
                                                {{ $customerItem->name }}
                                            </option>
                                            @endforeach
                                        </select>
                                        <input type="hidden" name="name" id="name" value="{{ $order->customer_id }}">
                                    </div>
                                </div>

                                {{-- Produk --}}
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="product_id">Cari Produk</label>
                                        <span class="text-danger">*</span>
                                        <select class="form-control product-select" id="product_id">
                                            <option value="" disabled selected>-- Pilih Produk --</option>
                                            @foreach ($data_products as $product)
                                            <option value="{{ $product->id }}" data-name="{{ $product->name }}" data-order-price="{{ $product->cost_price }}">
                                                {{ $product->name }}
                                            </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="cash_id">Kas Pembayaran</label>
                                        <select name="cash_id" id="cash_id" class="form-control">
                                            <option value="">--Pilih Cash--</option>
                                            @foreach($data_cashes as $cash)
                                            <option value="{{ $cash->id }}"
                                                {{ old('cash_id', $order->cash_id) == $cash->id ? 'selected' : '' }}
                                                data-amount="{{ $cash->amount }}">
                                                {{ $cash->name }} - Rp{{ number_format($cash->amount, 0, ',', '.') }}
                                            </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>

                                <div class="product-list mb-4">
                                    @foreach ($data_products as $produkItem)
                                    <div class="product-item" data-id="{{ $produkItem->id }}"
                                        data-name="{{ $produkItem->name }}"
                                        data-stock="{{ $produkItem->stock }}"
                                        data-price="{{ $produkItem->cost_price }}">
                                        <img src="/upload/products/{{ $produkItem->image }}" alt="{{ $produkItem->name }}" />
                                        <p>{{ $produkItem->name }}</p> <!-- Nama produk di sini -->
                                    </div>
                                    @endforeach
                                </div>

                                {{-- Tabel Produk --}}
                                <div>
                                    <table class="table table-bordered" id="cart-table">
                                        <thead>
                                            <tr>
                                                <th width="5%">No</th>
                                                <th>Produk</th>
                                                <th>Harga</th>
                                                <th width="15%">Qty</th>
                                                <th>Total</th>
                                                <th>Aksi</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach ($order->orderItems as $index => $item)
                                            <tr data-id="{{ $item->product_id }}" data-stock="{{ $item->product->stock }}">
                                                <td>{{ $index + 1 }}</td>
                                                <td>
                                                    <input type="hidden" name="product_id[]" value="{{ $item->product_id }}">
                                                    {{ $item->product->name }}
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control order_price" name="order_price[]" value="{{ $item->order_price }}">
                                                </td>
                                                <td>
                                                    <input type="number" class="form-control quantity" name="quantity[]" value="{{ $item->quantity }}">
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control total" name="total[]" value="{{ $item->order_price * $item->quantity }}" readonly>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-danger btn-sm btn-remove-product"><i class="fas fa-trash"></i></button>
                                                </td>
                                            </tr>

                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>


                                <div class="row mt-4">
                                    <div class="col-md-6 mb-3">
                                        <h5 style="color: red; font-size:30px;" class="badge badge-danger"><b>Total
                                                Bayar: </b> Rp.<span id="total_cost">{{ number_format(old('total_cost', $order->total_cost ?? 0), 0, ',', '.') }}</span></h5>
                                        <input type="hidden" name="total_cost" id="total_cost_input" class="form-control total_cost"
                                            value="{{ old('total_cost', $order->total_cost ?? 0) }}">
                                        <hr>

                                    </div>


                                    <div class="col-md-6 mb-3">
                                        <div class="form-group" hidden>
                                            <label for="input_payment">Bayar:</label>
                                            <input type="text" class="form-control" id="input_payment" name="input_payment" value="{{ old('input_payment', $order->input_payment ?? '') }}">
                                        </div>
                                        <div class="form-group" hidden>
                                            <label for="return_payment">Kembalian:</label>
                                            <input type="text" class="form-control" id="return_payment" name="return_payment" readonly value="{{ old('return_payment', $order->return_payment ?? '') }}">
                                        </div>


                                        <div class="form-group mb-3">
                                            <label for="type_payment">Jenis Pembayaran:</label>
                                            <select name="type_payment" id="type_payment" class="form-control">
                                                <option value="">--Pilih Jenis Pembayaran--</option>
                                                <option value="CASH" {{ old('type_payment', $order->type_payment) == 'CASH' ? 'selected' : '' }}>CASH</option>
                                                <option value="TRANSFER" {{ old('type_payment', $order->type_payment) == 'TRANSFER' ? 'selected' : '' }}>TRANSFER</option>
                                            </select>
                                        </div>

                                        <div class="form-group mb-3" id="image_container">
                                            <label for="image">Gambar:</label>
                                            <input type="file" class="form-control" id="image" name="image" onchange="previewImage()">
                                            <canvas id="preview_canvas" style="display: none; max-width: 80%; margin-top: 10px;"></canvas>
                                            <img id="preview_image" src="{{ old('image', $order->image) ? asset('storage/' . $order->image) : '#' }}" alt="Preview Logo" style="display: none; max-width: 80%; margin-top: 10px;">
                                        </div>
                                        <script>
                                            function previewImage() {
                                                var previewCanvas = document.getElementById('preview_canvas');
                                                var previewImage = document.getElementById('preview_image');
                                                var fileInput = document.getElementById('image');
                                                var file = fileInput.files[0];
                                                var reader = new FileReader();

                                                reader.onload = function(e) {
                                                    var img = new Image();
                                                    img.src = e.target.result;

                                                    img.onload = function() {
                                                        var canvasContext = previewCanvas.getContext('2d');
                                                        var maxWidth = 200; // Max width diperbesar
                                                        var scaleFactor = maxWidth / img.width;
                                                        var newHeight = img.height * scaleFactor;

                                                        // Atur dimensi canvas
                                                        previewCanvas.width = maxWidth;
                                                        previewCanvas.height = newHeight;

                                                        // Gambar ke canvas
                                                        canvasContext.drawImage(img, 0, 0, maxWidth, newHeight);

                                                        // Tampilkan pratinjau
                                                        previewCanvas.style.display = 'block';
                                                        previewImage.style.display = 'none';
                                                    };
                                                };

                                                if (file) {
                                                    reader.readAsDataURL(file); // Membaca file sebagai URL data
                                                } else {
                                                    // Reset pratinjau jika tidak ada file
                                                    previewImage.src = '';
                                                    previewCanvas.style.display = 'none';
                                                }
                                            }
                                        </script>

                                        <div class="form-group mb-3">
                                            <label for="description">Keterangan:</label>
                                            <textarea name="description" id="description" class="form-control" cols="30" rows="3">{{ old('description', $order->description) }}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="border-top">
                                    <div class="card-body">
                                        <button type="submit" class="btn btn-success" style="color:white;" id="btn-save-order">
                                            <i class="fas fa-save"></i> Simpan
                                        </button>
                                        <a href="{{ route('orders.index') }}" class="btn btn-danger" style="color:white;">
                                            <i class="fas fa-step-backward"></i> Kembali
                                        </a>
                                    </div>
                                </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


@endsection

@push('script')
<script src="{{ asset('template/back') }}/dist/libs/select2/dist/js/select2.full.min.js"></script>
<script src="{{ asset('template/back') }}/dist/libs/select2/dist/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Pindahkan Script di Sini -->
<script>
    document.getElementById('customer_id').addEventListener('change', function() {
        // Ambil nilai dari select box
        const selectedCustomerId = this.value;

        // Update nilai input dengan id "name"
        document.getElementById('name').value = selectedCustomerId;
    });
</script>
<script>
    $(document).ready(function() {

        $('#customer_id').on('change', function() {
            $('#name').val($(this).val());
        });
    });
</script>

<script>
    $(document).ready(function() {
        $('#customer_id').select2();
        $('#product_id').select2();
        $('#cash_id').select2();
    });
</script>

<script>
    $(document).ready(function() {
        // Fungsi untuk format Rupiah
        function formatRupiah(angka) {
            var numberString = angka.toString().replace(/[^,\d]/g, ''),
                split = numberString.split(','),
                sisa = split[0].length % 3,
                rupiah = split[0].substr(0, sisa),
                ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            rupiah = split[1] !== undefined ? rupiah + ',' + split[1] : rupiah;
            return rupiah;
        }

        // Fungsi untuk menghitung total
        function calculateTotal() {
            var totalBayar = 0;

            // Iterasi setiap baris pada tabel
            $('#cart-table tbody tr').each(function() {
                var $row = $(this); // Mengambil baris saat ini
                var quantity = parseInt($row.find('.quantity').val()) || 0; // Mengambil nilai quantity
                var hargaBeli = parseInt($row.find('.order_price').val().replace(/\./g, '')) || 0; // Mengambil nilai harga

                // Hitung total per baris
                var total = quantity * hargaBeli;
                $row.find('.total').val(formatRupiah(total)); // Set nilai total pada input

                // Tambahkan ke totalBayar
                totalBayar += total;
            });

            // Set nilai total keseluruhan di elemen dengan id total_cost
            $('#total_cost').text(formatRupiah(totalBayar));
            $('.total_cost').val(totalBayar); // Jika nilai ingin disimpan sebagai angka (bukan teks Rupiah)
        }


        // Panggil calculateTotal setiap kali quantity atau order_price diubah
        $(document).on('input', '.quantity, .order_price', function() {
            calculateTotal(); // Hitung ulang total saat ada perubahan
        });

        // Fungsi untuk validasi perubahan manual pada input quantity
        $(document).on('change', '.quantity', function() {
            const quantityInput = $(this);
            const currentQty = parseInt(quantityInput.val() || 0);
            const row = quantityInput.closest('tr'); // Ambil baris terkait
            const productStock = parseInt(row.data('stock') || 0); // Ambil stok dari atribut data-stock

            // Validasi apakah jumlah melebihi stok
            if (currentQty > productStock) {
                Swal.fire({
                    title: 'Peringatan!',
                    text: 'Jumlah produk tidak boleh melebihi stok yang tersedia.',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                quantityInput.val(productStock); // Reset ke stok maksimal
            } else if (currentQty <= 0) {
                Swal.fire({
                    title: 'Peringatan!',
                    text: 'Jumlah produk harus minimal 1.',
                    icon: 'warning',
                    confirmButtonText: 'OK'
                });
                quantityInput.val(1); // Reset ke nilai minimal
            }

            // Update total harga setelah validasi
            const orderPrice = parseFloat(row.find('.order_price').val().replace(/[^0-9.-]+/g, '') || 0);
            row.find('.total').val(formatRupiah(currentQty * orderPrice));

            // Recalculate total harga semua produk
            calculateTotal();
        });



        // Fungsi untuk menambahkan produk ke dalam tabel
        $('.product-item').click(function() {
            const productId = $(this).data('id');
            const productName = $(this).data('name');
            const productStock = $(this).data('stock');
            const customerCategoryId = $('#customer_id').val(); // Ambil kategori pelanggan

            if (!productId) return;

            // Lakukan AJAX untuk mendapatkan harga produk berdasarkan kategori pelanggan
            $.ajax({
                url: '/get-product-price', // URL controller
                method: 'GET',
                data: {
                    product_id: productId,
                    customer_category_id: customerCategoryId
                },
                success: function(response) {
                    const orderPrice = parseFloat(response.price) || 0;

                    // Cek apakah produk sudah ada di tabel
                    const existingRow = $(`table#cart-table tbody tr[data-id="${productId}"]`);
                    if (existingRow.length) {
                        const quantityInput = existingRow.find('.quantity');
                        const currentQty = parseInt(quantityInput.val() || 0);
                        if (currentQty < productStock) {
                            const newQuantity = currentQty + 1;
                            quantityInput.val(newQuantity);
                            const totalInput = existingRow.find('.total');
                            totalInput.val(formatRupiah(newQuantity * orderPrice)); // Update total
                        } else {
                            alert("Stok produk sudah habis!");
                        }
                    } else {
                        // Jika produk belum ada, tambahkan baris baru ke tabel
                        $('table#cart-table tbody').append(`
                            <tr data-id="${productId}" data-stock="${productStock}">
                                <td>${$('table#cart-table tbody tr').length + 1}</td>
                                <td>
                                    <input type="hidden" name="product_id[]" value="${productId}">
                                    ${productName}
                                </td>
                                <td>
                                    <input type="text" class="form-control order_price" name="order_price[]" value="${formatRupiah(orderPrice)}">
                                </td>
                                <td>
                                    <input type="number" class="form-control quantity" name="quantity[]" value="1">
                                </td>
                                <td>
                                    <input type="text" class="form-control total" name="total[]" value="${formatRupiah(orderPrice)}" readonly>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm btn-remove-product"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);

                    }

                    // Hitung total setelah produk ditambahkan
                    calculateTotal();
                },
                error: function() {
                    alert('Gagal mengambil harga produk.');
                }
            });
        });



        // Tambahkan produk ke tabel
        $('#product_id').change(function() {
            const selectedOption = $(this).find(':selected');
            const productId = selectedOption.val();
            const productName = selectedOption.data('name');
            const productStock = selectedOption.data('stock');
            const customerCategoryId = $('#customer_id').val();

            if (!productId) return;

            // Ambil harga berdasarkan kategori pelanggan
            $.ajax({
                url: '/get-product-price', // URL controller
                method: 'GET',
                data: {
                    product_id: productId,
                    customer_category_id: customerCategoryId
                },
                success: function(response) {
                    const orderPrice = parseFloat(response.price) || 0;

                    // Cek apakah produk sudah ada di tabel
                    const existingRow = $(`table tbody tr[data-id="${productId}"]`);
                    if (existingRow.length) {
                        const quantityInput = existingRow.find('.quantity');
                        const currentQty = parseInt(quantityInput.val() || 0);
                        if (currentQty < productStock) {
                            const newQuantity = currentQty + 1;
                            quantityInput.val(newQuantity);
                            existingRow.find('.order_price').val(formatRupiah(orderPrice));
                            const totalInput = existingRow.find('.total');
                            totalInput.val(formatRupiah(newQuantity * orderPrice));
                        } else {
                            alert("Stok produk sudah habis!");
                        }
                    } else {
                        $('table#cart-table tbody').append(`
                            <tr data-id="${productId}" data-stock="${productStock}">
                                <td>${$('table#cart-table tbody tr').length + 1}</td>
                                <td>
                                    <input type="hidden" name="product_id[]" value="${productId}">
                                    ${productName}
                                </td>
                                <td>
                                    <input type="text" class="form-control order_price" name="order_price[]" value="${formatRupiah(orderPrice)}">
                                </td>
                                <td>
                                    <input type="number" class="form-control quantity" name="quantity[]" value="1">
                                </td>
                                <td>
                                    <input type="text" class="form-control total" name="total[]" value="${formatRupiah(orderPrice)}" readonly>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm btn-remove-product"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);

                    }

                    // Hitung total setelah update DOM
                    calculateTotal();
                },
                error: function() {
                    alert('Gagal mengambil harga produk.');
                }
            });
        });




        // Hapus produk dari tabel dan hitung total
        $(document).on('click', '.btn-remove-product', function() {
            $(this).closest('tr').remove();
            $('table tbody tr').each(function(index) {
                $(this).find('td:first').text(index + 1);
            });
            calculateTotal(); // Hitung ulang total setelah produk dihapus
        });
    });
</script>



<script>
    $(document).ready(function() {
        $('#form-edit-order').submit(function(e) {
            e.preventDefault();

            const tombolSave = $('#btn-save-order'); // Tombol Simpan
            const iconSave = tombolSave.find('i'); // Ikon dalam tombol

            // Ganti ikon tombol dengan spinner dan nonaktifkan tombol
            iconSave.removeClass('fas fa-save').addClass('fas fa-spinner fa-spin');
            tombolSave.prop('disabled', true); // Nonaktifkan tombol agar tidak bisa diklik dua kali

            // Ambil nilai status, customer_id, cash_id, dan type_payment
            var status = $('input[name="status"]:checked').val();
            var customerId = $('#customer_id').val();
            var cashId = $('#cash_id').val();
            var typePayment = $('#type_payment').val(); // Ambil nilai type_payment

            // Ambil nilai amount dari cash_id yang dipilih
            var cashAmount = $('#cash_id option:selected').data('amount');

            // Validasi jika status "Lunas" dan customer_id kosong
            if ((status === 'Lunas') && !customerId) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Mohon pilih customer.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                }).then(() => {
                    tombolSave.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconSave.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
                });
                return; // Hentikan proses submit jika validasi gagal
            }

            // Validasi jika cash_id kosong untuk status "Lunas"
            if (status === 'Lunas' && !cashId) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Mohon pilih Kas Pembayaran.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                }).then(() => {
                    tombolSave.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconSave.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
                });
                return; // Hentikan proses submit jika validasi gagal
            }

            // Validasi jika type_payment kosong untuk status "Lunas"
            if (status === 'Lunas' && !typePayment) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Mohon pilih jenis pembayaran.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                }).then(() => {
                    tombolSave.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconSave.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
                });
                return; // Hentikan proses submit jika validasi gagal
            }


            const formData = new FormData(this); // Ambil data formulir

            $.ajax({
                url: "{{ route('orders.update', $order->id) }}",
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    // Kembalikan status tombol dan ikon setelah sukses
                    tombolSave.prop('disabled', false); // Aktifkan tombol kembali
                    iconSave.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula

                    Swal.fire('Sukses!', response.message, 'success').then(() => {
                        window.location.href = "{{ route('orders.index') }}"; // Redirect setelah sukses
                    });
                },
                error: function(xhr) {
                    // Kembalikan status tombol dan ikon setelah error
                    tombolSave.prop('disabled', false); // Aktifkan tombol kembali
                    iconSave.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula

                    Swal.fire('Error!', 'Terjadi kesalahan saat menyimpan.', 'error');
                }
            });
        });
    });
</script>



@endpush