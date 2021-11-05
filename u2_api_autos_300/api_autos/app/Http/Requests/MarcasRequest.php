<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MarcasRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'nombre' => 'required|min:3',
        ];
    }

    public function messages(){
        return [
            'nombre.required' => 'Debe ingresar nombre de la marca de autos',
            'nombre.min' => 'El nombre debe tener 3 letras como mínimo',
        ];
    }
}
