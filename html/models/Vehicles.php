<?php

namespace app\models;

/**
 * Vehicles модель работы с данными о транспортном парке.
 */
class Vehicles extends \yii\db\ActiveRecord 

{
	private static $list;


    /**
     * @return  
     */
    public function getVList() // Т.с. списком, только актуальные
    {
		if($list=Vehicles::find()->where(['_actual' => 't'])){
			return $list;			
		} 
        return false;
    }
    public function getVArray() // Т.с. массивом
    {
		if($list=Vehicles::find()->asArray()->all()){
			return $list;			
		} 
        return false;
    }

    public function getVData($vfr_id) // Данные по конкретному т.с.
    {		
		if($data=Vehicles::findOne(['_id'=>$vfr_id])){			
			return $data;			
		} 
        return false;
    }

}
