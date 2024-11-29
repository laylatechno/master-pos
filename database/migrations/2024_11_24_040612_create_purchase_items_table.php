<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('purchase_items', function (Blueprint $table) {
            $table->id(); // ID unik untuk setiap item pembelian
            $table->foreignId('purchase_id')->constrained()->onDelete('cascade'); // Referensi ke tabel pembelian
            $table->foreignId('product_id')->constrained()->onDelete('cascade'); // Referensi ke produk yang dibeli
            $table->integer('quantity'); // Jumlah produk yang dibeli
            $table->bigInteger('price'); // Harga satuan produk
            $table->bigInteger('total_price'); // Harga total untuk item tersebut
            $table->timestamps(); // Tanggal pembuatan dan pembaruan data
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_items');
    }
};
