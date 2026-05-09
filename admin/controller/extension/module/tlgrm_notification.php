<?php 
class ControllerExtensionModuleTlgrmNotification extends Controller {
	private $error = array();

	public function index() {

		$this->load->language('extension/module/tlgrm_notification');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting'); 

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('tlgrm_notification', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			if ($this->request->post['apply']) {
				$this->response->redirect($this->url->link('extension/module/tlgrm_notification', 'token=' . $this->session->data['token'], true));
			}
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] .'&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_download'] = $this->language->get('button_download');
		$data['button_clear'] = $this->language->get('button_clear');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_log'] =	$this->language->get('text_log');	
		$data['text_send_1'] = $this->language->get('text_send_1');
		$data['text_send_2'] = $this->language->get('text_send_2');
		$data['text_send_3'] = $this->language->get('text_send_3');
		$data['text_about']	= $this->language->get('text_about');
		$data['text_author'] = $this->language->get('text_author');
		$data['text_help_module'] = $this->language->get('text_help_module');
		$data['text_service_web'] = $this->language->get('text_service_web');
		$data['text_service_telegram'] = $this->language->get('text_service_telegram');
		$data['text_service_seo'] = $this->language->get('text_service_seo');
		$data['text_service_module'] = $this->language->get('text_service_module');
		$data['text_test'] = $this->language->get('text_test');
		$data['text_goods'] = $this->language->get('text_goods');
		$data['text_error'] = $this->language->get('text_error');
		$data['text_send'] = $this->language->get('text_send');
		$data['text_setting'] = $this->language->get('text_setting');
		$data['text_notification'] = $this->language->get('text_notification');
		$data['text_data'] = $this->language->get('text_data');
		$data['text_support'] = $this->language->get('text_support');
		$data['text_field_merger_help'] = $this->language->get('text_field_merger_help');
		$data['text_custom_text'] = $this->language->get('text_custom_text');
		$data['text_sort'] = $this->language->get('text_sort');
		$data['text_variable'] = $this->language->get('text_variable');
		$data['text_description'] = $this->language->get('text_description');

		$data['help_send_1'] = $this->language->get('help_send_1');
		$data['help_send_2'] = $this->language->get('help_send_2');
		$data['help_send_3'] = $this->language->get('help_send_3');

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_separator'] = $this->language->get('entry_separator');
		$data['entry_info']	= $this->language->get('entry_info');
		$data['entry_payment'] = $this->language->get('entry_payment');
		$data['entry_shipping'] = $this->language->get('entry_shipping');
		$data['entry_product'] = $this->language->get('entry_product');
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true),
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/tlgrm_notification', 'token=' . $this->session->data['token'], true),
		);

		$data['action'] = $this->url->link('extension/module/tlgrm_notification', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true);
		$data['downloadLog'] = $this->url->link('extension/module/tlgrm_notification/downloadLog', 'token=' . $this->session->data['token'], true);
		$data['clearLog'] = $this->url->link('extension/module/tlgrm_notification/clearLog', 'token=' . $this->session->data['token'], true);
		$data['token'] = $this->session->data['token'];

		$data_mas = array(
			'id',
			'token',
			'send',
			'status',
			'log',
			'field_merger',
			'title_order',
			'title_shipping',
			'title_payment',
			'title_product',
			'title_simple',
			'separator_order',
			'separator_shipping',
			'separator_payment',
			'separator_product',
			'separator_simple',
			'status_comment',
			'new_order',
			'new_review',
			'new_customer',
			'contact_form',
			'new_order_status',
			'return_order',
			'customer_firstname',
			'customer_lastname',
			'customer_email',
			'customer_telephone',
			'review_name',
			'review_text',
			'review_rating',
			'review_product_name',
			'contact_name',
			'contact_email',
			'contact_comment',
			'return_order_id',
			'return_firstname',
			'return_lastname',
			'return_email',
			'return_telephone',
			'return_date_ordered',
			'return_product',
			'return_model',
			'return_quantity',
			'return_reason',
			'return_opened',
			'return_comment'
		);

		$data_mas_text = array(
			'order_id',
			'store_name',
			'store_url',
			'date_added',
			'firstname',
			'lastname',
			'email',
			'telephone',
			'comment',
			'total',
			'order_status',
			'customer_id',
			'payment_method',
			'shipping_method',
			'payment_firstname',
			'payment_lastname',
			'payment_company',
			'payment_address_1',
			'payment_address_2',
			'payment_postcode',
			'payment_city',
			'payment_zone',
			'payment_country',
			'shipping_firstname',
			'shipping_lastname',
			'shipping_company',
			'shipping_address_1',
			'shipping_address_2',
			'shipping_postcode',
			'shipping_city',
			'shipping_zone',
			'shipping_country',
			'product_name',
			'product_sku',
			'product_model',
			'product_id',
			'product_link',
			'product_quantity',
			'product_price',
			'product_total',
			'product_option',
			'product_upc',
			'product_ean',
			'product_jan',
			'product_isbn',
			'product_mpn',
			'product_location'
		);

		foreach ($data_mas as $key => $value) {
			if (isset($this->request->post['tlgrm_notification_'.$value])) {
				$data['tlgrm_notification_'.$value] = $this->request->post['tlgrm_notification_'.$value];
			} else {
				$data['tlgrm_notification_'.$value] = $this->config->get('tlgrm_notification_'.$value);
			}
			$data['entry_'.$value] = $this->language->get('entry_'.$value);
		}

		foreach ($data_mas_text as $key => $value) {
			if (isset($this->request->post['tlgrm_notification_'.$value])) {
				$data['tlgrm_notification_'.$value] = $this->request->post['tlgrm_notification_'.$value];
			} else {
				$data['tlgrm_notification_'.$value] = $this->config->get('tlgrm_notification_'.$value);
			}
			if (isset($this->request->post['tlgrm_notification_text_'.$value])) {
				$data['tlgrm_notification_text_'.$value] = $this->request->post['tlgrm_notification_text_'.$value];
			} else {
				$data['tlgrm_notification_text_'.$value] = $this->config->get('tlgrm_notification_text_'.$value);
			}
			if (isset($this->request->post['tlgrm_notification_sort_'.$value])) {
				$data['tlgrm_notification_sort_'.$value] = $this->request->post['tlgrm_notification_sort_'.$value];
			} else {
				$data['tlgrm_notification_sort_'.$value] = $this->config->get('tlgrm_notification_sort_'.$value);
			}
			$data['entry_'.$value] = $this->language->get('entry_'.$value);
		}

		$settings = json_decode($this->config->get('simple_settings'), true);
		$result = array();

		if (!empty($settings['fields'])) {
		    foreach ($settings['fields'] as $fieldSettings) {
		        if ($fieldSettings['custom']) {
		            $result[$fieldSettings['id']] = $fieldSettings;
		        }
		    }
		    foreach ($result as $key => $value) {
		    	$lang_code = str_replace('-', '_', $this->config->get('config_language'));
		    	
		    	$tlgrm_simple = $this->config->get('tlgrm_notification_simple');
				if (isset($this->request->post['tlgrm_notification_simple'][$value['id']])) {
					$data['tlgrm_notification_simple'][$value['id']] = $this->request->post['tlgrm_notification_simple'][$value['id']];
				} else if (isset($tlgrm_simple[$value['id']])) {
					$data['tlgrm_notification_simple'][$value['id']] = $tlgrm_simple[$value['id']];
				} else {
					$data['tlgrm_notification_simple'][$value['id']] = '';
				}

				$tlgrm_text_simple = $this->config->get('tlgrm_notification_text_simple');
				if (isset($this->request->post['tlgrm_notification_text_simple'][$value['id']])) {
					$data['tlgrm_notification_text_simple'][$value['id']] = $this->request->post['tlgrm_notification_text_simple'][$value['id']];
				} else if (isset($tlgrm_text_simple[$value['id']])) {
					$data['tlgrm_notification_text_simple'][$value['id']] = $tlgrm_text_simple[$value['id']];
				} else {
					$data['tlgrm_notification_text_simple'][$value['id']] = '';
				}

				$tlgrm_sort_simple = $this->config->get('tlgrm_notification_sort_simple');
				if (isset($this->request->post['tlgrm_notification_sort_simple'][$value['id']])) {
					$data['tlgrm_notification_sort_simple'][$value['id']] = $this->request->post['tlgrm_notification_sort_simple'][$value['id']];
				} else if (isset($tlgrm_sort_simple[$value['id']])) {
					$data['tlgrm_notification_sort_simple'][$value['id']] = $tlgrm_sort_simple[$value['id']];
				} else {
					$data['tlgrm_notification_sort_simple'][$value['id']] = '';
				}

				$data['entry_'.$value['id']] = $value['label'][$lang_code];
			}
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$order_status_zero = array(
			'order_status_id' => 0,
			'name'			  => $this->language->get('text_order_status_zero'),
		);

		array_unshift($data['order_statuses'],$order_status_zero);

		$tlgrm_template = $this->config->get('tlgrm_notification_template_order_status');
		foreach ($data['order_statuses'] as $order_status) {
			if (isset($this->request->post['tlgrm_notification_template_order_status'][$order_status['order_status_id']])) {
				$data['tlgrm_notification_template_order_status'][$order_status['order_status_id']] = $this->request->post['tlgrm_notification_template_order_status'][$order_status['order_status_id']];
			} else if (isset($tlgrm_template[$order_status['order_status_id']])) {
				$data['tlgrm_notification_template_order_status'][$order_status['order_status_id']] = $tlgrm_template[$order_status['order_status_id']];
			} else {
				$data['tlgrm_notification_template_order_status'][$order_status['order_status_id']] = '';
			}
		}
		
		$data['send_test'] = htmlspecialchars_decode($this->url->link('extension/module/tlgrm_notification/sendTest', 'token=' . $this->session->data['token'], true));

		$log = $this->log();
		$data['log'] = $log['log'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/tlgrm_notification', $data));
	}

	public function sendTest() {
		$this->load->language('extension/module/tlgrm_notification');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$link = 'https://api.telegram.org/bot';

    		$chat_ids = $this->request->post['id'];
    	    $sendToTelegram = $link . $this->request->post['tk'];

    	    if ($chat_ids) {
	  			$chat_ids = explode(",", $chat_ids);
		        foreach ($chat_ids as $chat_id) {
		            $chat_id = trim($chat_id);
					$params = array(
					    'chat_id' => $chat_id,
					    'text' => $this->language->get('text_send_test') . ' ' . $this->request->server['HTTP_HOST'],
					    'parse_mode' =>'html'
					);
					$ch = curl_init($sendToTelegram . '/sendMessage');
					curl_setopt($ch, CURLOPT_HEADER, false);
					curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($ch, CURLOPT_POST, 1);
					curl_setopt($ch, CURLOPT_POSTFIELDS, ($params));
					curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
					$result = curl_exec($ch);
					$log = new Log('telegram_notification.log');
					$log->write($chat_id . ' - ' . $result);
					curl_close($ch);
		        }
			}
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput($result);
		}
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/tlgrm_notification')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}	

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	public function log() {

		$data['log'] = '';

		$file = DIR_LOGS . 'telegram_notification.log';

		if (file_exists($file)) {
			$size = filesize($file);

			if ($size >= 5242880) {
				$suffix = array(
					'B',
					'KB',
					'MB',
					'GB',
					'TB',
					'PB',
					'EB',
					'ZB',
					'YB'
				);

				$i = 0;

				while (($size / 1024) > 1) {
					$size = $size / 1024;
					$i++;
				}

				$data['error_warning'] = sprintf($this->language->get('error_warning'), basename($file), round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i]);
			} else {
				$data['log'] = file_get_contents($file, FILE_USE_INCLUDE_PATH, null);
			}
		}

		return $data;
	}

	public function downloadLog() {
		$this->load->language('extension/module/tlgrm_notification');

		$file = DIR_LOGS . 'telegram_notification.log';

		if (file_exists($file) && filesize($file) > 0) {
			$this->response->addheader('Pragma: public');
			$this->response->addheader('Expires: 0');
			$this->response->addheader('Content-Description: File Transfer');
			$this->response->addheader('Content-Type: application/octet-stream');
			$this->response->addheader('Content-Disposition: attachment; filename="' . $this->config->get('config_name') . '_' . date('Y-m-d_H-i-s', time()) . '_telegram_notification.log"');
			$this->response->addheader('Content-Transfer-Encoding: binary');

			$this->response->setOutput(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		} else {
			$this->session->data['error'] = sprintf($this->language->get('error_warning'), basename($file), '0B');

			$this->response->redirect($this->url->link('extension/module/tlgrm_notification', 'token=' . $this->session->data['token'], true));
		}
	}
	
	public function clearLog() {
		$this->load->language('extension/module/tlgrm_notification');

		if (!$this->user->hasPermission('modify', 'extension/module/tlgrm_notification')) {
			$this->session->data['error'] = $this->language->get('error_permission');
		} else {
			$file = DIR_LOGS . 'telegram_notification.log';

			$handle = fopen($file, 'w+');

			fclose($handle);

			$this->session->data['success'] = $this->language->get('text_success');
		}

		$this->response->redirect($this->url->link('extension/module/tlgrm_notification', 'token=' . $this->session->data['token'], true));
	}
}
?>