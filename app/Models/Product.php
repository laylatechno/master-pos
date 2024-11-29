<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *	
     * @var array
     */

    protected $table = 'products';
    protected $guarded = [];

     // Relasi dengan Category
     public function category()
     {
         return $this->belongsTo(Category::class);
     }
 
     // Relasi dengan Unit
     public function unit()
     {
         return $this->belongsTo(Unit::class);
     }

    public function productPrices()
    {
        return $this->hasMany(ProductPrice::class);
    }

    public function product()
{
    return $this->belongsTo(Product::class);
}

    

    
    

}
