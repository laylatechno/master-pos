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
                                <a class="text-muted text-decoration-none" href="{{ route('achievements.index') }}">Halaman Pencapaian</a>
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

                        <form method="POST" action="{{ route('achievements.store') }}">
                            @csrf
                            <div class="row">

                                <!-- Field Dasar -->
                                <div class="form-group mb-3">
                                    <label for="name">Nama Achievement</label>
                                    <input type="text" id="name" name="name" class="form-control" value="{{ old('name') }}" required>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="duration">Durasi (dalam bulan/minggu)</label>
                                    <input type="text" id="duration" name="duration" class="form-control" value="{{ old('duration') }}" >
                                </div>

                                <div class="form-group mb-3">
                                    <label for="age">Usia (Contoh: 4-8 bulan)</label>
                                    <input type="text" id="age" name="age" class="form-control" value="{{ old('age') }}" >
                                </div>

                                <div class="form-group mb-3">
                                    <label for="reference">Referensi</label>
                                    <input type="text" id="reference" name="reference" class="form-control" value="{{ old('reference') }}">
                                </div>

                                <div class="form-group mb-3">
                                    <label for="description">Deskripsi</label>
                                    <textarea id="description" name="description" class="form-control">{{ old('description') }}</textarea>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="position">Urutan</label>
                                    <input type="text" id="position" name="position" class="form-control" value="{{ old('position') }}">
                                </div>

                                <!-- Dropdown untuk Aspek Perkembangan -->
                                <div class="form-group mb-3">
                                    <label for="development_category_id">Aspek Perkembangan</label>
                                    <select id="development_category_id" name="development_category_id" class="form-control" required>
                                        @foreach ($developmentCategories as $category)
                                        <option value="{{ $category->id }}" {{ old('development_category_id') == $category->id ? 'selected' : '' }}>
                                            {{ $category->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Checkbox/Multiple Select untuk Stimuli -->
                                <div class="form-group mb-3">
                                    <label for="stimuli_ids">Pilih Stimuli</label>
                                    <select id="stimuli_ids" name="stimuli_ids[]" class="form-control" multiple>
                                        @foreach ($stimuli as $stimulus)
                                        <option value="{{ $stimulus->id }}" {{ in_array($stimulus->id, old('stimuli_ids', [])) ? 'selected' : '' }}>
                                            {{ $stimulus->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Checkbox/Multiple Select untuk Produk -->
                                <div class="form-group mb-3">
                                    <label for="product_ids">Pilih Produk</label>
                                    <select id="product_ids" name="product_ids[]" class="form-control" multiple>
                                        @foreach ($products as $product)
                                        <option value="{{ $product->id }}" {{ in_array($product->id, old('product_ids', [])) ? 'selected' : '' }}>
                                            {{ $product->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <div class="col-xs-12 col-sm-12 col-md-12 mt-3">
                                    <button type="submit" class="btn btn-primary btn-sm mb-3"><i class="fa fa-save"></i> Simpan</button>
                                    <a class="btn btn-warning btn-sm mb-3" href="{{ route('achievements.index') }}"><i class="fa fa-undo"></i> Kembali</a>
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
<script src="{{ asset('template/back') }}/dist/js/forms/select2.init.js"></script>

<script>
    $(document).ready(function() {
        $('#development_category_id').select2();
        $('#stimuli_ids').select2();
        $('#product_ids').select2();
    });
</script>
@endpush