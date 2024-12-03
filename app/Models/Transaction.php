<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    protected $table = 'transactions';
    protected $guarded = [];

    public function category()
    {
        return $this->belongsTo(TransactionCategory::class, 'transaction_category_id');
    }
}
