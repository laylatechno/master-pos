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
        Schema::create('purchases', function (Blueprint $table) {
            $table->id(); // Unique ID for each purchase
            $table->date('purchase_date'); // Purchase date
            $table->foreignId('supplier_id')->constrained()->onDelete('cascade'); // Reference to suppliers table
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // Reference to users table
            $table->decimal('total_cost', 15, 2); // Total purchase cost
            $table->string('status');
            $table->string('image')->nullable(); // Image for purchase proof (nullable)
            $table->timestamps(); // Created and updated timestamps
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchases');
    }
};
