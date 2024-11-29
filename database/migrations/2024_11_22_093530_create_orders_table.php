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
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->date('order_date');
            $table->string('no_order', 50)->nullable();
            $table->unsignedBigInteger('customer_id')->nullable()->index('orders_customer_id_foreign');
            $table->unsignedBigInteger('user_id')->index('orders_user_id_foreign');
            $table->unsignedBigInteger('cash_id')->nullable()->index('cash_id');
            $table->bigInteger('total_cost')->default(0);
            $table->string('status');
            $table->string('image')->nullable();
            $table->text('description')->nullable();
            $table->string('type_payment', 50)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
