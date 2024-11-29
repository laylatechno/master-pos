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
        Schema::table('menu_items', function (Blueprint $table) {
            $table->foreign(['menu_group_id'])->references(['id'])->on('menu_groups')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['parent_id'])->references(['id'])->on('menu_items')->onUpdate('no action')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('menu_items', function (Blueprint $table) {
            $table->dropForeign('menu_items_menu_group_id_foreign');
            $table->dropForeign('menu_items_parent_id_foreign');
        });
    }
};
