<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use app\models\LoginForm;
use app\models\ContactForm;
use app\models\Vehicles;
use app\models\History;
use app\models\Customers;
use app\models\RentForm;
use app\models\Rents;
use app\models\Statistic;

class SiteController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
			return $this->render('index');
    }

    /**
     * Login action.
     *
     * @return Response|string
     */
    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            return $this->goBack();
        }

        $model->password = '';
        return $this->render('login', [
            'model' => $model,
        ]);
    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    /**
     * Displays contact page.
     *
     * @return Response|string
     */
    public function actionContact()
    {
        $model = new ContactForm();
        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        }
        return $this->render('contact', [
            'model' => $model,
        ]);
    }

    /**
     * Displays about page.
     *
     * @return string
     */
    public function actionAbout()
    {
        return $this->render('about');
    }

	public function actionVehicles()	
    {
		$model = new Vehicles();
        return $this->render('vehicles', ['model' => $model,]);
    }

	public function actionHistory($rv_id)	
    {

		$model = new History();
		$model2 = new Vehicles();
		$model3 = new Customers();
		
		return $this->render('history', ['model' => $model,'model2' => $model2,'model3' => $model3,'rv_id'=>$rv_id]);
		
    }

	public function actionRent($rv_id){
		$model = new RentForm();
		$model2 = new Vehicles();
		$model3 = new Customers();
			
		if ($model->load(Yii::$app->request->post()) && $model->validate()) {

			// Готовим данные для сохранения
			$userModel = Yii::$app->user->identity;
			$model4 = new Rents();			
			$model4->vfr_id = $rv_id;
			$model4->start_date = $model->start_date;
			$model4->end_date = $model->end_date;
			$model4->stop_date = $model->end_date;
			$model4->customer_id = $model->customer;
			$model4->manager_id = $userModel->id;
			
			if($model4->save())	$opResult='addSuccess';
					
			return $this->render('rent', ['model' => $model,'model2' => $model2,'model3' => $model3,'rv_id'=>$rv_id,'opResult'=>$opResult]);
		} else {
			return $this->render('rent', ['model' => $model,'model2' => $model2,'model3' => $model3,'rv_id'=>$rv_id]);
		}   
	}
	public function actionStatistic()	
    {

		$model = new Statistic();
		$model2 = new Vehicles();
		$model3 = new Customers();
		
		return $this->render('statistic', ['model' => $model,'model2' => $model2,'model3' => $model3]);
		
    }
}
