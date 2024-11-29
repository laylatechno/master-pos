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
        Schema::create('purchase_orders', function (Blueprint $table) {
            $table->id();  
            $table->foreignId('supplier_id')->constrained()->onDelete('cascade');  
            $table->foreignId('user_id')->constrained()->onDelete('cascade');  
            $table->date('purchase_orders_date');  
            $table->decimal('total_cost', 15, 2);  
            $table->string('status');
            $table->string('image')->nullable();  
            $table->timestamps();  
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_orders');
    }
};
