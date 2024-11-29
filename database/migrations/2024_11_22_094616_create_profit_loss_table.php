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
        Schema::create('profit_loss', function (Blueprint $table) {
            $table->id();
            $table->foreignId('general_ledger_id')->constrained()->onDelete('cascade'); // Referensi ke general ledger
            $table->decimal('amount', 15, 2); // Jumlah laba/rugi
            $table->enum('type', ['income', 'expense']); // Tipe laba/rugi (pendapatan atau beban)
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('profit_loss');
    }
};
