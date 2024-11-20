<?php

namespace App\Http\Controllers;

use App\Models\KategoriBlog;
use App\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Validation\Rule;

class KategoriBlogController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:kategori_blog-list|kategori_blog-create|kategori_blog-edit|kategori_blog-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:kategori_blog-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:kategori_blog-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:kategori_blog-delete', ['only' => ['destroy']]);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): View
    {
        $title = "Halaman KategoriBlog";
        $subtitle = "Menu KategoriBlog";
        $data_kategori_blog = KategoriBlog::all();
        return view('kategori_blog.index', compact('data_kategori_blog', 'title', 'subtitle'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah KategoriBlog";
        $subtitle = "Menu Tambah KategoriBlog";
        $data_permission =  Permission::pluck('name','name')->all();
        return view('kategori_blog.create', compact('title', 'subtitle','data_permission'));
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
        'name' => 'required|unique:kategori_blogs,name',
        'permission_name' => 'required',
        'status' => 'required',
        'position' => 'required',
    ], [
        'name.required' => 'Nama wajib diisi.',
        'name.unique' => 'Nama sudah terdaftar.',
        'permission_name.required' => 'Nama Permission wajib diisi.',
        'status.required' => 'Status wajib diisi.',
        'position.required' => 'Urutan wajib diisi.',

    ]);

    KategoriBlog::create($request->all());

    return redirect()->route('kategori_blog.index')
        ->with('success', 'KategoriBlog berhasil dibuat.');
}


    /**
     * Display the specified resource.
     *
     * @param  \App\KategoriBlog  $kategori_blog
     * @return \Illuminate\Http\Response
     */
    public function show($id): View
    
    {
        $title = "Halaman Lihat KategoriBlog";
        $subtitle = "Menu Lihat KategoriBlog";
        $data_kategori_blog = KategoriBlog::find($id);
        $data_permission =  Permission::pluck('name','name')->all();
        return view('kategori_blog.show', compact('data_kategori_blog','title','subtitle','data_permission'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\KategoriBlog  $kategori_blog
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit KategoriBlog";
        $subtitle = "Menu Edit KategoriBlog";
        $data_kategori_blog = KategoriBlog::find($id);
        $data_permission =  Permission::pluck('name','name')->all();
        return view('kategori_blog.edit', compact('data_kategori_blog','title','subtitle','data_permission'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\KategoriBlog  $kategori_blog
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, KategoriBlog $kategori_blog): RedirectResponse
    {
        $this->validate($request, [
            'name' => 'required',
            'permission_name' => 'required',
            'status' => 'required',
            'position' => 'required',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'permission_name.required' => 'Nama Permission wajib diisi.',
            'status.required' => 'Status wajib diisi.',
            'position.required' => 'Urutan wajib diisi.',
    
        ]);

        $kategori_blog->update($request->all());

        return redirect()->route('kategori_blog.index')
            ->with('success', 'KategoriBlog berhasil diperbaharui');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\KategoriBlog  $kategori_blog
     * @return \Illuminate\Http\Response
     */
    public function destroy(KategoriBlog $kategori_blog): RedirectResponse
    {
        $kategori_blog->delete();

        return redirect()->route('kategori_blog.index')
            ->with('success', 'KategoriBlog berhasil dihapus');
    }
}
