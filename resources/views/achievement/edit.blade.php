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
                            <li class="breadcrumb-item"><a class="text-muted text-decoration-none" href="{{ route('achievements.index') }}">Halaman Pencapaian</a></li>
                            <li class="breadcrumb-item">{{ $subtitle }}</li>
                        </ol>
                    </nav>
                </div>
                <div class="col-3">
                    <div class="text-center mb-n5">
                        <img src="{{ asset('template/back') }}/dist/images/breadcrumb/ChatBc.png" alt="" class="img-fluid mb-n4">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="datatables">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            @if (count($errors) > 0)
                            <div class="alert alert-danger">
                                <strong>Whoops!</strong> Ada beberapa masalah dengan data yang anda masukkan.<br><br>
                                <ul>
                                    @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                            @endif

                            <form method="POST" action="{{ route('achievements.update', $data_achievement->id) }}">
                                @csrf
                                @method('PUT')

                                <!-- Nama -->
                                <div class="form-group mb-3">
                                    <label for="name">Nama</label>
                                    <input type="text" name="name" class="form-control" id="name" value="{{ $data_achievement->name }}" required>
                                </div>

                                <!-- Referensi -->
                                <div class="form-group mb-3">
                                    <label for="reference">Referensi</label>
                                    <input type="text" name="reference" class="form-control" id="reference" value="{{ $data_achievement->reference }}">
                                </div>

                                <!-- Deskripsi -->
                                <div class="form-group mb-3">
                                    <label for="description">Deskripsi</label>
                                    <textarea class="form-control" name="description" id="description" required>{{ $data_achievement->description }}</textarea>
                                </div>



                                <!-- Durasi -->
                                <div class="form-group mb-3">
                                    <label for="duration">Durasi</label>
                                    <input type="text" name="duration" class="form-control" id="duration" value="{{ $data_achievement->duration }}" required>
                                </div>

                                <!-- Usia -->
                                <div class="form-group mb-3">
                                    <label for="age">Usia</label>
                                    <input type="number" name="age" class="form-control" id="age" value="{{ $data_achievement->age }}" required>
                                </div>

                                <!-- Urutan -->
                                <div class="form-group mb-3">
                                    <label for="position">Urutan</label>
                                    <input type="number" name="position" class="form-control" id="position" value="{{ $data_achievement->position }}" required>
                                </div>

                                <!-- Kategori Perkembangan -->
                                <div class="form-group mb-3">
                                    <label for="development_category_id">Kategori Perkembangan</label>
                                    <select name="development_category_id" class="form-control" id="development_category_id" required>
                                        @foreach($developmentCategories as $category)
                                        <option value="{{ $category->id }}"
                                            {{ $data_achievement->development_category_id == $category->id ? 'selected' : '' }}>
                                            {{ $category->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Stimuli -->
                                <div class="form-group mb-3">
                                    <label for="stimuli">Stimuli Terkait</label>
                                    <select name="stimuli_ids[]" class="form-control select2" multiple="multiple" id="stimuli">
                                        @foreach($stimuli as $stimulus)
                                        <option value="{{ $stimulus->id }}"
                                            {{ in_array($stimulus->id, $data_achievement->stimuli->pluck('id')->toArray()) ? 'selected' : '' }}>
                                            {{ $stimulus->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Produk Terkait -->
                                <div class="form-group mb-3">
                                    <label for="products">Produk Terkait</label>
                                    <select name="product_ids[]" class="form-control select2" multiple="multiple" id="products">
                                        @foreach($products as $product)
                                        <option value="{{ $product->id }}"
                                            {{ in_array($product->id, $data_achievement->products->pluck('id')->toArray()) ? 'selected' : '' }}>
                                            {{ $product->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Buttons -->
                                <div class="mt-3">
                                    <button type="submit" class="btn btn-primary btn-sm mb-3"><i class="fa fa-save"></i> Update</button>
                                    <a class="btn btn-warning btn-sm mb-3" href="{{ route('achievements.index') }}"><i class="fa fa-undo"></i> Kembali</a>
                                </div>
                            </form>

                        </div>
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