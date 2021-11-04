<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MarcasController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Route::get('/marcas',[MarcasController::class,'index']);
// Route::get('/marcas/{marca}',[MarcasController::class,'show']);
// Route::post('/marcas',[MarcasController::class,'store']);
// Route::delete('/marcas/{marca}',[MarcasController::class,'destroy']);
// Route::patch('/marcas/{marca}',[MarcasController::class,'update']);

Route::apiResource('/marcas',MarcasController::class);
