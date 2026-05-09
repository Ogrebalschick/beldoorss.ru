<?php
class ControllerExtensionModuleHttpmlastviewed extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/latest');
		if (!empty($this->session->data['last_viewed'])) {
			$last_viewed = $this->session->data['last_viewed'];
			$last_viewed_count = count($last_viewed);
		} else {
			$last_viewed = array();
			$last_viewed_count = 0;
		}
		if (!empty($setting['product']) && $last_viewed_count < 2 && $setting['name2']) {
			$data['heading_title'] = $setting['name2'];
		} else {
			$data['heading_title'] = $setting['name'];
		}

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}
		$products = array();
		if ($last_viewed_count < $setting['limit'] && !empty($setting['product'])) {
			$products = array_merge($last_viewed, $setting['product']);
		} else if ($last_viewed_count > 0) {
			$products = $last_viewed;
		} else if (!empty($setting['product'])) {
			$products = $setting['product'];
		}

		if ($setting['view'] == 's') {
			$setting['width'] = $this->config->get($this->config->get('config_theme') . '_image_product_width');
			$setting['height'] = $this->config->get($this->config->get('config_theme') . '_image_product_height');
		} else {
			$setting['width'] = $this->config->get($this->config->get('config_theme') . '_image_additional_width');
			$setting['height'] = $this->config->get($this->config->get('config_theme') . '_image_additional_height');
		}
		$data['view'] = $setting['view'];
		if ($setting['rowclass']) {
			$data['rowclass'] = $setting['rowclass'];
		} else {
			$data['rowclass'] = 'row';
		}
		if ($setting['class']) {
			$data['class'] = $setting['class'];
		} else {
			$data['class'] = 'col-md-3 col-sm-6 col-xs-12';
		}
		
		if (!empty($products)) {
			$products = array_slice($products, 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/httpmlastviewed', $data);
		}
	}
}