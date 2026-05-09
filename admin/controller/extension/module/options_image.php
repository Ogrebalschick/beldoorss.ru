<?php
class ControllerExtensionModuleOptionsImage extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/options_image');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$data['version'] = '1.0.0';

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('options_image', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			
			if ($this->request->post['options_image_apply']) {
				$this->response->redirect($this->url->link('extension/module/options_image', 'token=' . $this->session->data['token'], true));
			}

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['entry_product_popup_element'] = $this->language->get('entry_product_popup_element');
		$data['entry_product_popup_attr'] = $this->language->get('entry_product_popup_attr');
		$data['entry_product_thumb_element'] = $this->language->get('entry_product_thumb_element');
		$data['entry_product_thumb_attr'] = $this->language->get('entry_product_thumb_attr');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_edit'] = $this->language->get('text_edit');
		
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
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
			'href' => $this->url->link('extension/module/options_image', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/options_image', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		
		if (isset($this->request->post['options_image_status'])) {
			$data['options_image_status'] = $this->request->post['options_image_status'];
		} else {
			$data['options_image_status'] = $this->config->get('options_image_status');
		}
		
		if (isset($this->request->post['options_image_product_popup_element'])) {
			$data['options_image_product_popup_element'] = $this->request->post['options_image_product_popup_element'];
		} elseif ($this->config->get('options_image_product_popup_element')) {
			$data['options_image_product_popup_element'] = $this->config->get('options_image_product_popup_element');
		} else {
			$data['options_image_product_popup_element'] = '.thumbnails li:first-child a';
		}
		
		if (isset($this->request->post['options_image_product_popup_attr'])) {
			$data['options_image_product_popup_attr'] = $this->request->post['options_image_product_popup_attr'];
		} elseif ($this->config->get('options_image_product_popup_attr')) {
			$data['options_image_product_popup_attr'] = $this->config->get('options_image_product_popup_attr');
		} else {
			$data['options_image_product_popup_attr'] = 'href';
		}
		
		if (isset($this->request->post['options_image_product_thumb_element'])) {
			$data['options_image_product_thumb_element'] = $this->request->post['options_image_product_thumb_element'];
		} elseif ($this->config->get('options_image_product_thumb_element')) {
			$data['options_image_product_thumb_element'] = $this->config->get('options_image_product_thumb_element');
		} else {
			$data['options_image_product_thumb_element'] =  '.thumbnails li:first-child img';
		}
		
		if (isset($this->request->post['options_image_product_thumb_attr'])) {
			$data['options_image_product_thumb_attr'] = $this->request->post['options_image_product_thumb_attr'];
		} elseif ($this->config->get('options_image_product_thumb_attr')) {
			$data['options_image_product_thumb_attr'] = $this->config->get('options_image_product_thumb_attr');
		} else {
			$data['options_image_product_thumb_attr'] =  'src';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/options_image', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/options_image')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
	public function install() {
		$this->load->model('extension/module/options_image');
		$this->model_extension_module_options_image->createColumns();
	}
}