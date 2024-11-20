<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DevelopmentCategory extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *	
     * @var array
     */

    protected $table = 'development_categories';
    protected $guarded = [];

    public function achievements()
    {
        return $this->hasMany(Achievement::class);
    }
}
