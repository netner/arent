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
use yii\widgets\Pjax;

$this->title = 'История аренды т.с.';
$this->params['breadcrumbs'][] = $this->title;

$this->registerJs("
	$('body').on('click', 'form#Rent-form', function() {
		var form = $(this);
		if (form.find('.has-error').length) {
		return false;
    }
			$.ajax({
				url: form.attr('action'),
				type: 'POST',
				data: form.serialize(),
				success: function(results){

					$(form).find('.results').html(results); 

				}
			});
         return false;
	});				
");

?>
<div class="site-contact">
    <h1><?= Html::encode($this->title) ?></h1>
    <?php
	 
		$VData = $model2->getVData($rv_id);
		$VList = $model2->getVArray();
		$CList = $model3->getCArray();
		
		foreach ($VList as $item) {
			$dDownVFR[$item['_id']] = $item['_brand']." ".$item['_model']." (". substr($item['_yman'],0, 4).") гос. номер: ". $item['_rnum']." - ".($item['_pph'])*24 ." руб./сутки";
		
		}
		//$dDownCustomers[0] = 'Выберите клиента';
		foreach ($CList as $item) {
			$dDownCustomers[$item['id']] = $item['full_name'];
		}
			
		$form = ActiveForm::begin([
			'id' => 'my-form-id',
			'action' => 'save-url',
			'enableAjaxValidation' => true,
			'validationUrl' => 'my-validation-url',
			]);

			echo $form->field($model, 'vfr_id')->dropdownList($dDownVFR,['options'=>[$rv_id=>['selected'=>'true']],'onClick'=>'$.pjax({container: "#pjax-grid-view",url: "index.php?r=site/history&rv_id="+$("#history-vfr_id").val()})'		])->label('Транспортное средство',['class'=>'label-class']);

		$form->end();?>

		<?php 
		$dataProvider = new ActiveDataProvider([
			'query' => $model->getHList($rv_id),
			'pagination' => [
			'pageSize' => 10,
			],
		]);
		Pjax::begin(['id' => 'pjax-grid-view']);
	    echo GridView::widget([
			'dataProvider' => $dataProvider,
			'columns' => [
				[        
					'attribute' => '_start_date',
					'format' => 'text',
					'label' => 'Начало аренды',],
				[      
					'attribute' => '_end_date',
					'format' => 'text',
					'label' => 'Онончание',],
				[      
					'attribute' => '_stop_date',
					'format' => 'raw',
					'label' => 'Возврат Т.С.',
					],
				[      
					'attribute' => '_customer_name',
					'format' => 'text',
					'label' => 'Клиент',],
				[      
					'attribute' => '_manager_name',
					'format' => 'text',
					'label' => 'Менеджер',],
			
			],
		]);
		Pjax::end();
?>
		<p>

		<?= Html::button('Добавить аренду', ['class' => 'btn btn-primary', 'onclick' => 'window.location.href="index.php?r=site/rent&rv_id="+$("#history-vfr_id").val()' ]); ?>


</div>


