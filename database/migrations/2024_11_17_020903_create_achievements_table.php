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
        Schema::create('achievements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('development_category_id')->constrained('development_categories');
            $table->string('name');
            $table->integer('duration');  // Durasi dalam hari atau bulan
            $table->integer('age');  // Rentang usia (misalnya, 4-8 bulan)
            $table->text('reference')->nullable();
            $table->text('description');
            $table->integer('position');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('achievements');
    }
};
