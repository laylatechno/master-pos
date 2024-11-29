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
        Schema::create('suppliers', function (Blueprint $table) {
            $table->id(); // ID unik untuk setiap pemasok
            $table->string('name'); // Nama pemasok
            $table->string('email')->nullable(); // Email pemasok
            $table->string('phone')->nullable(); // Nomor telepon pemasok
            $table->text('address')->nullable(); // Alamat pemasok
            $table->timestamps(); // Tanggal pembuatan dan pembaruan data
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('suppliers');
    }
};
