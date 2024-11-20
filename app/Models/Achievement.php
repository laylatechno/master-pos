<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Achievement extends Model
{

    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *	
     * @var array
     */

    protected $table = 'achievements';
    protected $guarded = [];


    // Relasi ke DevelopmentCategories (one-to-one)
    public function developmentCategory()
    {
        return $this->belongsTo(DevelopmentCategory::class, 'development_category_id');
    }

    // Relasi many-to-many ke Stimuli
    public function stimuli()
    {
        return $this->belongsToMany(Stimuli::class, 'achievement_stimuli', 'achievement_id', 'stimuli_id');
    }
    

    public function products()
    {
        return $this->belongsToMany(Product::class, 'achievement_products', 'achievement_id', 'product_id');
    }
    
}
