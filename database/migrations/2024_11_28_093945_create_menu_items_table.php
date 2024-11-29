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
        Schema::create('menu_items', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->string('icon');
            $table->string('route');
            $table->string('status', 50);
            $table->string('permission_name');
            $table->unsignedBigInteger('menu_group_id')->index('menu_items_menu_group_id_foreign');
            $table->integer('position');
            $table->unsignedBigInteger('parent_id')->nullable()->index('menu_items_parent_id_foreign');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_items');
    }
};
