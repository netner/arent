<?php

namespace app\models;

/**
 * Customers модель работы с данными о клиентах.
 */
class Customers extends \yii\db\ActiveRecord 

{
	private static $list;

    /**
     * @return  Формируем список имеющегося в наличии транспорта.
     */
    public function getCList() // Клиенты списком (объект)
    {
		if($list=Customers::find()){
			return $list;			
		} 
        return false;
    }
	
    public function getCArray() // Клиенты массивом
    {
		if($list=Customers::find()->asArray()->all()){
			return $list;			
		} 
        return false;
    }

    public function getCData($c_id) // Данные по конкретному клиенту
    {
		if($data=Customers::findOne(['id'=>$c_id])){
			return $data;			
		} 
        return false;
    }

}
