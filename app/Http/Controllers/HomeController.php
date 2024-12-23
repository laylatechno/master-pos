<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Product;
use App\Models\User;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $title = "Halaman Dashboard";
        $subtitle = "Menu Dashboard";
        $totalProduk = Product::count();  
        $totalPengguna = User::count();
        $totalPelanggan = Customer::count();
        return view('home', compact('title', 'subtitle', 'totalProduk','totalPengguna','totalPelanggan'));
    }
}
