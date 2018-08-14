<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\Vehicles */

use yii\helpers\{Html, Url};
use yii\bootstrap\ActiveForm;
use yii\captcha\Captcha;
use yii\base\BaseObject;
use yii\base\Component;
use yii\base\Widget;
use yii\widgets\BaseListView;
use yii\grid\GridView;
use yii\data\ActiveDataProvider;

$this->title = 'Транспорт';
$this->params['breadcrumbs'][] = $this->title;

?>
<div class="site-contact">
    <h1><?= Html::encode($this->title) ?></h1>
<?php
		
		$dataProvider = new ActiveDataProvider([
			'query' => $model->getVList(),
			'pagination' => [
			'pageSize' => 10,
			],
		]);
	    echo GridView::widget([
			'dataProvider' => $dataProvider,
			'columns' => [
				[        
					'attribute' => '_type',
					'format' => 'text',
					'label' => 'Тип с.п.',],
				[      
					'attribute' => '_brand',
					'format' => 'text',
					'label' => 'Марка',],
				[      
					'attribute' => '_model',
					'format' => 'raw',
					'label' => 'Модель',
					'value' => function($data){
						return Html::a($data['_model'], Url::to('index.php?r=site/history&rv_id='.$data['_id']));
					}],
				[      
					'attribute' => '_rnum',
					'format' => 'text',
					'label' => 'Рег. номер',],
				[      
					'attribute' => '_yman',
					'format' => 'text',
					'label' => 'Год выпуска',
					'value' => function($data){
						return substr($data['_yman'],0, 4);
					}],
					
				[      
					'attribute' => '_pph',
					'format' => 'text',
					'label' => 'Цена за сутки',
					'value' => function($data){
						return $data['_pph']*24;
					}],
			],
		]);
		
	?>
    <?php /*endif;*/ ?>
</div>
