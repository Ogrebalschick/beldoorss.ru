<?php
class ControllerExtensionModuleSpecial extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/special');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');


		/*mmr*/
		$this->load->language('product/product');
		$this->load->language('extension/module/moneymaker2');
		$data['moneymaker2_text_old_price'] = $this->language->get('text_old_price');
		$data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$data['moneymaker2_modules_quickorder_display_catalog'] = $this->config->get('moneymaker2_modules_quickorder_display_catalog');
			$data['moneymaker2_modules_quickorder_button_title'] = $this->config->get('moneymaker2_modules_quickorder_button_title');
			$data['moneymaker2_modules_quickorder_button_title'] = isset($data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')] : null;
		}
		$data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
		$data['moneymaker2_common_wishlist_hide'] = $this->config->get('moneymaker2_common_wishlist_hide');
		$data['moneymaker2_common_wishlist_caption'] = $this->config->get('moneymaker2_common_wishlist_caption');
		$data['moneymaker2_common_compare_hide'] = $this->config->get('moneymaker2_common_compare_hide');
		$data['moneymaker2_common_compare_caption'] = $this->config->get('moneymaker2_common_compare_caption');
		$data['moneymaker2_common_cart_outofstock_disabled'] = $this->config->get('moneymaker2_common_cart_outofstock_disabled');
		$data['moneymaker2_common_price_detached'] = $this->config->get('moneymaker2_common_price_detached');
		$data['moneymaker2_stickers_mode'] = $this->config->get('moneymaker2_modules_stickers_mode');
		$data['moneymaker2_stickers_size_catalog'] = $this->config->get('moneymaker2_modules_stickers_size_catalog');
		$data['moneymaker2_modules_special_carousel'] = $this->config->get('moneymaker2_modules_special_carousel');
		$data['moneymaker2_modules_special_carousel_autoplay'] = $this->config->get('moneymaker2_modules_special_carousel_autoplay');
		if ($data['moneymaker2_modules_special_carousel']) {
			$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
			$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.moneymaker2.css');
			$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
		}
		/*mmr*/
		
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		$filter_data = array(
			'sort'  => 'pd.name',
			'order' => 'ASC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$results = $this->model_catalog_product->getProductSpecials($filter_data);

		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					
				if ($result['price'] > 0) {
				    
				if ($result['price'] > 0) {
				    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
				    $price = $this->language->get('text_price_free');
				}
			
				} else {
				    $price = $this->language->get('text_price_free');
				}
			
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}

				
		/*mmr*/
		$moneymaker2_stickers = array();
		if ($special) {
			if ($this->config->get('moneymaker2_modules_stickers_specials_enabled')) {
				$moneymaker2_modules_stickers_specials_caption = $this->config->get('moneymaker2_modules_stickers_specials_caption');
				$moneymaker2_modules_stickers_specials_discount = $this->config->get('moneymaker2_modules_stickers_specials_discount') ? ($this->config->get('moneymaker2_modules_stickers_specials_discount_mode') ? "-".round(100-(($result['special']/$result['price'])*100))."%" : "-".$this->currency->format((($result['special'])-($result['price']))*(-1), $this->session->data['currency'])) : '';
				$moneymaker2_stickers[] = array(
					'type' => 'special',
					'icon' => $this->config->get('moneymaker2_modules_stickers_specials_icon'),
					'caption' => $this->config->get('moneymaker2_modules_stickers_specials_discount') ? "<b>".$moneymaker2_modules_stickers_specials_discount."</b> ".(isset($moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')] : null) : (isset($moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')] : null),
				);
			}
		}
		if ($result['viewed']) {
			if ($this->config->get('moneymaker2_modules_stickers_popular_enabled')) {
				if ($result['viewed']>=$this->config->get('moneymaker2_modules_stickers_popular_limit')) {
					$moneymaker2_modules_stickers_popular_caption = $this->config->get('moneymaker2_modules_stickers_popular_caption');
					$moneymaker2_stickers[] = array(
						'type' => 'popular',
						'icon' => $this->config->get('moneymaker2_modules_stickers_popular_icon'),
						'caption' => isset($moneymaker2_modules_stickers_popular_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_popular_caption[$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($result['rating']) {
			if ($this->config->get('moneymaker2_modules_stickers_rated_enabled')) {
				if ($result['rating']>=$this->config->get('moneymaker2_modules_stickers_rated_limit')) {
					$moneymaker2_modules_stickers_rated_caption = $this->config->get('moneymaker2_modules_stickers_rated_caption');
					$moneymaker2_stickers[] = array(
						'type' => 'rated',
						'icon' => $this->config->get('moneymaker2_modules_stickers_rated_icon'),
						'caption' => isset($moneymaker2_modules_stickers_rated_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_rated_caption[$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($result['date_available']) {
			if ($this->config->get('moneymaker2_modules_stickers_new_enabled')) {
				if ((round((strtotime(date("Y-m-d"))-strtotime($result['date_available']))/86400))<=$this->config->get('moneymaker2_modules_stickers_new_limit')) {
					$moneymaker2_modules_stickers_new_caption = $this->config->get('moneymaker2_modules_stickers_new_caption');
					$moneymaker2_stickers[] = array(
						'type' => 'new',
						'icon' => $this->config->get('moneymaker2_modules_stickers_new_icon'),
						'caption' => isset($moneymaker2_modules_stickers_new_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_new_caption[$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		$moneymaker2_modules_stickers_customs = $this->config->get('moneymaker2_modules_stickers_customs');
		if (!empty($moneymaker2_modules_stickers_customs)){
			foreach ($moneymaker2_modules_stickers_customs as $key => $value) {
				if (isset($result[$value['field']])&&$result[$value['field']]) {
					$moneymaker2_modules_stickers_custom_caption = $value['caption'];
					$moneymaker2_stickers[] = array(
						'type' => 'custom'.$key,
						'icon' => $value['icon'],
						'caption' => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($result['quantity'] <= 0) { $moneymaker2_stock = "<span class='stock'><span>" . $result['stock_status'] . "</span></span>"; } else { $moneymaker2_stock = "<span class='stock instock'><!--" . $this->language->get('text_stock') . "--> <span>" . $this->language->get('text_instock') . "</span></span>"; }
		if ($this->config->get('moneymaker2_catalog_products_code_field')&&isset($result[$this->config->get('moneymaker2_catalog_products_code_field')])&&$result[$this->config->get('moneymaker2_catalog_products_code_field')]&&$this->config->get('moneymaker2_modules_special_code')) {$moneymaker2_code = "<span class='code'>".$this->language->get('text_model')." <span>".$result[$this->config->get('moneymaker2_catalog_products_code_field')]."</span></span>";} else {$moneymaker2_code = '';}
		$moneymaker2_addtocart_tooltip = '';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0) {
			if (!$data['moneymaker2_common_price_detached']) { $moneymaker2_addtocart_tooltip = "<p class='text-muted'>" . $data['button_cart'] . "</p>"; }
			$moneymaker2_addtocart_tooltip .= "<p>".$moneymaker2_stock."</p>";
		} else if (!$data['moneymaker2_common_price_detached']) {
			$moneymaker2_addtocart_tooltip .= "<p>".$data['button_cart']."</p>";
		}
		if ($price&&$special) { $moneymaker2_addtocart_tooltip .= "<p>".$data['moneymaker2_text_old_price']." ".$price."</p>"; }
		$moneymaker2_addtocart_class = 'btn ';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0) {
			$moneymaker2_addtocart_class .= 'disabled ';
		}
		if (!$special) {
			$moneymaker2_addtocart_class .= 'btn-primary';
		} else {
			$moneymaker2_addtocart_class .= 'btn-danger';
		}
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$moneymaker2_quickorder_tooltip = '';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0) {
				$moneymaker2_quickorder_tooltip .= "<p class='text-muted'>" . $data['moneymaker2_modules_quickorder_button_title'] . "</p>";
				$moneymaker2_quickorder_tooltip .= "<p>" . $moneymaker2_stock . "</p>";
			} else {
				$moneymaker2_quickorder_tooltip .= "<p>" . $data['moneymaker2_modules_quickorder_button_title'] . "</p>";
			}
			$moneymaker2_quickorder_class = 'btn btn-default';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0) {
				$moneymaker2_quickorder_class .= ' disabled';
			}
		}
		$data['products'][] = array(
			'stickers'              => $moneymaker2_stickers,
			'stock'                 => $this->config->get('moneymaker2_modules_special_stock') ? $moneymaker2_stock : '',
			'code'                  => $this->config->get('moneymaker2_modules_special_code') ? $moneymaker2_code : '',
			'sold'                  => $data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0 ? true : false,
			'quantity'              => $result['quantity'],
			'sort_order'            => $result['sort_order'],
			'review_count'          => $result['reviews'],
			'addtocart_tooltip'     => $moneymaker2_addtocart_tooltip,
			'addtocart_class'       => $moneymaker2_addtocart_class,
			'quickorder_tooltip'    => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_tooltip : '',
			'quickorder_class'      => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_class : '',
		/*mmr*/
		
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => $this->config->get('moneymaker2_modules_special_description') ? utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..' : '',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			return $this->load->view('extension/module/special', $data);
		}
	}
}