<?php
class ControllerProductProduct extends Controller {
	private $error = array();
	

	public function index() {

				$this->load->model('extension/module/options_image');
				
				$this->document->addScript('catalog/view/javascript/options_image/options_image.js');
				$data['options_image_setting'] = $this->model_extension_module_options_image->getOptionsImageSetting();
			
		$this->load->language('product/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
					$url .= '&page=' . $this->request->get['page'];
				}

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
				
				$data['category_name'] = $category_info['name'];
			}
		}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $product_info['name'],
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$this->document->setTitle($product_info['meta_title']);
			} else {
				$this->document->setTitle($product_info['name']);
			}
			
			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if (isset($product_info['meta_h1'])) {
				$data['heading_title'] = $product_info['meta_h1'];
			} else {
				$data['heading_title'] = $product_info['name'];
			}


		/*mmr*/
		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.moneymaker2.css');
		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/moneymaker2/bootstrap.rating.input.min.js');
		/*mmr*/
		
			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

			$data['product_id'] = (int)$this->request->get['product_id'];

				$data['date_added'] = date("c", strtotime($product_info['date_added']));
			
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

			if ($product_info['quantity'] <= 0) {
				$data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$data['stock'] = $product_info['quantity'];
			} else {
				$data['stock'] = $this->language->get('text_instock');
			}

			$this->load->model('tool/image');

			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
			} else {
				$data['thumb'] = '';
			}


				$data['videos'] = array();
				$results = $this->model_catalog_product->getProductVideos($this->request->get['product_id']);
				foreach ($results as $result) {
					$data['videos'][] = array(
						'product_video_id' => $result['product_video_id'],
						'url' => $result['url']
					);
				}
			
			$data['images'] = array();

			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			foreach ($results as $result) {
				$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
				);
			}

			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				
				if ($product_info['price'] > 0) {
				    $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
				    $data['price'] = $this->language->get('text_price_free');
			    }
			
			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['special'] = false;
			}

			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
				);
			}


          $data['raw_price'] = $data['price'];
          $data['raw_special'] = $data['special'];
        
          if ($data['price']) {
              $data['price'] = '<span class=\'autocalc-product-price\'>' . $data['price'] . '</span>';
              $data['price_base'] = $this->currency->format(($product_info['price']), $this->session->data['currency']);//SV добавил
          }
          if ($data['special']) {
              $data['special'] = '<span class=\'autocalc-product-special\'>' . $data['special'] . '</span>';
			  $data['special_base'] = $this->currency->format(($product_info['special']), $this->session->data['currency']);//SV добавил
          }
          if ($data['points']) {
              $data['points'] = '<span class=\'autocalc-product-points\'>' . $data['points'] . '</span>';
          }
          
          $data['price_value'] = $product_info['price'];
          $data['special_value'] = $product_info['special'];
          $data['tax_value'] = (float)$product_info['special'] ? $product_info['special'] : $product_info['price'];
          $data['points_value'] = $product_info['points'];
          
          $var_currency = array();
          $currency_code = !empty($this->session->data['currency']) ? $this->session->data['currency'] : $this->config->get('config_currency');
          $var_currency['value'] = $this->currency->getValue($currency_code);
          $var_currency['symbol_left'] = $this->currency->getSymbolLeft($currency_code);
          $var_currency['symbol_right'] = $this->currency->getSymbolRight($currency_code);
          $var_currency['decimals'] = $this->currency->getDecimalPlace($currency_code);
          $var_currency['decimal_point'] = $this->language->get('decimal_point');
          $var_currency['thousand_point'] = $this->language->get('thousand_point');
          $data['autocalc_currency'] = $var_currency;

          $currency2_code = $this->config->get('config_currency2');
          if ($this->currency->has($currency2_code) && $currency2_code != $currency_code) {
              $var_currency = array();
              $currency_code = $currency2_code;
              $var_currency['value'] = $this->currency->getValue($currency_code);
              $var_currency['symbol_left'] = $this->currency->getSymbolLeft($currency_code);
              $var_currency['symbol_right'] = $this->currency->getSymbolRight($currency_code);
              $var_currency['decimals'] = $this->currency->getDecimalPlace($currency_code);
              $var_currency['decimal_point'] = $this->language->get('decimal_point');
              $var_currency['thousand_point'] = $this->language->get('thousand_point');
              $data['autocalc_currency2'] = $var_currency;
          }
          
          $data['dicounts_unf'] = $discounts;

          $data['tax_class_id'] = $product_info['tax_class_id'];
          $data['tax_rates'] = $this->tax->getRates(0, $product_info['tax_class_id']);
        
          $data['autocalc_option_special'] = $this->config->get('config_autocalc_option_special');
          $data['autocalc_option_discount'] = $this->config->get('config_autocalc_option_discount');
          $data['autocalc_not_mul_qty'] = $this->config->get('config_autocalc_not_mul_qty');
          $data['autocalc_select_first'] = $this->config->get('config_autocalc_select_first');
      
			$data['options'] = array();
			
		    $summ_option = '';//SV добавил
		    
			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {

        if ($option_value['price_prefix']=="u") {
            $price = '+' . (float)$option_value['price'].'%';
        }
        elseif ($option_value['price_prefix']=="d") {
            $price = '-' . (float)$option_value['price'].'%';
        }
        elseif ($option_value['price_prefix']=="*") {
            $price = '*' . (float)$option_value['price'];
        }
        elseif ($option_value['price_prefix']=="/") {
            $price = '/' . (float)$option_value['price'];
        }
        else{
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
							/*для модиф.Options price ocStore2*/

        }
						} else {
							$price = false;
						}


           if (!empty($option_value['link'])) {
                $option_value['link'] = $this->url->link('product/product', 'product_id=' . $option_value['link']);
           }
           
						$product_option_value_data[] = array(

          'price_value'                   => (float)$option_value['price'],
          'points_value'                  => intval($option_value['points_prefix'].$option_value['points']),
      

				'product_image_popup' => $option_value['product_image'] ? $this->model_tool_image->resize($option_value['product_image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')) : '',
				'product_image_thumb' => $option_value['product_image'] ? $this->model_tool_image->resize($option_value['product_image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')) : '',
			
							'product_option_value_id' => $option_value['product_option_value_id'],

            'link' => $option_value['link'],
            'checked' => $option_value['checked'],
           
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
					if ($option['type'] == 'checkbox') {
				        $summ_option += $option_value['price'];//SV добавил
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'summ_option'          => $this->currency->format(($product_info['price']+$summ_option), $this->session->data['currency']),//SV добавил
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = (int)$product_info['rating'];

		/*mmr*/
		$data['quantity'] = $product_info['quantity'];
		$this->load->language('extension/module/moneymaker2');
		$data['text_downloads'] = $this->language->get('text_downloads');
		$data['moneymaker2_currency'] = $this->session->data['currency'];
		$data['moneymaker2_text_old_price'] = $this->language->get('text_old_price');
		$data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			if ($product_info['image']) {
				$data['quickorder_thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('moneymaker2_modules_quickorder_image_width'), $this->config->get('moneymaker2_modules_quickorder_image_height'));
			} else {
				$data['quickorder_thumb'] = '';
			}
			$data['moneymaker2_modules_quickorder_display_thumb'] = $this->config->get('moneymaker2_modules_quickorder_display_thumb');
			$data['moneymaker2_modules_quickorder_display_catalog'] = $this->config->get('moneymaker2_modules_quickorder_display_catalog');
			if ($this->config->get('moneymaker2_common_preorder')&&$this->config->get('moneymaker2_common_preorder_field')==$product_info['stock_status_id']) {
				$data['moneymaker2_modules_quickorder_button_title'] = $this->language->get('text_preorder');
				$data['moneymaker2_modules_quickorder_button_tooltip'] = $this->language->get('text_preorder_help');
			} else {
				$data['moneymaker2_modules_quickorder_button_title'] = $this->config->get('moneymaker2_modules_quickorder_button_title');
				$data['moneymaker2_modules_quickorder_button_title'] = isset($data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')] : null;
				$data['moneymaker2_modules_quickorder_button_tooltip'] = $this->config->get('moneymaker2_modules_quickorder_button_tooltip');
				$data['moneymaker2_modules_quickorder_button_tooltip'] = isset($data['moneymaker2_modules_quickorder_button_tooltip'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_quickorder_button_tooltip'][$this->config->get('config_language_id')] : null;
			}
		}
		$data['moneymaker2_product_metatitles_enabled'] = $this->config->get('moneymaker2_product_metatitles_enabled');
		if ($data['moneymaker2_product_metatitles_enabled']) {
			$data['meta_title'] = $product_info['meta_title'];
		}
		$data['moneymaker2_product_socials_addthis_enabled'] = $this->config->get('moneymaker2_product_socials_addthis_enabled');
		$data['moneymaker2_product_socials_yandex_enabled'] = $this->config->get('moneymaker2_product_socials_yandex_enabled');
		if ($this->config->get('moneymaker2_product_code')&&$this->config->get('moneymaker2_catalog_products_code_field')&&isset($product_info[$this->config->get('moneymaker2_catalog_products_code_field')])&&$product_info[$this->config->get('moneymaker2_catalog_products_code_field')]) {
			$moneymaker2_product_code_caption = $this->config->get('moneymaker2_product_code_caption');
			$data['moneymaker2_code'] = (isset($moneymaker2_product_code_caption[$this->config->get('config_language_id')]) ? $moneymaker2_product_code_caption[$this->config->get('config_language_id')] : null).$product_info[$this->config->get('moneymaker2_catalog_products_code_field')];
		} else {
			$data['moneymaker2_code'] = '';
		}
		if ($this->config->get('moneymaker2_product_attributes_code')&&$this->config->get('moneymaker2_catalog_products_code_field')&&isset($product_info[$this->config->get('moneymaker2_catalog_products_code_field')])&&$product_info[$this->config->get('moneymaker2_catalog_products_code_field')]) {
			$moneymaker2_product_code_caption = $this->config->get('moneymaker2_product_code_caption');
			$data['moneymaker2_product_code_caption'] = isset($moneymaker2_product_code_caption[$this->config->get('config_language_id')]) ? $moneymaker2_product_code_caption[$this->config->get('config_language_id')] : null;
			$data['moneymaker2_attributes_code'] = $product_info[$this->config->get('moneymaker2_catalog_products_code_field')];
		} else {
			$data['moneymaker2_attributes_code'] = '';
		}
		$data['moneymaker2_mpn'] = isset($product_info['mpn']) ? $product_info['mpn'] : null;
		$data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
		$data['moneymaker2_common_wishlist_hide'] = $this->config->get('moneymaker2_common_wishlist_hide');
		$data['moneymaker2_common_wishlist_caption'] = $this->config->get('moneymaker2_common_wishlist_caption');
		$data['moneymaker2_common_compare_hide'] = $this->config->get('moneymaker2_common_compare_hide');
		$data['moneymaker2_common_compare_caption'] = $this->config->get('moneymaker2_common_compare_caption');
		$data['moneymaker2_common_cart_outofstock_disabled'] = $this->config->get('moneymaker2_common_cart_outofstock_disabled');
		$data['moneymaker2_common_price_detached'] = $this->config->get('moneymaker2_common_price_detached');
		if ($this->config->get('moneymaker2_product_gallery_animation')) {
			$this->document->addStyle('catalog/view/theme/moneymaker2/stylesheet/mfp.effects.css');
		}
		$data['moneymaker2_product_gallery_moved'] = $this->config->get('moneymaker2_product_gallery_moved');
		$data['moneymaker2_product_gallery_round'] = $this->config->get('moneymaker2_product_gallery_round');
		$data['moneymaker2_product_gallery_animation'] = $this->config->get('moneymaker2_product_gallery_animation');
		$data['moneymaker2_product_gallery_animation_in'] = $this->config->get('moneymaker2_product_gallery_animation_in');
		$data['moneymaker2_product_thumbs_limit'] = $this->config->get('moneymaker2_product_thumbs_limit');
		$data['moneymaker2_product_points_size'] = $this->config->get('moneymaker2_product_points_size');
		if ($this->config->get('moneymaker2_product_points_stock')&&$product_info['quantity'] <= 0) {
			$data['moneymaker2_product_points_stock_id'] = $product_info['stock_status_id'];
			$data['moneymaker2_product_points_stock'] = $this->config->get('moneymaker2_product_points_stock');
			$data['moneymaker2_product_points_stock_icon'] = $this->config->get('moneymaker2_product_points_stock_icon');
			$data['moneymaker2_product_points_stock_icon'] = $data['moneymaker2_product_points_stock_icon'][$product_info['stock_status_id']];
			$data['moneymaker2_product_points_stock_caption'] = $this->config->get('moneymaker2_product_points_stock_caption');
			$data['moneymaker2_product_points_stock_caption'] = isset($data['moneymaker2_product_points_stock_caption'][$product_info['stock_status_id']][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_product_points_stock_caption'][$product_info['stock_status_id']][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		} else if ($this->config->get('moneymaker2_product_points_stock')&&$this->config->get('moneymaker2_product_points_stock_default')) {
			$data['moneymaker2_product_points_stock_id'] = $this->config->get('moneymaker2_product_points_stock_default');
			$data['moneymaker2_product_points_stock'] = $this->config->get('moneymaker2_product_points_stock');
			$data['moneymaker2_product_points_stock_icon'] = $this->config->get('moneymaker2_product_points_stock_icon');
			$data['moneymaker2_product_points_stock_icon'] = $data['moneymaker2_product_points_stock_icon'][$this->config->get('moneymaker2_product_points_stock_default')];
			$data['moneymaker2_product_points_stock_caption'] = $this->config->get('moneymaker2_product_points_stock_caption');
			$data['moneymaker2_product_points_stock_caption'] = isset($data['moneymaker2_product_points_stock_caption'][$this->config->get('moneymaker2_product_points_stock_default')][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_product_points_stock_caption'][$this->config->get('moneymaker2_product_points_stock_default')][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		} else {
			$data['moneymaker2_product_points_stock'] = '';
		}
		$data['moneymaker2_product_points_manufacturer'] = $this->config->get('moneymaker2_product_points_manufacturer');
		if ($data['moneymaker2_product_points_manufacturer']) {
			$data['moneymaker2_manufacturer_image'] = $product_info['manufacturer_image'] ? $this->model_tool_image->resize($product_info['manufacturer_image'], $this->config->get('moneymaker2_product_points_manufacturer_image_width'), $this->config->get('moneymaker2_product_points_manufacturer_image_height')) : $this->model_tool_image->resize('no_image.png', $this->config->get('moneymaker2_product_points_manufacturer_image_width'), $this->config->get('moneymaker2_product_points_manufacturer_image_height'));
			$data['moneymaker2_product_points_manufacturer_caption'] = $this->config->get('moneymaker2_product_points_manufacturer_caption');
			$data['moneymaker2_product_points_manufacturer_caption'] = isset($data['moneymaker2_product_points_manufacturer_caption'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_points_manufacturer_caption'][$this->config->get('config_language_id')] : null;
		}
		$data['moneymaker2_product_points'] = array();
		$moneymaker2_product_points = $this->config->get('moneymaker2_product_points');
		if (!empty($moneymaker2_product_points)) {
			$moneymaker2_product_category = $this->model_catalog_product->getCategories($product_info['product_id']);
			if (isset($moneymaker2_product_category)) {
				$moneymaker2_product_category_ids = array();
				foreach ($moneymaker2_product_category as $key => $value) {
					$moneymaker2_product_category_ids[] =  $value['category_id'];
				}
			}
			$used_keys = array();
			if ($moneymaker2_product_category_ids) {
				foreach ($moneymaker2_product_category_ids as $moneymaker2_product_category_id) {
					if ($moneymaker2_product_category_id) {
						foreach ($moneymaker2_product_points as $key => $value) {
							if (isset($value['categories'])&&in_array($moneymaker2_product_category_id, $value['categories'])&&(!in_array($key, $used_keys))) {
								$data['moneymaker2_product_points'][] = array(
									'icon'          => $value['icon'],
									'categories'    => isset($value['categories']) ? $value['categories'] : array(0),
									'name'          => isset($value['name'][$this->config->get('config_language_id')]) ? $value['name'][$this->config->get('config_language_id')] : null,
									'text'          => isset($value['text'][$this->config->get('config_language_id')]) ? html_entity_decode($value['text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null,
								);
								$moneymaker2_product_points_sort_order[$key] = $value['sort_order'];
								$used_keys[] = $key;
							}
						}
					}
				}
				if (isset($moneymaker2_product_points_sort_order)) {
					array_multisort($moneymaker2_product_points_sort_order, SORT_ASC, $data['moneymaker2_product_points']);
				}
			}
		}
		$data['button_reviews'] = $this->language->get('button_reviews');
		$data['button_submit'] = $this->language->get('button_submit');
		$data['button_shopping'] = $this->language->get('button_shopping');
		$data['moneymaker2_stickers_mode'] = $this->config->get('moneymaker2_modules_stickers_mode');
		$data['moneymaker2_stickers_size_product'] = $this->config->get('moneymaker2_modules_stickers_size_product');
		$moneymaker2_stickers = array();
		if ($product_info['special']) {
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
		$data['stickers'] = $moneymaker2_stickers;
		$moneymaker2_addtocart_tooltip = '';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
			if (!$data['moneymaker2_common_price_detached']) { $moneymaker2_addtocart_tooltip = "<p class='text-muted'>" . $data['button_cart'] . "</p>"; }
			$moneymaker2_addtocart_tooltip .= "<p>".$data['stock']."</p>";
		} else if (!$data['moneymaker2_common_price_detached']) {
			$moneymaker2_addtocart_tooltip .= "<p>".$data['button_cart']."</p>";
		}
		if ($product_info['price']&&$product_info['special']) { $moneymaker2_addtocart_tooltip .= "<p>".$data['moneymaker2_text_old_price']." ".$this->currency->format($product_info['price'], $this->session->data['currency'])."</p>"; }
		$moneymaker2_addtocart_class = 'btn ';
		if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
			$moneymaker2_addtocart_class .= 'disabled ';
		}
		if (!$product_info['special']) {
			$moneymaker2_addtocart_class .= 'btn-primary';
			$data['moneymaker2_modules_timer'] = null;
		} else {
			$moneymaker2_addtocart_class .= 'btn-danger';
			$data['moneymaker2_modules_timer'] = $this->config->get('moneymaker2_modules_timer');
			if ($data['moneymaker2_modules_timer']) {
				$data['text_timer_discount'] = $this->language->get('text_timer_discount');
				$data['text_timer_ends_numeral1'] = $this->language->get('text_timer_ends_numeral1');
				$data['text_timer_ends_numeral2'] = $this->language->get('text_timer_ends_numeral2');
				$data['text_timer_ends_numeral3'] = $this->language->get('text_timer_ends_numeral3');
				$data['text_timer_days_numeral1'] = $this->language->get('text_timer_days_numeral1');
				$data['text_timer_days_numeral2'] = $this->language->get('text_timer_days_numeral2');
				$data['text_timer_days_numeral3'] = $this->language->get('text_timer_days_numeral3');
				$data['text_timer_limit'] = $this->language->get('text_timer_limit');
				if ($this->customer->isLogged()){
					$customer_group_id = (int)$this->config->get('config_customer_group_id');
				} else {
					$customer_group_id = 0;
				}
				$sql = "SELECT date_end FROM " . DB_PREFIX . "product_special WHERE product_id ='" . $product_id . "' AND date_start <= NOW() AND date_end >= NOW() ";
				if ($customer_group_id){ $sql .= " AND customer_group_id ='" . $customer_group_id . "'"; }
				$sql .= " ORDER BY priority LIMIT 0,1";
				$query = $this->db->query($sql);
				if ($query->num_rows){ $date_end = $query->row['date_end']; } else { $date_end = 0; }
				if ($date_end){
					$moneymaker2_modules_timer_date = date_create($date_end);
					$data['moneymaker2_modules_timer_date'] = date_format($moneymaker2_modules_timer_date, 'Y/m/d');
				} else {
					$data['moneymaker2_modules_timer_date'] = $date_end;
				};
				$data['moneymaker2_modules_timer_discount'] = $this->config->get('moneymaker2_modules_timer_discount') ? ($this->config->get('moneymaker2_modules_timer_discount_mode') ? round(100-(($product_info['special']/$product_info['price'])*100))."%" : $this->currency->format((($product_info['special'])-($product_info['price']))*(-1), $this->session->data['currency'])) : null;
			}
		}
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$moneymaker2_quickorder_tooltip = '';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
				$moneymaker2_quickorder_tooltip .= "<p class='text-muted'>" . $data['moneymaker2_modules_quickorder_button_tooltip'] . "</p>";
				$moneymaker2_quickorder_tooltip .= "<p>" . $data['stock'] . "</p>";
			} else {
				$moneymaker2_quickorder_tooltip .= "<p>" . $data['moneymaker2_modules_quickorder_button_tooltip'] . "</p>";
			}
			$moneymaker2_quickorder_class = 'btn btn-link';
			if ($data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0) {
				$moneymaker2_quickorder_class .= ' disabled';
			}
		}
		$data['product_sold'] = $data['moneymaker2_common_cart_outofstock_disabled']&&$product_info['quantity'] <= 0 ? true : false;
		$data['addtocart_tooltip'] = $moneymaker2_addtocart_tooltip;
		$data['addtocart_class'] = $moneymaker2_addtocart_class;
		$data['quickorder_tooltip'] = $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_tooltip : '';
		$data['quickorder_class'] = $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_class : '';
		$data['moneymaker2_product_price'] = $data['price'];
		$data['moneymaker2_product_special'] = $data['special'];
		$data['moneymaker2_product_options_hide'] = $this->config->get('moneymaker2_product_options_hide');
		$data['moneymaker2_product_options_hide_limit'] = $this->config->get('moneymaker2_product_options_hide_limit');
		$data['moneymaker2_product_tabs_hide'] = $this->config->get('moneymaker2_product_tabs_hide');
		$data['moneymaker2_product_tabs_headers'] = $this->config->get('moneymaker2_product_tabs_headers');
		if ($data['moneymaker2_product_tabs_headers']) {
			$data['moneymaker2_product_tabs_headers_text'] = $this->config->get('moneymaker2_product_tabs_headers_text');
			if ($data['moneymaker2_product_tabs_headers']==1) {
				$data['moneymaker2_product_description_header'] = $data['tab_description']." ".$data['heading_title'];
				$data['moneymaker2_product_attribute_header'] = $data['tab_attribute']." ".$data['heading_title'];
				$data['moneymaker2_product_review_header'] = $data['button_reviews']." ".$data['heading_title'];
			} else if ($data['moneymaker2_product_tabs_headers']==2) {
				$data['moneymaker2_product_description_header'] = $data['heading_title']." ".$data['tab_description'];
				$data['moneymaker2_product_attribute_header'] = $data['heading_title']." ".$data['tab_attribute'];
				$data['moneymaker2_product_review_header'] = $data['heading_title']." ".$data['button_reviews'];
			} else if ($data['moneymaker2_product_tabs_headers']==3) {
				$data['moneymaker2_product_description_header'] = $data['tab_description']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['heading_title'];
				$data['moneymaker2_product_attribute_header'] = $data['tab_attribute']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['heading_title'];
				$data['moneymaker2_product_review_header'] = $data['button_reviews']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['heading_title'];
			} else if ($data['moneymaker2_product_tabs_headers']==4) {
				$data['moneymaker2_product_description_header'] = $data['heading_title']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['tab_description'];
				$data['moneymaker2_product_attribute_header'] = $data['heading_title']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['tab_attribute'];
				$data['moneymaker2_product_review_header'] = $data['heading_title']." ".(isset($data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_product_tabs_headers_text'][$this->config->get('config_language_id')] : null)." ".$data['button_reviews'];
			} else if ($data['moneymaker2_product_tabs_headers']==5) {
				$data['moneymaker2_product_description_header'] = $data['moneymaker2_product_attribute_header'] = $data['moneymaker2_product_review_header'] = $data['heading_title'];
			}
		}
		$data['moneymaker2_product_tabs_description_buttons'] = $this->config->get('moneymaker2_product_tabs_description_buttons');
		$data['moneymaker2_product_tabs_attributes_buttons'] = $this->config->get('moneymaker2_product_tabs_attributes_buttons');
		$data['moneymaker2_product_tabs_attributes_responsive'] = $this->config->get('moneymaker2_product_tabs_attributes_responsive');
		$data['weight'] = $this->config->get('moneymaker2_product_tabs_attributes_weight') && $product_info['weight'] > 0 ? $this->weight->format($product_info['weight'], $product_info['weight_class_id']) : '';
		$data['length'] = $this->config->get('moneymaker2_product_tabs_attributes_dimensions') && $product_info['length'] > 0 ? $this->length->format($product_info['length'], $product_info['length_class_id']) : '';
		$data['width'] = $this->config->get('moneymaker2_product_tabs_attributes_dimensions') && $product_info['width'] > 0 ? $this->length->format($product_info['width'], $product_info['length_class_id']) : '';
		$data['height'] = $this->config->get('moneymaker2_product_tabs_attributes_dimensions') && $product_info['height'] > 0 ? $this->length->format($product_info['height'], $product_info['length_class_id']) : '';
		if ($data['weight']||$data['length']||$data['width']||$data['height']||$data['moneymaker2_attributes_code']) {
			$this->load->language('product/compare');
			$data['text_weight'] = $this->language->get('text_weight');
			$data['text_dimension'] = $this->language->get('text_dimension');
			$data['text_product'] = $this->language->get('text_product');
		}
		$data['moneymaker2_product_tabs_reviews_indexed'] = $this->config->get('moneymaker2_product_tabs_reviews_indexed');
		if ($data['moneymaker2_product_tabs_reviews_indexed']) {
			$this->load->model('catalog/review');
			$data['text_no_reviews'] = $this->language->get('text_no_reviews');
			
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}
			$data['reviews'] = array();
			$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);
			$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);
			foreach ($results as $result) {
				$data['reviews'][] = array(
					'author'     => $result['author'],
					'text'       => nl2br($result['text']),
					'rating'     => (int)$result['rating'],
					'date_added' => date('Y-m-d', strtotime($result['date_added']))
				);
			}
			$pagination = new Pagination();
			$pagination->total = $review_total;
			$pagination->page = $page;
			$pagination->limit = 5;
			$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');
			$data['pagination'] = $pagination->render();
		}
		$data['moneymaker2_product_tabs'] = array();
		$moneymaker2_product_tabs = $this->config->get('moneymaker2_product_tabs');
		if (!empty($moneymaker2_product_tabs)){
			$this->load->model('catalog/information');
			if (isset ($this->request->get['path'])) {
				$moneymaker2_product_categories = explode('_', $this->request->get['path']);
				$moneymaker2_product_category_id = $moneymaker2_product_categories[count($moneymaker2_product_categories) - 1];
			} else {
				$moneymaker2_product_category = $this->model_catalog_product->getCategories($product_info['product_id']);
				$moneymaker2_product_category_id = isset($moneymaker2_product_category[0]['category_id']) ? $moneymaker2_product_category[0]['category_id'] : 0;
			}
			if ($moneymaker2_product_category_id){
				foreach ($moneymaker2_product_tabs as $key => $value) {
					$information_info = $this->model_catalog_information->getInformation($value['link']);
					if (isset($value['categories'])&&in_array($moneymaker2_product_category_id, $value['categories'])) {
					$data['moneymaker2_product_tabs'][] = array(
						'icon'    => isset($value['icon']) ? $value['icon'] : '',
						'categories'    => isset($value['categories']) ? $value['categories'] : array(0),
						'name'          => (isset($value['name'][$this->config->get('config_language_id')])&&$value['name'][$this->config->get('config_language_id')]) ? $value['name'][$this->config->get('config_language_id')] : (isset($information_info['title']) ? $information_info['title'] : ''),
						'link'          => $value['link'],
					);
					$moneymaker2_product_tabs_sort_order[$key] = $value['sort_order'];
					}
				}
				if (isset($moneymaker2_product_tabs_sort_order)) {
					array_multisort($moneymaker2_product_tabs_sort_order, SORT_ASC, $data['moneymaker2_product_tabs']);
				}
			}
		}
		/*mmr*/
		

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

			$data['products'] = array();

			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					
				if ($result['price'] > 0) {
				    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
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
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				
		/*mmr*/
		$data['moneymaker2_product_related_carousel'] = $this->config->get('moneymaker2_product_related_carousel');
		$data['moneymaker2_product_related_carousel_autoplay'] = $this->config->get('moneymaker2_product_related_carousel_autoplay');
		$data['moneymaker2_stickers_size_catalog'] = $this->config->get('moneymaker2_modules_stickers_size_catalog');
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
		if ($this->config->get('moneymaker2_catalog_products_code_field')&&isset($result[$this->config->get('moneymaker2_catalog_products_code_field')])&&$result[$this->config->get('moneymaker2_catalog_products_code_field')]&&$this->config->get('moneymaker2_product_related_code')) {$moneymaker2_code = "<span class='code'>".$this->language->get('text_model')." <span>".$result[$this->config->get('moneymaker2_catalog_products_code_field')]."</span></span>";} else {$moneymaker2_code = '';}
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
			'stock'                 => $this->config->get('moneymaker2_product_related_stock') ? $moneymaker2_stock : '',
			'code'                  => $this->config->get('moneymaker2_product_related_code') ? $moneymaker2_code : '',
			'sold'                  => $data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0 ? true : false,
			'quantity'              => $result['quantity'],
			'sort_order'            => $result['sort_order'],
			'addtocart_tooltip'     => $moneymaker2_addtocart_tooltip,
			'addtocart_class'       => $moneymaker2_addtocart_class,
			'quickorder_tooltip'    => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_tooltip : '',
			'quickorder_class'      => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_class : '',
		/*mmr*/
		
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => $this->config->get('moneymaker2_product_related_description') ? utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..' : '',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}


        if (!empty($this->session->data['last_viewed'])) {
          $i = 1;
          foreach ($this->session->data['last_viewed'] as $product) {
            if ($i == 1) {$this->session->data['last_viewed'] = array();$this->session->data['last_viewed'][0] = $this->request->get['product_id'];}
            if ($product != $this->request->get['product_id']) {
              $this->session->data['last_viewed'][$i] = $product;
              $i++;
            }
          }
        } else {
          $this->session->data['last_viewed'][] = $this->request->get['product_id'];
        }
      
			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}

			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);


						//microdatapro 7.0 start - 1 - main
						$data['microdatapro_data'] = $product_info;
						$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
						$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
						$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/product', $data);
						$microdatapro_main_flag = 1;
						//microdatapro 7.0 end - 1 - main
					
			$this->model_catalog_product->updateViewed($this->request->get['product_id']);


						//microdatapro 7.0 start - 2 - extra
						if(!isset($microdatapro_main_flag)){
							if(isset($product_info) && $product_info){
								$data['microdatapro_data'] = $product_info;
								$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
								$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
								$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/product', $data);
								$microdatapro_main_flag = 1;
							}
						}
						//microdatapro 7.0 end - 2 - extra
					
			//product variant
            $data['variantproducts'] = $this->model_catalog_product->getProductVariantproducts($this->request->get['product_id']);

            foreach ($data['variantproducts'] as $k => $variantproduct) {
                if ($variantproduct['products']) {
                    foreach ($variantproduct['products'] as $j => $product) {
                        if ($product['image']) {
                            $image = $this->model_tool_image->resize($product['image'], 60, 60);
                        } else {
                            $image = false;
                        }


                        $product['image'] = $image;
                     
						$product['href'] = $this->url->link('product/product', 'product_id=' . $product['product_id']);						
                        $data['variantproducts'][$k]['products'][$j] = $product;
                    }
                }
            }
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/variants.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/variants.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/variants.css');
		}		
    //product variant
          $data['column_left'] = $this->load->controller('common/column_left');	
		
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

/* Tabs by Artem Pitov */
				$data['add_tabs'] = $this->model_catalog_product->getAddTabs($this->request->get['product_id']);
				/* Tabs by Artem Pitov */
			$this->response->setOutput($this->load->view('product/product', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');


						//microdatapro 7.0 start - 2 - extra
						if(!isset($microdatapro_main_flag)){
							if(isset($product_info) && $product_info){
								$data['microdatapro_data'] = $product_info;
								$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
								$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
								$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/product', $data);
								$microdatapro_main_flag = 1;
							}
						}
						//microdatapro 7.0 end - 2 - extra
					
			//product variant
            $data['variantproducts'] = $this->model_catalog_product->getProductVariantproducts($this->request->get['product_id']);

            foreach ($data['variantproducts'] as $k => $variantproduct) {
                if ($variantproduct['products']) {
                    foreach ($variantproduct['products'] as $j => $product) {
                        if ($product['image']) {
                            $image = $this->model_tool_image->resize($product['image'], 60, 60);
                        } else {
                            $image = false;
                        }


                        $product['image'] = $image;
                     
						$product['href'] = $this->url->link('product/product', 'product_id=' . $product['product_id']);						
                        $data['variantproducts'][$k]['products'][$j] = $product;
                    }
                }
            }
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/variants.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/variants.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/variants.css');
		}		
    //product variant
          $data['column_left'] = $this->load->controller('common/column_left');	
		
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function review() {
		$this->load->language('product/product');

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		$this->response->setOutput($this->load->view('product/review', $data));
	}

	public function write() {
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {
		$this->load->language('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}