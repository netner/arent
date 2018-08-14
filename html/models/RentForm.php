<?php

namespace app\models;

use Yii;
use yii\base\Model;

/**
 * RentForm модель модель работающая с формой аренды.
 */
class RentForm extends Model

{
	public $vfr_id;
	public $start_date;
	public $end_date;
	public $stop_date;
	public $customer;
	private static $list;

    /**
     * @return  Формируем список эпизодов проката по выбраному т.с.
     */
	 
	public function rules() {
        return [
            [['start_date', 'end_date', 'customer'], 'required', 'message' => 'Заполнение всех полей обязательно.'],
			[['start_date', 'end_date'], 'date', 'format' => 'php:Y-m-d','message' => 'Даты должны заполняться в соответствии с форматом: YYYY-MM-DD.'],
        ];
    }	 

}
