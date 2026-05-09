<?php
class ControllerExtensionModuleFileManagerElfinder extends Controller {
    private $error = [];
    private $token;
    private $code = 'elfinder';
    private $elfinder;

    public function index() {

        $version = 1.2;

        $this->load->language('extension/module/FileManagerElfinder');
        $module_title = $this->language->get('heading_title') . ' ' .$version;
        $this->document->setTitle($module_title);
        $data['heading_title'] = $module_title;
        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                $this->model_setting_setting->editSetting('FileManagerElfinder', $this->request->post);
                $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/FileManagerElfinder', 'token=' . $this->session->data['token'], true)
        );

        $data['text_edit'] = $this->language->get('text_edit');
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['text_extension'] = $this->language->get('text_extension');
        $data['tab_setting'] = $this->language->get('tab_setting');
        $data['tab_support'] = $this->language->get('tab_support');
        $data['info_contacts'] = $this->language->get('info_contacts');
        $data['info_support_tooltip'] = $this->language->get('info_support_tooltip');
        $data['info_mail'] = $this->language->get('info_mail');
        $data['info_support'] = $this->language->get('info_support');
        $data['info_host'] = $this->language->get('info_host');
 
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->request->post['FileManagerElfinder_setting'])) {
            $FileManagerElfinder =  $data['FileManagerElfinder_setting'] = (array) $this->request->post['FileManagerElfinder_setting'];
        } else {
            $FileManagerElfinder = $data['FileManagerElfinder_setting'] = (array) $this->config->get('FileManagerElfinder_setting');
        }

        $data['token'] = $this->session->data['token'];

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        $data['action'] = $this->url->link('extension/module/FileManagerElfinder', 'token=' . $this->session->data['token'], true);

        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/FileManager', $data));
    }

    public function install() {
        $this->load->model('setting/setting');
        
        $this->model_setting_setting->editSetting('FileManagerElfinder', array(
            'FileManagerElfinder_setting' => array(
                'status' => '0'
            )
        ));
   
    }

    public function uninstall() {
        $this->load->model('extension/extension');
        $this->model_extension_extension->uninstall('module', 'FileManagerElfinder');
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/FileManagerElfinder')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }  
        $FileManagerElfinder = (array) $this->request->post['FileManagerElfinder_setting'];
        
        return !$this->error;
    }

    public function __construct($registry) {
        parent::__construct($registry);

        $this->token = 'token=' . $this->session->data['token'];

        $this->load->model('extension/modification');
        $this->elfinder = $this->model_extension_modification->getModificationByCode($this->code);
    }

    public function manager() {
        $this->load->language('extension/module/FileManagerElfinder');
        $data['heading_title'] = $this->language->get('heading_title');

        if (isset($this->request->get['target'])) {
            $data['target'] = $this->request->get['target'];
        } else {
            $data['target'] = '';
        }
        if (isset($this->request->get['thumb'])) {
            $data['thumb'] = $this->request->get['thumb'];
        } else {
            $data['thumb'] = '';
        }
        if (isset($this->request->get['summernote'])) {
            $data['summernote'] = $this->request->get['summernote'];
        } else {
            $data['summernote'] = '';
        }

        if (isset($this->request->get['ckeditor'])) {
            $data['ckeditor'] = $this->request->get['ckeditor'];
        } else {
            $data['ckeditor'] = '';
        }
        
        if (isset($this->request->get['multiple'])) {
            $data['multiple'] = true;
        } else {
            $data['multiple'] = false;
        }

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $base = HTTPS_SERVER;
        } else {
            $base = HTTP_SERVER;
        }

        $data['url_connector'] = $base . 'index.php?route=extension/module/FileManagerElfinder/connector&' . $this->token;
        $data['base_url'] = 'view/javascript/FileManagerElfinder/';

        $this->response->setOutput($this->load->view('extension/module/FileManagerElfinder', $data));
    }

    public function access($attr, $path, $data, $volume, $isDir, $relpath) {
        $basename = basename($path);
        return $basename[0] === '.'
        && strlen($relpath) !== 1 
            ? !($attr == 'read' || $attr == 'write')
            :  null;
    }
    
    public function debug() {
        $arg = func_get_args();
        ob_start();
        foreach($arg as $v) {
            var_dump($v);
        }
        $o = ob_get_contents();
        ob_end_clean();
        file_put_contents('.debug.txt', $o, FILE_APPEND);
    }

    public function connector() {

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $base = HTTPS_CATALOG;
        } else {
            $base = HTTP_CATALOG;
        }
        
        is_readable(DIR_SYSTEM . 'library/vendor/FileManagerElfinder/php/autoload.php') && require_once DIR_SYSTEM . 'library/vendor/FileManagerElfinder/php/autoload.php';
        elFinder::$netDrivers['ftp'] = 'FTP';
        $opts = [
            'bind' => [
                    'upload.pre mkdir.pre mkfile.pre rename.pre archive.pre ls.pre' => [
                     'Plugin.Normalizer.cmdPreprocess'
                 ],
                 'upload.presave paste.copyfrom' => [
                     'Plugin.Normalizer.onUpLoadPreSave'
                 ]
             ],
             // global configure (optional)
             'plugin' => [
                 'Normalizer' => [
                     'enable'    => true,
                     'nfc'       => true,
                     'nfkc'      => true,
                     'umlauts'   => false,
                     'lowercase' => false,
                     'convmap'   => [
                        ',' => '_',
                        '^' => '_',
                        '"' => '_',
                        " " => "_",
                        "'" => "",
                        "\\" => "_",
                        "/" => "_",
                        ":" => "_",
                        "*" => "_",
                        "?" => "_",
                        "<" => "_",
                        ">" => "_",
                        "|" => "_",
                        "а" => "a",
                        "б" => "b",
                        "в" => "v",
                        "г" => "g",
                        "ґ" => "g",
                        "д" => "d",
                        "е" => "e",
                        "ё" => "e",
                        "ж" => "zh",
                        "з" => "z",
                        "и" => "y",
                        "і" => "i",
                        "ї" => "yi",
                        "й" => "j",
                        "к" => "k",
                        "л" => "l",
                        "м" => "m",
                        "н" => "n",
                        "о" => "o",
                        "п" => "p",
                        "р" => "r",
                        "с" => "s",
                        "т" => "t",
                        "у" => "u",
                        "ф" => "f",
                        "х" => "h",
                        "ц" => "ts",
                        "ч" => "ch",
                        "ш" => "sh",
                        "щ" => "shch",
                        "ы" => "y",
                        "э" => "e",
                        "є" => "ye",
                        "ю" => "yu",
                        "я" => "ya",
                        "А" => "a",
                        "Б" => "b",
                        "В" => "v",
                        "Г" => "g",
                        "Ґ" => "g",
                        "Д" => "d",
                        "Е" => "e",
                        "Ё" => "e",
                        "Ж" => "zh",
                        "З" => "z",
                        "И" => "y",
                        "І" => "i",
                        "Ї" => "yi",
                        "Й" => "j",
                        "К" => "k",
                        "Л" => "l",
                        "М" => "m",
                        "Н" => "n",
                        "О" => "o",
                        "П" => "p",
                        "Р" => "r",
                        "С" => "s",
                        "Т" => "t",
                        "У" => "u",
                        "Ф" => "f",
                        "Х" => "h",
                        "Ц" => "ts",
                        "Ч" => "ch",
                        "Ш" => "sh",
                        "Щ" => "shch",
                        "Ы" => "y",
                        "Э" => "e",
                        "Є" => "ye",
                        "Ю" => "yu",
                        "Я" => "ya"
                    ]
                 ]
             ],
            'roots' => [
                [
                    'driver'        => 'LocalFileSystem',
                    'path'          => DIR_IMAGE. 'catalog/',  
                    'URL'           => $base . 'image/catalog/',
                    'tmbURL'        => $base . 'image/cache/FileManagerElfinder/',
                    'tmbPath'       => DIR_IMAGE . 'cache/FileManagerElfinder',
                    'tmbSize' => 100,
                    'copyJoin'      => false,
                    'winHashFix'    => DIRECTORY_SEPARATOR !== '/',
                    'uploadDeny'    => ['all'],
                    'uploadAllow'   => [
                        'image/jpeg',
                        'image/pjpeg',
                        'image/png',
                        'image/x-png',
                        'image/svg+xml',
                        'image/svg',
                        'image/gif'
                    ],
                    'uploadOrder'   => ['deny', 'allow'],
                    'accessControl' => 'access',
                    'tmbGcMaxlifeHour' => 1,
                    'tmbGcPercentage'  => 10,
                ]
            ]
        ];

        $connector = new elFinderConnector(new elFinder($opts));
        $connector->run();
    }
}
