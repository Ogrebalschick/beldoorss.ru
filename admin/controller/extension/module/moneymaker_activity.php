<?php
class ControllerExtensionModuleMoneymakerActivity extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/moneymaker_activity');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('moneymaker_activity', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_tab_common'] = $this->language->get('entry_tab_common');
		$data['entry_tab_help'] = $this->language->get('entry_tab_help');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_customer_name'] = $this->language->get('entry_customer_name');
		$data['entry_customer_city'] = $this->language->get('entry_customer_city');
		$data['entry_customer_date'] = $this->language->get('entry_customer_date');
		$data['entry_speed'] = $this->language->get('entry_speed');
		$data['entry_help_text'] = $this->language->get('entry_help_text');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
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

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/moneymaker_activity', 'token=' . $this->session->data['token'], true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/moneymaker_activity', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/moneymaker_activity', 'token=' . $this->session->data['token'], true);
		} else {
			$data['action'] = $this->url->link('extension/module/moneymaker_activity', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
		}

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['title'])) {
			$data['title'] = $this->request->post['title'];
		} elseif (!empty($module_info)) {
			$data['title'] = $module_info['title'];
		} else {
			$data['title'] = '';
		}

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}
		if (isset($this->request->post['customer_name'])) {
			$data['customer_name'] = $this->request->post['customer_name'];
		} elseif (!empty($module_info)) {
			$data['customer_name'] = $module_info['customer_name'];
		} else {
			$data['customer_name'] = '';
		}
		if (isset($this->request->post['customer_city'])) {
			$data['customer_city'] = $this->request->post['customer_city'];
		} elseif (!empty($module_info)) {
			$data['customer_city'] = $module_info['customer_city'];
		} else {
			$data['customer_city'] = '';
		}
		if (isset($this->request->post['customer_date'])) {
			$data['customer_date'] = $this->request->post['customer_date'];
		} elseif (!empty($module_info)) {
			$data['customer_date'] = $module_info['customer_date'];
		} else {
			$data['customer_date'] = '';
		}
		if (isset($this->request->post['speed'])) {
			$data['speed'] = $this->request->post['speed'];
		} elseif (!empty($module_info)&&$module_info['speed']) {
			$data['speed'] = $module_info['speed'];
		} else {
			$data['speed'] = 2;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/moneymaker_activity', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/moneymaker_activity')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}
}