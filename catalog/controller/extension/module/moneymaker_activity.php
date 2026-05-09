<?php
class ControllerExtensionModuleMoneymakerActivity extends Controller {
	public function index($setting) {
		static $module = 0;
		$this->load->language('extension/module/moneymaker_activity');
		if (isset($setting['title'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['title'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		}
		$data['activities'] = array();
		$this->load->model('extension/module/moneymaker_activity');
		$results = $this->model_extension_module_moneymaker_activity->getActivities();
		foreach ($results as $result) {
			$from = isset($setting['customer_city'])&&$setting['customer_city']&&isset(json_decode($result['data'], true)['customer_id']) ? $this->model_extension_module_moneymaker_activity->getAddress(json_decode($result['data'], true)['customer_id']) : null;
			$order_id = isset(json_decode($result['data'], true)['order_id']) ? json_decode($result['data'], true)['order_id'] : null;
			$order_products = $order_id ? $this->model_extension_module_moneymaker_activity->getOrderProducts($order_id) : array();
			if (count($order_products)>0) {
			$order_product_title = sprintf($this->language->get('text_product_name'), $this->url->link('product/product', 'product_id=' . $order_products[0]['product_id']), $order_products[0]['name']);
				if (count($order_products)>1) {
					$i = count($order_products)-1;
					$plural = $i%10==1&&$i%100!=11?'singular':($i%10>=2&&$i%10<=4&&($i%100<10||$i%100>=20)?'genitive_singular':'genitive_plural');
					$order_product_title.=sprintf($this->language->get('text_more_products_'.$plural), $i);
				}
			} else $order_product_title = substr($this->language->get('text_more_products_singular'), strrpos($this->language->get('text_more_products_singular'), ' '));
			if (isset($setting['customer_name'])&&$setting['customer_name']) {
				$order_customer_name = explode(' ', ltrim(json_decode($result['data'], true)['name']))[0];
				$named = 'named_';
			} else {
				$order_customer_name = $this->language->get('text_customer');
				$named = '';
			}
			if (isset($from['city'])&&$from['city']) {
				$order_customer_name .= sprintf($this->language->get('text_from_city'), $from['city']);
			}
			$json_array = array($order_customer_name, $order_product_title);
			$comment = sprintf($this->language->get('text_activity_icon'), $this->language->get('text_icon_' . $result['key'])).' '.vsprintf($this->language->get('text_' . $named . $result['key']), $json_array);
			$data['activities'][] = array(
				'comment'    => $comment,
				'date_added' => isset($setting['customer_date'])&&$setting['customer_date'] ? date($this->language->get('datetime_format'), strtotime($result['date_added'])) : ''
			);
		}
		$data['module'] = $module++;
		$data['speed'] = isset($setting['speed'])&&$setting['speed']&&$setting['speed']>2 ? $setting['speed'] : '2';
		$data['text_no_activity'] = $this->language->get('text_no_activity');
		return $this->load->view('extension/module/moneymaker_activity', $data);
	}
}