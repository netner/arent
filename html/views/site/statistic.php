<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\Rents */

use yii\helpers\{Html, Url};
use yii\bootstrap\ActiveForm;
use yii\bootstrap\Modal;
use yii\base\BaseObject;
use yii\base\Component;
use yii\base\Widget;
use yii\widgets\BaseListView;
use yii\grid\GridView;
use yii\data\ActiveDataProvider;

$this->title = 'Статистика';
$this->params['breadcrumbs'][] = $this->title;

?>
<div class="site-contact">
    <h1><?= Html::encode($this->title) ?></h1>
<?php

		$dataProvider = new ActiveDataProvider([
			'query' => $model->getStatList(),
			'pagination' => [
			'pageSize' => 10,
			],
		]);
		
	    echo GridView::widget([
			'dataProvider' => $dataProvider,
			'columns' => [
				[        
					'attribute' => 'office_',
					'format' => 'text',
					'label' => 'Офис',],
				[      
					'attribute' => 'brand_',
					'format' => 'text',
					'label' => 'Марка',],
				[      
					'attribute' => 'rent_time',
					'format' => 'text',
					'label' => 'Среднее время аренды в часах',
					],
			],
		]);
?>
</div>


