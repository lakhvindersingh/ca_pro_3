<?php
if(strstr($_SERVER['HTTP_HOST'], 'localhost')) { //localhost
	$config['fb_app_id'] = 1125956484086498;
	define('CAPTCHASITEKEY', '6LfpyQYTAAAAAOrRI7xR4ztFJ_HxD2v_uzL3ajt1');
	define('CAPTCHASECRETKEY', '6LfpyQYTAAAAAPxpKK2MkA-AKPuFB3Jk1V2m1R3q');
	define('BASE_URL', 'http://www.localhost.com/teacher-tracking/website/');
} elseif(strstr($_SERVER['HTTP_HOST'], 'www.localhost.com')) { //localhost
	$config['fb_app_id'] = 1125956484086498;
	define('CAPTCHASITEKEY', '6LfpyQYTAAAAAOrRI7xR4ztFJ_HxD2v_uzL3ajt1');
	define('CAPTCHASECRETKEY', '6LfpyQYTAAAAAPxpKK2MkA-AKPuFB3Jk1V2m1R3q');
	define('BASE_URL', 'http://www.localhost.com/teacher-tracking/website/');
} elseif(strstr($_SERVER['HTTP_HOST'], 'demo.xicom.us')) { //demo
	$config['fb_app_id'] = 1125387760810037;
	define('CAPTCHASITEKEY', '6LfpyQYTAAAAAOrRI7xR4ztFJ_HxD2v_uzL3ajt1');
	define('CAPTCHASECRETKEY', '6LfpyQYTAAAAAPxpKK2MkA-AKPuFB3Jk1V2m1R3q');
	define('BASE_URL', 'http://demo.xicom.us/Teacher/');
} else { //prod
	$config['fb_app_id'] = '';
	define('CAPTCHASITEKEY', '6LfpyQYTAAAAAOrRI7xR4ztFJ_HxD2v_uzL3ajt1');
	define('CAPTCHASECRETKEY', '6LfpyQYTAAAAAPxpKK2MkA-AKPuFB3Jk1V2m1R3q');
	define('BASE_URL', 'http://www.localhost.com/Teacher/');
}

define('USERIMAGELIMIT', 6);
define('ADMINGROUPID', 1);
define('USERGROUPID', 2);
define('CLIENTGROUPID', 3);
define('ADMINPAGINATIONLIMIT', 20);
define('EDIT_AREA', 1); // 1 is true, rest is false
define('DELETE_AREA', 1); // 1 is true, rest is false

//There 2 moved in app controller to make dynamic
//define('ADD_AREA_LIMIT', 2);
//define('ADD_STUDENT_LIMIT', 40);


//define('UPLOAD_IMAGE_PATH', WWW_ROOT.'users_uploads/');
//define('UPLOAD_IMAGE_URL', 'users_uploads/');

define('USER_IMAGE_PATH', 'user/');
define('USER_IMAGE_URL', 'user/');

define('SECRET_KEY_APP','asgtfsdaf3242saf325asgfa35saf');
$config['gender_arr'][1] = 'Male';
$config['gender_arr'][2] = 'Female';
