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
            'patente.required' => 'Indique la patente del auto',
            'patente.size' => 'La patente debe tener 6 caracteres',
            'patente.unique' => 'La patente :input ya existe en el sistema',
            'modelo.required' => 'Indique modelo del auto',
            'modelo.min' => 'El modelo deebe tener como mínimo 3 caracteres',
            'precio.required' => 'Indique precio del auto',
            'precio.integer' => 'El precio no puede llevar decimales',
            'precio.gte' => 'El precio debe ser como mínimo $1',
        ];
    }
}
