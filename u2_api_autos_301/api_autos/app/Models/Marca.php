<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Marca extends Model
{
    use HasFactory,SoftDeletes;
    protected $table = 'marcas';

    //retorna los autos asociados a la marca
    public function autos(){
        return $this->hasMany(Auto::class);
    }
}
