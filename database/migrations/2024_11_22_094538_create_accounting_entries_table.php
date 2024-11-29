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
        Schema::create('accounting_entries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('general_ledger_id')->constrained()->onDelete('cascade'); // Referensi ke general ledger
            $table->foreignId('order_id')->nullable()->constrained('orders')->onDelete('set null'); // Referensi ke tabel orders
            $table->decimal('debit', 15, 2)->default(0.00); // Debit
            $table->decimal('credit', 15, 2)->default(0.00); // Kredit
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('accounting_entries');
    }
};
