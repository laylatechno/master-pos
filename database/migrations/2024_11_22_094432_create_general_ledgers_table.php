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
        Schema::create('general_ledgers', function (Blueprint $table) {
            $table->id();
            $table->string('account_name');
            $table->string('account_code')->unique(); // Kode akun yang unik
            $table->decimal('balance', 15, 2)->default(0.00); // Saldo akun
            $table->enum('type', ['asset', 'liability', 'equity', 'revenue', 'expense']); // Tipe akun
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('general_ledgers');
    }
};
