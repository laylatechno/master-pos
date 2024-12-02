
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
                                <a class="text-muted text-decoration-none" href="{{ route('purchases.index') }}">Halaman Pembelian</a>
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


                        <form id="form-purchase" method="POST" action="{{ route('purchases.update', $purchase->id) }}" enctype="multipart/form-data">
                            @csrf
                            @method('PUT')
                            <input type="hidden" id="purchase_id" name="purchase_id" value="{{ $purchase->id }}">

                            <h5 class="card-title mb-0"><b style="color: blue;">Kode Pembelian : <input type="hidden"
                                        id="no_purchase" name="no_purchase"
                                        value="{{ $purchase->no_purchase }}">{{ $purchase->no_purchase }}</input></b></h5>

                            <br>
                            <hr>
                            <div class="form-group mb-3 col-md-6">
                                <label for="status" class="mb-2"> Status Pembayaran : </label><br>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Pesanan Pembelian" {{ old('status', $purchase->status) == 'Pesanan Pembelian' ? 'checked' : '' }}> Pesanan Pembelian
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Lunas" {{ old('status', $purchase->status) == 'Lunas' ? 'checked' : '' }}> Lunas
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Belum Lunas" {{ old('status', $purchase->status) == 'Belum Lunas' ? 'checked' : '' }}> Belum Lunas
                                </label>
                                <label style="margin-right: 6px;">
                                    <input type="radio" name="status" value="Pending" {{ old('status', $purchase->status) == 'Pending' ? 'checked' : '' }}> Pending
                                </label>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="hari">Tanggal Pembelian</label>
                                        <span class="text-danger">*</span>
                                        <input type="date" class="form-control" id="purchase_date" name="purchase_date" value="{{ old('purchase_date', $purchase->purchase_date ?? date('Y-m-d')) }}">
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="supplier_id">Supplier</label>
                                        <select class="form-control" id="supplier_id" name="supplier_id">
                                            <option value="">--Pilih Supplier--</option>
                                            @foreach ($data_suppliers as $supplierItem)
                                            <option value="{{ $supplierItem->id }}"
                                                {{ old('supplier_id', $purchase->supplier_id) == $supplierItem->id ? 'selected' : '' }}>
                                                {{ $supplierItem->name }}
                                            </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="product_id">Cari Produk</label>
                                        <span class="text-danger">*</span>
                                        <select class="form-control" id="product_id" name="product_id[]" required>
                                            <option value="" disabled>--Pilih Produk--</option>
                                            @foreach ($data_products as $produkItem)
                                            <option value="{{ $produkItem->id }}"
                                                {{ old('product_id', $purchase->product_id) == $produkItem->id ? 'selected' : '' }}
                                                data-purchase-price="{{ $produkItem->purchase_price }}">
                                                {{ $produkItem->name }}
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
                                                {{ old('cash_id', $purchase->cash_id) == $cash->id ? 'selected' : '' }}
                                                data-amount="{{ $cash->amount }}">
                                                {{ $cash->name }} - Rp{{ number_format($cash->amount, 0, ',', '.') }}
                                            </option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>




                            </div>


                            <table id="scroll_hor"
                                class="table border   table-bordered display nowrap"
                                style="width: 100%">
                                <thead>
                                    <tr>
                                        <th width="5%">No</th>
                                        <th style="text-align: left;">Produk</th>
                                        <th>Harga</th>
                                        <th width="15%">Qty</th>
                                        <th>Total</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Menampilkan purchaseItems yang sudah ada -->
                                    @foreach ($purchase->purchaseItems as $index => $item)
                                    <tr data-id="{{ $item->id }}">
                                        <td>{{ $index + 1 }}</td> <!-- Nomor -->
                                        <td style="text-align:left;">
                                            <input type="hidden" name="items[{{ $item->id }}][product_id]" value="{{ $item->product_id }}">
                                            <label>{{ $item->product->name ?? '-' }}</label> <!-- Nama Produk -->
                                        </td>
                                        <td>
                                            <input type="text" class="form-control purchase_price" name="items[{{ $item->id }}][purchase_price]"
                                                value="{{ number_format($item->purchase_price, 0, ',', '.') }}">
                                        </td>
                                        <td>
                                            <input type="number" class="form-control quantity" name="items[{{ $item->id }}][quantity]"
                                                value="{{ $item->quantity }}">
                                        </td>

                                        <td>
                                            <input type="text" class="form-control total" name="items[{{ $item->id }}][total]"
                                                value="{{ number_format($item->purchase_price * $item->quantity, 0, ',', '.') }}">
                                        </td>
                                        <td><button type="button" class="btn btn-danger btn-sm btn-remove-product"><i class="fas fa-trash"></i></button></td>
                                    </tr>
                                    @endforeach
                                </tbody>



                            </table>

                            <!-- Total Bayar dan Input Bayar -->
                            <div class="row mt-4">
                                <div class="col-md-6 mb-3">
                                    <h5 style="color: red; font-size:30px;" class="badge badge-danger"><b>Total
                                            Bayar: </b> Rp.<span id="total_cost">{{ number_format(old('total_cost', $purchase->total_cost ?? 0), 0, ',', '.') }}</span></h5>
                                    <input type="hidden" name="total_cost" id="total_cost_input" class="form-control total_cost"
                                        value="{{ old('total_cost', $purchase->total_cost ?? 0) }}">
                                    <hr>

                                </div>


                                <div class="col-md-6 mb-3">
                                    <div class="form-group" hidden>
                                        <label for="input_payment">Bayar:</label>
                                        <input type="text" class="form-control" id="input_payment" name="input_payment" value="{{ old('input_payment', $purchase->input_payment ?? '') }}">
                                    </div>
                                    <div class="form-group" hidden>
                                        <label for="return_payment">Kembalian:</label>
                                        <input type="text" class="form-control" id="return_payment" name="return_payment" readonly value="{{ old('return_payment', $purchase->return_payment ?? '') }}">
                                    </div>


                                    <div class="form-group mb-3">
                                        <label for="type_payment">Jenis Pembayaran:</label>
                                        <select name="type_payment" id="type_payment" class="form-control">
                                            <option value="">--Pilih Jenis Pembayaran--</option>
                                            <option value="CASH" {{ old('type_payment', $purchase->type_payment) == 'CASH' ? 'selected' : '' }}>CASH</option>
                                            <option value="TRANSFER" {{ old('type_payment', $purchase->type_payment) == 'TRANSFER' ? 'selected' : '' }}>TRANSFER</option>
                                        </select>
                                    </div>

                                    <div class="form-group mb-3" id="image_container">
                                        <label for="image">Gambar:</label>
                                        <input type="file" class="form-control" id="image" name="image" onchange="previewImage()">
                                        <canvas id="preview_canvas" style="display: none; max-width: 80%; margin-top: 10px;"></canvas>
                                        <img id="preview_image" src="{{ old('image', $purchase->image) ? asset('storage/' . $purchase->image) : '#' }}" alt="Preview Logo" style="display: none; max-width: 80%; margin-top: 10px;">
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
                                        <textarea name="description" id="description" class="form-control" cols="30" rows="3">{{ old('description', $purchase->description) }}</textarea>
                                    </div>
                                </div>
                            </div>


                            <div class="border-top">
                                <div class="card-body">
                                    <button type="submit" class="btn btn-success" style="color:white;" id="btn-update-purchase"><i
                                            class="fas fa-save"></i> Simpan</button>
                                    <a href="{{ route('purchases.index') }}" class="btn btn-danger" style="color:white;"><i
                                            class="fas fa-step-backward"></i> Kembali</a>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </section>
</div>











<script>
    $(document).ready(function() {
        const totalCostElement = document.getElementById('total_cost');
        const inputPaymentElement = $('#input_payment');

        // Fungsi untuk menyinkronkan input_payment dengan total_cost
        function syncPaymentWithTotalCost() {
            const totalCost = parseInt($(totalCostElement).text().replace(/[^0-9]/g, '')) || 0;
            inputPaymentElement.val(totalCost); // Atur nilai input_payment sama dengan total_cost
        }

        // Jalankan sinkronisasi saat halaman dimuat
        syncPaymentWithTotalCost();

        // Buat observer untuk memonitor perubahan pada total_cost
        const observer = new MutationObserver(syncPaymentWithTotalCost);

        // Konfigurasi observer
        observer.observe(totalCostElement, {
            characterData: true,
            subtree: true,
            childList: true
        });
    });
</script>  


  <script>
    $(document).ready(function() {
        $('#supplier_id').select2();
        $('#product_id').select2();
        $('#cash_id').select2();
    });
</script>

<script>
    $(document).ready(function() {

        // Format harga rupiah
        function formatRupiah(angka) {
            var number_string = angka.toString().replace(/[^,\d]/g, ''),
                split = number_string.split(','),
                sisa = split[0].length % 3,
                rupiah = split[0].substr(0, sisa),
                ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            if (ribuan) {
                var separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            return split[1] !== undefined ? rupiah + ',' + split[1] : rupiah;
        }

        // Hitung total keseluruhan
        function calculateTotal() {
            var totalBayar = 0;
            $('#scroll_hor tbody tr').each(function() {
                var quantity = parseInt($(this).find('.quantity').val()) || 0;
                var hargaBeli = parseInt($(this).find('.purchase_price').val().replace(/\./g, '')) || 0;
                var total = quantity * hargaBeli;
                $(this).find('.total').val(formatRupiah(total));
                totalBayar += total;
            });
            $('#total_cost').text(formatRupiah(totalBayar));
            $('.total_cost').val(formatRupiah(totalBayar));
        }

        // Update nomor baris
        function updateRowNumbers() {
            $('#scroll_hor tbody tr').each(function(index) {
                $(this).find('td:first').text(index + 1);
            });
        }

        // Tambah produk ke tabel
        $('#product_id').on('change', function() {
            var selectedProductId = $(this).val();
            var selectedProductName = $('#product_id option:selected').text();
            var selectedProductPrice = $('#product_id option:selected').data('purchase-price');

            var existingProductRow = $('#scroll_hor tbody tr').filter(function() {
                return $(this).find('input[name="items[product_id][]"]').val() == selectedProductId;
            });

            if (existingProductRow.length > 0) {
                var quantityInput = existingProductRow.find('.quantity');
                var currentQty = parseInt(quantityInput.val());
                quantityInput.val(currentQty + 1);
            } else {
                var newRow = `
            <tr>
                <td></td>
                <td style="text-align:left;">
                    <input type="hidden" name="items[product_id][]" value="${selectedProductId}">
                    <label>${selectedProductName}</label>
                </td>
                <td><input type="text" class="form-control purchase_price" name="items[purchase_price][]" value="${formatRupiah(selectedProductPrice)}"></td>
                <td><input type="number" class="form-control quantity" name="items[quantity][]" value="1"></td>
                <td><input type="text" class="form-control total" name="items[total][]" readonly></td>
                <td><button type="button" class="btn btn-danger btn-sm btn-remove-product"><i class="fas fa-trash"></i></button></td>
            </tr>`;
                $('#scroll_hor tbody').append(newRow);
            }

            updateRowNumbers();
            calculateTotal();
        });

        // Event listener perubahan quantity
        $(document).on('input', '.quantity, .purchase_price', function() {
            var hargaBeli = $(this).closest('tr').find('.purchase_price').val().replace(/\./g, '');
            $(this).closest('tr').find('.purchase_price').val(formatRupiah(hargaBeli));
            calculateTotal();
        });

        // Event listener hapus produk
        $(document).on('click', '.btn-remove-product', function() {
            $(this).closest('tr').remove();
            updateRowNumbers();
            calculateTotal();
        });
    });
</script>


<script>
    $(document).ready(function() {
        $('#form-purchase').submit(function(e) {
            e.preventDefault();
            const tombolUpdate = $('#btn-update-purchase');
            const iconUpdate = tombolUpdate.find('i'); // Mengambil ikon di dalam tombol

            // Ganti ikon tombol dengan ikon loading
            iconUpdate.removeClass('fas fa-save').addClass('fas fa-spinner fa-spin');
            tombolUpdate.prop('disabled', true); // Menonaktifkan tombol agar tidak bisa diklik dua kali

            // Ambil nilai status, supplier_id, cash_id, dan type_payment
            var status = $('input[name="status"]:checked').val();
            var supplierId = $('#supplier_id').val();
            var cashId = $('#cash_id').val();
            var typePayment = $('#type_payment').val(); // Ambil nilai type_payment

            // Ambil nilai amount dari cash_id yang dipilih
            var cashAmount = $('#cash_id option:selected').data('amount');

            // Validasi jika status "Lunas" dan supplier_id kosong
            if ((status === 'Lunas') && !supplierId) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Mohon pilih supplier.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                }).then(() => {
                    tombolUpdate.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconUpdate.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
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
                    tombolUpdate.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconUpdate.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
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
                    tombolUpdate.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconUpdate.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
                });
                return; // Hentikan proses submit jika validasi gagal
            }

            // Validasi jika total_cost lebih besar dari cashAmount
            var totalBayar = parseInt($('#total_cost').text().replace(/[^0-9]/g, ''));
            if (totalBayar > cashAmount) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Saldo Kas tidak mencukupi.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                }).then(() => {
                    tombolUpdate.prop('disabled', false); // Mengaktifkan kembali tombol
                    iconUpdate.removeClass('fas fa-spinner fa-spin').addClass('fas fa-save'); // Kembalikan ikon semula
                });
                return; // Hentikan proses submit jika validasi gagal
            }

            // Jika semua validasi lolos, lanjutkan ke pengiriman data dengan AJAX
            var formData = new FormData(this); // Menggunakan FormData untuk mengambil data formulir

            $.ajax({
                url: "{{ route('purchases.update', $purchase->id) }}",
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (response.status === 'success') {
                        Swal.fire({
                            title: 'Sukses!',
                            text: response.message, // Pesan sukses dari response
                            icon: 'success',
                            confirmButtonText: 'OK'
                        }).then(function() {
                            window.location.href = "{{ route('purchases.index') }}"; // Redirect setelah sukses
                        });
                    } else {
                        Swal.fire({
                            title: 'Error!',
                            text: 'Terjadi kesalahan saat memperbarui data.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Terjadi kesalahan saat memperbarui data.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    console.error(error);
                }
            });

        });
    });
</script> 
