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

$this->title = 'Добавление информации об аренде';
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="site-contact">
    <h1><?= Html::encode($this->title) ?></h1>

<?php
		//$VData = $model2->getVData($rv_id);
		$VList = $model2->getVArray(); // Получаем данные по т.с.
		$CList = $model3->getCArray(); // Получаем данные по клиентам
		
		foreach ($VList as $item) { // Формируем массив для выпадающего списка транспортных средств
			$dDownVFR[$item['_id']] = $item['_brand']." ".$item['_model']." (". substr($item['_yman'],0, 4).") гос. номер: ". $item['_rnum']." - ".($item['_pph'])*24 ." руб./сутки";
		}
		foreach ($CList as $item) { // Формируем массив для выпадающего списка клиентов
			$dDownCustomers[$item['id']] = $item['full_name'];
		}	
		if(!isset($opResult)||$opResult!="addSuccess"){	// Если операция добавления не происходила или не была успешной, выводим форму

			$form = ActiveForm::begin(['id' => 'Rent-form']); 
?> 			
				<?= Html::tag('div',$dDownVFR[$rv_id], ['class' => 'vModel']) ?>

				<?php //$form->field($model, 'vfr_id')->dropdownList($dDownVFR,['options'=>[$rv_id=>['selected'=>'true']]])->label('Транспортное средство',['class'=>'label-class']);// Возможно потом... ?> 
			
				<?= $form->field($model, 'start_date')->label('Начало аренды') ?>
 
				<?= $form->field($model, 'end_date')->label('Окончание аренды') ?>
 
				<?= $form->field($model, 'customer')->dropdownList($dDownCustomers, ['prompt'=>'Выберите клиента'])->label('Клиент',['class'=>'label-class']);?>
  
				<div class="form-group">
					<?= Html::submitButton('Submit', ['class' => 'btn btn-primary', 'name' => 'contact-button']) ?>
				</div>
			
			<?php ActiveForm::end(); 		

		}else{ //Сообщение об успешном добавлении данных по аренде т.с.
?>
			<?= Html::tag('span','Данные по аренде успешно добавлены.', ['class' => 'allertMessage']) ?>							
<?php	
		}		
	?>
</div>


