<?php

namespace app\models;

/**
 * History модель вывода данных о транспортном парке.
 */
class History extends \yii\db\ActiveRecord 

{
	public $vfr_id;
	public $start_date;
	public $end_date;
	public $customer;
	private static $list;

    /**
     * @return  Формируем список имеющегося в наличии транспорта.
     */
    public function getHList($vfr_id) // История списком (объект)
    {
		if($list=History::find()->where(['_vid' => $vfr_id])){
			return $list;			
		} 
        return false;
    }

}
