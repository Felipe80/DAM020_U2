<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AutosRequest extends FormRequest
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
            'patente' => 'required|size:6|unique:autos,patente',
            'modelo' => 'required|min:3',
            'precio' => 'required|integer|gte:1',
        ];
    }

    public function messages(){
        return [
            'patente.required' => 'Ingresar patente del auto',
            'patente.size' => 'Patente debe tener 6 caracteres',
            'patente.unique' => 'La patente :input ya existe en el sistema',
            'modelo.required' => 'Ingresar modelo del auto',
            'modelo.min' => 'Modelo debe tener como mínimo 6 letras',
            'precio.required' => 'Ingresar precio del auto',
            'precio.integer' => 'Precio debe ser número y no debe tener decimales',
            'precio.gte' => 'Precio mínimo es $1',
        ];
    }
}
