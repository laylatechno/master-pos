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
        Schema::table('purchases', function (Blueprint $table) {
            $table->foreign(['cash_id'])->references(['id'])->on('cash')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['supplier_id'])->references(['id'])->on('suppliers')->onUpdate('no action')->onDelete('cascade');
            $table->foreign(['user_id'])->references(['id'])->on('users')->onUpdate('no action')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
            $table->dropForeign('purchases_cash_id_foreign');
            $table->dropForeign('purchases_supplier_id_foreign');
            $table->dropForeign('purchases_user_id_foreign');
        });
    }
};
