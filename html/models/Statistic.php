<?php

namespace app\models;

/**
 * Statistic модель работы со статистическими данными.
 */
class Statistic extends \yii\db\ActiveRecord 

{
	public $rv_id;
	public $start_date;
	public $end_date;
	public $customer;
	private static $list;

    /**
     * @return  .
     */
    public function getStatList() // Статистика списком (объект)
    {
		if($list=Statistic::find()){
			return $list;			
		} 
        return false;
    }

}
