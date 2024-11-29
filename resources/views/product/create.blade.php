@extends('layouts.app')
@push('css')
<link rel="stylesheet" href="{{ asset('template/back') }}/dist/libs/select2/dist/css/select2.min.css">
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
                                <a class="text-muted text-decoration-none" href="{{ route('products.index') }}">Halaman Produk</a>
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
                        <!-- Error Message -->
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

                        <!-- Tabs -->
                        <ul class="nav nav-tabs" id="formTabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="general-tab" data-bs-toggle="tab" href="#general" role="tab" aria-controls="general" aria-selected="true">General</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="harga-tab" data-bs-toggle="tab" href="#harga" role="tab" aria-controls="harga" aria-selected="false">Harga Lain</a>
                            </li>
                        </ul>

                        <!-- Tab Content -->
                        <form method="POST" action="{{ route('products.store') }}" enctype="multipart/form-data">
                            @csrf
                            <div class="tab-content mt-3" id="formTabsContent">
                                <!-- General Tab -->
                                <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                                    <div class="form-group mb-3">
                                        <label for="name">Nama Produk</label>
                                        <input type="text" name="name" class="form-control" id="name" value="{{ old('name') }}" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="category_id">Kategori Produk</label>
                                        <select id="category_id" name="category_id" class="form-control" required>
                                            <option value="" disabled selected>--Pilih Kategori Produk--</option>
                                            @foreach ($data_categories as $p)
                                            <option value="{{ $p->id }}" {{ old('category_id') == $p->id ? 'selected' : '' }}>{{ $p->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="unit_id">Satuan</label>
                                        <select id="unit_id" name="unit_id" class="form-control" required>
                                            <option value="" disabled selected>--Pilih Satuan--</option>
                                            @foreach ($data_units as $p)
                                            <option value="{{ $p->id }}" {{ old('unit_id') == $p->id ? 'selected' : '' }}>{{ $p->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-6 mb-3">
                                            <label for="purchase_price">Harga Beli</label>
                                            <input type="text" name="purchase_price" class="form-control" id="purchase_price" value="{{ old('purchase_price') }}" placeholder="Masukkan Harga" oninput="formatPrice(this)">
                                        </div>
                                        <div class="form-group col-6 mb-3">
                                            <label for="cost_price">Harga Jual</label>
                                            <input type="text" name="cost_price" class="form-control" id="cost_price" value="{{ old('cost_price') }}" placeholder="Masukkan Harga Jual" oninput="formatPrice(this)">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-6 mb-3">
                                            <label for="stock">Stok</label>
                                            <input type="number" name="stock" class="form-control" id="stock" value="{{ old('stock') }}">
                                        </div>
                                        <div class="form-group col-6 mb-3">
                                            <label for="reminder">Reminder Stok Minimum</label>
                                            <input type="number" name="reminder" class="form-control" id="reminder" value="{{ old('reminder') }}">
                                        </div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="description">Deskripsi</label>
                                        <textarea class="form-control" name="description" id="description" required>{{ old('description') }}</textarea>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="image">Gambar</label>
                                        <input type="file" name="image" class="form-control" id="image" onchange="previewImage()">
                                        <canvas id="preview_canvas" style="display: none; max-width: 100%; margin-top: 10px;"></canvas>
                                        <img id="preview_image" src="#" alt="Preview Logo" style="display: none; max-width: 100%; margin-top: 10px;">

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
                                                        var maxWidth = 300; // Max width diperbesar
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
                                    </div>
                                </div>

                                <!-- Harga Tab -->
                                <div class="tab-pane fade" id="harga" role="tabpanel" aria-labelledby="harga-tab">
                                    <div id="customer-prices-container">
                                        <div id="customer-prices">
                                            <div class="customer-price-row mb-3">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <label for="customer_category_id">Kategori Konsumen</label>
                                                        <select name="customer_category_id[]" class="form-control" required>
                                                            <option value="" disabled selected>-- Pilih Kategori Konsumen --</option>
                                                            @foreach ($data_customer_categories as $p)
                                                            <option value="{{ $p->id }}" {{ old('customer_category_id.0') == $p->id ? 'selected' : '' }}>{{ $p->name }}</option>
                                                            @endforeach
                                                        </select>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <label for="customer_price">Harga</label>
                                                        <input type="text" name="customer_price[]" class="form-control" value="{{ old('customer_price.0') }}" placeholder="Masukkan Harga" oninput="formatPrice(this)" required>
                                                    </div>
                                                    <div class="col-md-2 d-flex align-items-end">
                                                        <button type="button" class="btn btn-danger btn-sm remove-row"><i class="fa fa-trash"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" id="add-customer-price" class="btn btn-success btn-sm mt-3"><i class="fa fa-plus"></i> Tambah</button>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-12 col-sm-12 col-md-12 mt-3">
                                <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-save"></i> Simpan</button>
                                <a class="btn btn-warning btn-sm" href="{{ route('products.index') }}"><i class="fa fa-undo"></i> Kembali</a>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Tambah Baris Baru
        document.addEventListener("DOMContentLoaded", function() {
            const container = document.getElementById("customer-prices");
            const addButton = document.getElementById("add-customer-price");

            addButton.addEventListener("click", function() {
                const newRow = document.createElement("div");
                newRow.classList.add("customer-price-row", "mb-3");
                newRow.innerHTML = `
            <div class="row">
                <div class="col-md-5">
                    <label>Kategori Konsumen</label>
                    <select name="customer_category_id[]" class="form-control" required>
                        <option value="" disabled selected>-- Pilih Kategori Konsumen --</option>
                        @foreach ($data_customer_categories as $p)
                            <option value="{{ $p->id }}" {{ old('customer_category_id') == $p->id ? 'selected' : '' }}>{{ $p->name }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-5">
                    <label>Harga</label>
                    <input type="text" name="customer_price[]" class="form-control" placeholder="Masukkan Harga" oninput="formatPrice(this)" value="{{ old('customer_price[]') }}" required>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-danger btn-sm remove-row"><i class="fa fa-trash"></i></button>
                </div>
            </div>
        `;
                container.appendChild(newRow);
            });

            // Hapus Baris
            container.addEventListener("click", function(event) {
                if (event.target.classList.contains("remove-row") || event.target.closest(".remove-row")) {
                    const row = event.target.closest(".customer-price-row");
                    row.remove();
                }
            });
        });

        // Format Harga
        function formatPrice(input) {
            let value = input.value.replace(/[^0-9.]/g, '');
            let parts = value.split('.');
            if (parts.length > 2) parts = [parts[0], parts[1]];
            parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            input.value = parts.join('.');
        }
    </script>


</div>
@endsection

@push('script')
<script src="{{ asset('template/back') }}/dist/libs/select2/dist/js/select2.full.min.js"></script>
<script src="{{ asset('template/back') }}/dist/libs/select2/dist/js/select2.min.js"></script>
<script src="{{ asset('template/back') }}/dist/js/forms/select2.init.js"></script>

<script>
    $(document).ready(function() {
        $('#unit_id').select2();
        $('#category_id').select2();
        $('#customer_category_id').select2();
    });
</script>
@endpush