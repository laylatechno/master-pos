<?php

namespace App\Http\Controllers;

use App\Models\Blog;
use App\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Validation\Rule;

class BlogsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:blog-list|blog-create|blog-edit|blog-delete', ['only' => ['index', 'show']]);
        $this->middleware('permission:blog-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:blog-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:blog-delete', ['only' => ['destroy']]);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): View
    {
        $title = "Halaman Blog";
        $subtitle = "Menu Blog";
        $data_blog = Blog::all();
        return view('blog.index', compact('data_blog', 'title', 'subtitle'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        $title = "Halaman Tambah Blog";
        $subtitle = "Menu Tambah Blog";
        $data_permission =  Permission::pluck('name','name')->all();
        return view('blog.create', compact('title', 'subtitle','data_permission'));
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
        'name' => 'required|unique:blogs,name',
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

    Blog::create($request->all());

    return redirect()->route('blog.index')
        ->with('success', 'Blog berhasil dibuat.');
}


    /**
     * Display the specified resource.
     *
     * @param  \App\Blog  $blog
     * @return \Illuminate\Http\Response
     */
    public function show($id): View
    
    {
        $title = "Halaman Lihat Blog";
        $subtitle = "Menu Lihat Blog";
        $data_blog = Blog::find($id);
        $data_permission =  Permission::pluck('name','name')->all();
        return view('blog.show', compact('data_blog','title','subtitle','data_permission'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Blog  $blog
     * @return \Illuminate\Http\Response
     */
    public function edit($id): View
    {
        $title = "Halaman Edit Blog";
        $subtitle = "Menu Edit Blog";
        $data_blog = Blog::find($id);
        $data_permission =  Permission::pluck('name','name')->all();
        return view('blog.edit', compact('data_blog','title','subtitle','data_permission'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Blog  $blog
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Blog $blog): RedirectResponse
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

        $blog->update($request->all());

        return redirect()->route('blog.index')
            ->with('success', 'Blog berhasil diperbaharui');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Blog  $blog
     * @return \Illuminate\Http\Response
     */
    public function destroy(Blog $blog): RedirectResponse
    {
        $blog->delete();

        return redirect()->route('blog.index')
            ->with('success', 'Blog berhasil dihapus');
    }
}
