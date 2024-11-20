<?php

namespace App\Http\Controllers\Front;
use App\Http\Controllers\Controller;
use App\Models\Slider;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
 

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $title = "Halaman Home";
        $subtitle = "Menu Home";
        $slider = Slider::orderBy('position', 'asc')->get();
        return view('front.home', compact('title','subtitle','slider'));
    }
}
