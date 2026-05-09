<?php
// HTTP
define('HTTP_SERVER', 'http://beldoorss.local/');

// HTTPS
define('HTTPS_SERVER', 'http://beldoorss.local/');

// DIR
$dir = 'C:/Programms/OSPanel/home/beldoorss.local/public/';

define('DIR_APPLICATION', $dir . 'catalog/');
define('DIR_SYSTEM',      $dir . 'system/');
define('DIR_IMAGE',       $dir . 'image/');
define('DIR_STORAGE',     $dir . 'storage_new.beldoorss.ru/'); // Проверьте, что папка называется именно так
define('DIR_LANGUAGE',    DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE',    DIR_APPLICATION . 'view/theme/');
define('DIR_CONFIG',      DIR_SYSTEM . 'config/');
define('DIR_CACHE',       DIR_STORAGE . 'cache/');
define('DIR_DOWNLOAD',    DIR_STORAGE . 'download/');
define('DIR_LOGS',        DIR_STORAGE . 'logs/');
define('DIR_MODIFICATION', DIR_STORAGE . 'modification/');
define('DIR_SESSION',     DIR_STORAGE . 'session/');
define('DIR_UPLOAD',      DIR_STORAGE . 'upload/');

// DB
define('DB_DRIVER',   'mysqli');
define('DB_HOSTNAME', 'mysql-5.7'); // Указано согласно вашему конфигу ospanel
define('DB_USERNAME', 'root');      // Стандартный пользователь OpenServer
define('DB_PASSWORD', '');          // В OpenServer пароль по умолчанию пустой
define('DB_DATABASE', 'beldoorss'); // Имя БД, которую вы создали локально
define('DB_PORT',     '3306');
define('DB_PREFIX',   'oc_');