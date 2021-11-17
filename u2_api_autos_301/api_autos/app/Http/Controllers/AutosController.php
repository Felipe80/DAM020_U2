<?php

namespace App\Http\Controllers;

use App\Models\Auto;
use App\Http\Requests\AutosRequest;
use Illuminate\Http\Request;

class AutosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $autos = Auto::all();
        foreach($autos as $auto){
            $auto->load('marca');
        }
        return $autos;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(AutosRequest $request)
    {
        $auto = new Auto();
        $auto->patente = $request->patente;
        $auto->modelo = $request->modelo;
        $auto->precio = $request->precio;
        $auto->marca_id = $request->marca;
        $auto->save();
        return $auto;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Auto  $auto
     * @return \Illuminate\Http\Response
     */
    public function show(Auto $auto)
    {
        $auto->load('marca');
        return $auto;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Auto  $auto
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Auto $auto)
    {
        $auto->patente = $request->patente;
        $auto->modelo = $request->modelo;
        $auto->precio = $request->precio;
        $auto->marca_id = $request->marca;
        $auto->save();
        return $auto;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Auto  $auto
     * @return \Illuminate\Http\Response
     */
    public function destroy(Auto $auto)
    {
        $auto->delete();
    }
}
