<?php
class ControllerExtensionModuleFeatured extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured');

		// $data['heading_title'] = $this->language->get('heading_title');
		$data['heading_title'] = $setting['name'];

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
		$data['moneymaker2_modules_featured_carousel'] = $this->config->get('moneymaker2_modules_featured_carousel');
		$data['moneymaker2_modules_featured_carousel_autoplay'] = $this->config->get('moneymaker2_modules_featured_carousel_autoplay');
		if ($data['moneymaker2_modules_featured_carousel']) {
			$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
			$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.moneymaker2.css');
			$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
		}
		/*mmr*/
		
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (!empty($setting['product'])) {

// Featured+
		$lang = $this->config->get('config_language_id');
		$title = isset($setting['titles']['title'.$lang]) && $setting['titles']['title'.$lang] ? $setting['titles']['title'.$lang] : '';

		if (isset($title) && $title) {
			$data['heading_title'] = $title;
		}

		if (isset($setting['shuffle']) && $setting['shuffle']) {
			shuffle($setting['product']);
		}
// Featured+
			
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						
				if ($product_info['price'] > 0) {
				    $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
				    $price = $this->language->get('text_price_free');
				}
			
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

					
		/*mmr*/
		$moneymaker2_stickers = array();
		if ($special) {
			if ($this->config->get('moneymaker2_modules_stickers_specials_enabled')) {
				$moneymaker2_modules_stickers_specials_caption = $this->config->get('moneymaker2_modules_stickers_specials_caption');
				$moneymaker2_modules_stickers_specials_discount = $this->config->get('moneymaker2_modules_stickers_specials_discount') ? ($this->config->get('moneymaker2_modules_stickers_specials_discount_mode') ? "-".round(100-(($product_info['special']/$product_info['price'])*100))."%" : "-".$this->currency->format((($product_info['special'])-($product_info['price']))*(-1), $this->session->data['currency'])) : '';
				$moneymaker2_stickers[] = array(
					'type' => 'special',
					'icon' => $this->config->get('moneymaker2_modules_stickers_specials_icon'),
					'caption' => $this->config->get('moneymaker2_modules_stickers_specials_discount') ? "<b>".$moneymaker2_modules_stickers_specials_discount."</b> ".(isset($moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')] : null) : (isset($moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')] : null),
				);
			}
		}
		if ($product_info['viewed']) {
			if ($this->config->get('moneymaker2_modules_stickers_popular_enabled')) {
				if ($product_info['viewed']>=$this->config->get('moneymaker2_modules_stickers_popular_limit')) {
					$moneymaker2_modules_stickers_popular_caption = $this->config->get('moneymaker2_modules_stickers_popular_caption');
					$moneymaker2_stickers[] = array(
						'type' => 'popular',
						'icon' => $this->config->get('moneymaker2_modules_stickers_popular_icon'),
						'caption' => isset($moneymaker2_modules_stickers_popular_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_popular_caption[$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($product_info['rating']) {
			if ($this->config->get('moneymaker2_modules_stickers_rated_enabled')) {
				if ($product_info['rating']>=$this->config->get('moneymaker2_modules_stickers_rated_limit')) {
					$moneymaker2_modules_stickers_rated_caption = $this->config->get('moneymaker2_modules_stickers_rated_caption');
					$moneymaker2_stickers[] = array(
						'type' => 'rated',
						'icon' => $this->config->get('moneymaker2_modules_stickers_rated_icon'),
						'caption' => isset($moneymaker2_modules_stickers_rated_caption[$this->config->get('config_language_id')]) ? $moneymaker2_modules_stickers_rated_caption[$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($product_info['date_available']) {
			if ($this->config->get('moneymaker2_modules_stickers_new_enabled')) {
				if ((round((strtotime(date("Y-m-d"))-strtotime($product_info['date_available']))/86400))<=$this->config->get('moneymaker2_modules_stickers_new_limit')) {
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
				if (isset($product_info[$value['field']])&&$product_info[$value['field']]) {
					$moneymaker2_modules_stickers_custom_caption = $value['caption'];
					$moneymaker2_stickers[] = array(
						'type' => 'custom'.$key,
						'icon' => $value['icon'],
						'caption' => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
					);
				}
			}
		}
		if ($product_info['quantity'] <= 0) { $moneymaker2_stock = "<span class='stock'><span>" . $product_info['stock_status'] . "</span></span>"; } else { $moneymaker2_stock = "<span class='stock instock'><!--" . $this->language->get('text_stock') . "--> <span>" . $this->language->get('text_instock') . "</span></span>"; }
		if ($this->config->get('moneymaker2_catalog_products_code_field')&&isset($product_info[$this->config->get('moneymaker2_catalog_products_code_field')])&&$product_info[$this->config->get('moneymaker2_catalog_products_code_field')]&&$this->config->get('moneymaker2_modules_featured_code')) {$moneymaker2_code = "<span class='code'>".$this->language->get('text_model')." <span>".$product_info[$this->config->get('moneymaker2_catalog_products_code_field')]."</span></span>";} else {$moneymaker2_code = '';}
		$moneymaker2_addtocart_tooltip = '';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
			if (!$data['moneymaker2_common_price_detached']) { $moneymaker2_addtocart_tooltip = "<p class='text-muted'>" . $data['button_cart'] . "</p>"; }
			$moneymaker2_addtocart_tooltip .= "<p>".$moneymaker2_stock."</p>";
		} else if (!$data['moneymaker2_common_price_detached']) {
			$moneymaker2_addtocart_tooltip .= "<p>".$data['button_cart']."</p>";
		}
		if ($price&&$special) { $moneymaker2_addtocart_tooltip .= "<p>".$data['moneymaker2_text_old_price']." ".$price."</p>"; }
		$moneymaker2_addtocart_class = 'btn ';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
			$moneymaker2_addtocart_class .= 'disabled ';
		}
		if (!$special) {
			$moneymaker2_addtocart_class .= 'btn-primary';
		} else {
			$moneymaker2_addtocart_class .= 'btn-danger';
		}
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$moneymaker2_quickorder_tooltip = '';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
				$moneymaker2_quickorder_tooltip .= "<p class='text-muted'>" . $data['moneymaker2_modules_quickorder_button_title'] . "</p>";
				$moneymaker2_quickorder_tooltip .= "<p>" . $moneymaker2_stock . "</p>";
			} else {
				$moneymaker2_quickorder_tooltip .= "<p>" . $data['moneymaker2_modules_quickorder_button_title'] . "</p>";
			}
			$moneymaker2_quickorder_class = 'btn btn-default';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
				$moneymaker2_quickorder_class .= ' disabled';
			}
		}
		$data['products'][] = array(
			'stickers'              => $moneymaker2_stickers,
			'stock'                 => $this->config->get('moneymaker2_modules_featured_stock') ? $moneymaker2_stock : '',
			'code'                  => $this->config->get('moneymaker2_modules_featured_code') ? $moneymaker2_code : '',
			'sold'                  => $data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0 ? true : false,
			'quantity'              => $product_info['quantity'],
			'sort_order'            => $product_info['sort_order'],
			'review_count'          => $product_info['reviews'],
			'addtocart_tooltip'     => $moneymaker2_addtocart_tooltip,
			'addtocart_class'       => $moneymaker2_addtocart_class,
			'quickorder_tooltip'    => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_tooltip : '',
			'quickorder_class'      => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_class : '',
		/*mmr*/
		
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => $this->config->get('moneymaker2_modules_featured_description') ? utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..' : '',
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
			return $this->load->view('extension/module/featured', $data);
		}
	}
}