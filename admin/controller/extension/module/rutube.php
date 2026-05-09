<?php
class ControllerExtensionModuleRutube extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('extension/module/rutube');
        $this->document->setTitle($this->language->get('heading_title'));

        // Загружаем только модель настроек, так как запись в модульную таблицу не нужна
        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            // Сохраняем настройки модуля
            $this->model_setting_setting->editSetting('rutube', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');

            // Перенаправление на страницу расширений модуля
            $this->response->redirect(
                $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
            );
        }

        // Заголовки и языковые переменные
        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        // Формирование хлебных крошек
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], true)
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/rutube', 'token=' . $this->session->data['token'], true)
        );

        // URL для отправки формы и отмены
        $data['action'] = $this->url->link('extension/module/rutube', 'token=' . $this->session->data['token'], true);
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        // Получаем ранее сохранённое значение статуса или устанавливаем значение по умолчанию
        if (isset($this->request->post['rutube_status'])) {
            $data['rutube_status'] = $this->request->post['rutube_status'];
        } else {
            $data['rutube_status'] = $this->config->get('rutube_status');
        }

        // Подключаем шаблоны страницы
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/rutube', $data));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/rutube')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        return !$this->error;
    }

    public function install(){
        // При установке добавляем новое поле для видео в таблицу товаров
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product` ADD `video` VARCHAR(300) AFTER `image`");
    }

    public function uninstall(){
        // При удалении расширения удаляем поле для видео из таблицы товаров
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product` DROP `video`");
    }
}
?>