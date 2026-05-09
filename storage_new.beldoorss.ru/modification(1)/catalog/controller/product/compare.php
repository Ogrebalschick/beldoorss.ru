<?php
class ControllerProductCompare extends Controller {
	public function index() {
		$this->load->language('product/compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}

		if (isset($this->request->get['remove'])) {
			$key = array_search($this->request->get['remove'], $this->session->data['compare']);

			if ($key !== false) {
				unset($this->session->data['compare'][$key]);

				$this->session->data['success'] = $this->language->get('text_remove');
			}

			$this->response->redirect($this->url->link('product/compare'));
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/compare')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_product'] = $this->language->get('text_product');
		$data['text_name'] = $this->language->get('text_name');
		$data['text_image'] = $this->language->get('text_image');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_availability'] = $this->language->get('text_availability');
		$data['text_rating'] = $this->language->get('text_rating');
		$data['text_summary'] = $this->language->get('text_summary');
		$data['text_weight'] = $this->language->get('text_weight');
		$data['text_dimension'] = $this->language->get('text_dimension');
		$data['text_empty'] = $this->language->get('text_empty');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_remove'] = $this->language->get('button_remove');

		/*mmr*/
		if ($this->config->get('moneymaker2_catalog_compare_charts_enabled')) {
			$this->document->addScript('catalog/view/javascript/jquery/moneymaker2/chart.min.js');
		}
		$data['button_back'] = $this->language->get('button_back');
		$data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
		$data['moneymaker2_common_cart_outofstock_disabled'] = $this->config->get('moneymaker2_common_cart_outofstock_disabled');
		$data['moneymaker2_common_price_detached'] = $this->config->get('moneymaker2_common_price_detached');
		$data['moneymaker2_catalog_compare_images_hide'] = $this->config->get('moneymaker2_catalog_compare_images_hide');
		$data['moneymaker2_catalog_compare_model_hide'] = $this->config->get('moneymaker2_catalog_compare_model_hide');
		$data['moneymaker2_catalog_compare_brand_hide'] = $this->config->get('moneymaker2_catalog_compare_brand_hide');
		$data['moneymaker2_catalog_compare_availability_hide'] = $this->config->get('moneymaker2_catalog_compare_availability_hide');
		$data['moneymaker2_catalog_compare_rating_hide'] = $this->config->get('moneymaker2_catalog_compare_rating_hide');
		$data['moneymaker2_catalog_compare_description_hide'] = $this->config->get('moneymaker2_catalog_compare_description_hide');
		$data['moneymaker2_catalog_compare_weight_hide'] = $this->config->get('moneymaker2_catalog_compare_weight_hide');
		$data['moneymaker2_catalog_compare_dimensions_hide'] = $this->config->get('moneymaker2_catalog_compare_dimensions_hide');
		$moneymaker2_catalog_compare_empty_charts = array();
		/*mmr*/
		

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['review_status'] = $this->config->get('config_review_status');

		$data['products'] = array();

		$data['attribute_groups'] = array();

		foreach ($this->session->data['compare'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_compare_width'), $this->config->get($this->config->get('config_theme') . '_image_compare_height'));
				} else {
					$image = false;
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

				if ($product_info['quantity'] <= 0) {
					$availability = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$availability = $product_info['quantity'];
				} else {
					$availability = $this->language->get('text_instock');
				}

				$attribute_data = array();

				$attribute_groups = $this->model_catalog_product->getProductAttributes($product_id);

				foreach ($attribute_groups as $attribute_group) {
					foreach ($attribute_group['attribute'] as $attribute) {
						$attribute_data[$attribute['attribute_id']] = $attribute['text'];
					}
				}

				
				/*mmr*/
				$data['moneymaker2_catalog_compare_charts_enabled'] = $this->config->get('moneymaker2_catalog_compare_charts_enabled');
				if ($data['moneymaker2_catalog_compare_charts_enabled']) {
					$data['moneymaker2_catalog_compare_charts_columns'] = $this->config->get('moneymaker2_catalog_compare_charts_columns');
					$moneymaker2_catalog_compare_charts = $this->config->get('moneymaker2_catalog_compare_charts');
					if ($this->config->get('moneymaker2_catalog_compare_charts_price_enabled')) {
						$data['moneymaker2_compare_dataset']['price']['title'] = $data['text_price'];
						$data['moneymaker2_compare_dataset']['price']['unit'] = $this->currency->getSymbolLeft($this->session->data['currency']) ? $this->currency->getSymbolLeft($this->session->data['currency']) : $this->currency->getSymbolRight($this->session->data['currency']);
						$data['moneymaker2_compare_dataset']['price']['values'][] = trim(preg_replace('/[^0-9.]/', '', $special ? $special : $price), '.');
						$data['moneymaker2_compare_dataset']['price']['mode'] = 'Bar';
						$data['moneymaker2_compare_dataset']['price']['fns'] = 1;
					}
					$moneymaker2_product_attributes_ids = array();
					foreach ($attribute_data as $key => $value) {
						$moneymaker2_product_attributes_ids[] = $key;
					}
					if ($moneymaker2_catalog_compare_charts) {
						if ($this->config->get('moneymaker2_catalog_compare_charts_decimal_delimiter')) { $moneymaker2_catalog_compare_charts_decimal_delimiter = ","; } else $moneymaker2_catalog_compare_charts_decimal_delimiter = ".";
						foreach ($moneymaker2_catalog_compare_charts as $moneymaker2_catalog_compare_chart) {
							/* if !emty attr */
							if (!isset($moneymaker2_compare_error) || !$moneymaker2_compare_error) {
								if (in_array($moneymaker2_catalog_compare_chart['attribute'], $moneymaker2_product_attributes_ids)) $moneymaker2_compare_error = (!isset($moneymaker2_compare_error) || !$moneymaker2_compare_error) ? false : true; else $moneymaker2_compare_error = true;
								if ($moneymaker2_compare_error) { $moneymaker2_compare_error = false; $moneymaker2_catalog_compare_empty_charts[] = $moneymaker2_catalog_compare_chart['attribute']; }
							}
							if (!$moneymaker2_compare_error) {
								foreach ($attribute_data as $key => $value) {
									if (($key == $moneymaker2_catalog_compare_chart['attribute'])&&(!in_array($key,$moneymaker2_catalog_compare_empty_charts))) {
										/* if !empty value */
										if (!$moneymaker2_compare_error) {
											if ($value && !empty($value)) {
												$moneymaker2_compare_error = (!isset($moneymaker2_compare_error) || !$moneymaker2_compare_error) ? false : true;
											} else $moneymaker2_compare_error = true;
										}
										/* if !numeric */
										if (!$moneymaker2_compare_error) {
											if (is_numeric(trim(preg_replace('/[^0-9.]/', '', $value), '.'))) $moneymaker2_compare_error = (!isset($moneymaker2_compare_error) || !$moneymaker2_compare_error) ? false : true; else $moneymaker2_compare_error = true;
										}
										/* if !explodable */
										if ($moneymaker2_catalog_compare_chart['fns'] > 1 && !$moneymaker2_compare_error) {
											if ($moneymaker2_catalog_compare_chart['delimiter'] && ((count(explode($moneymaker2_catalog_compare_chart['delimiter'], $value))) == $moneymaker2_catalog_compare_chart['fns'])) $moneymaker2_compare_error = (!isset($moneymaker2_compare_error) || !$moneymaker2_compare_error) ? false : true; else $moneymaker2_compare_error = true;
										}
										if (!$moneymaker2_compare_error) {
											foreach ($attribute_groups as $attribute_group) {
												foreach ($attribute_group['attribute'] as $attribute) {
													if ($attribute['attribute_id'] == $key) {
														$data['moneymaker2_compare_dataset'][$key]['title'] = $attribute['name'];
														$data['moneymaker2_compare_dataset'][$key]['unit'] = isset($moneymaker2_catalog_compare_chart['unit'][$this->config->get('config_language_id')]) ? $moneymaker2_catalog_compare_chart['unit'][$this->config->get('config_language_id')] : null;
													}
												}
											}
											if ($moneymaker2_catalog_compare_chart['fns'] > 1) {
												$data['moneymaker2_compare_dataset'][$key]['values'][] = explode($moneymaker2_catalog_compare_chart['delimiter'], $value);
												foreach ($data['moneymaker2_compare_dataset'][$key]['values'] as $key2 => $value2) {
													foreach ($value2 as $key3 => $value3) {
														$data['moneymaker2_compare_dataset'][$key]['values'][$key2][$key3] = trim(preg_replace('/[^0-9' . $moneymaker2_catalog_compare_charts_decimal_delimiter . ']/', '', $value3), '.');
													}
												}
											} else $data['moneymaker2_compare_dataset'][$key]['values'][] = trim(preg_replace('/[^0-9' . $moneymaker2_catalog_compare_charts_decimal_delimiter . ']/', '', $value), '.');
											$data['moneymaker2_compare_dataset'][$key]['mode'] = $moneymaker2_catalog_compare_chart['mode'] ? 'Bar' : 'Line';
											$data['moneymaker2_compare_dataset'][$key]['fns'] = $moneymaker2_catalog_compare_chart['fns'];
										}
									}
								}
							}
						}
						foreach ($moneymaker2_catalog_compare_empty_charts as $value) {
							unset($data['moneymaker2_compare_dataset'][$value]);
						}
						if (!isset($data['moneymaker2_compare_dataset'])) $moneymaker2_compare_error = true;
					}
					if (isset($moneymaker2_compare_error)&&$moneymaker2_compare_error) $data['moneymaker2_compare_dataset'] = false;
					$data['moneymaker2_compare_datasetcolors'] = array('151,187,205', '156,216,182', '205,208,236', '199,221,232', '210,210,210');
				}
				if ($this->config->get('moneymaker2_catalog_compare_charts_code')&&$this->config->get('moneymaker2_catalog_compare_charts_code_field')&&isset($product_info[$this->config->get('moneymaker2_catalog_compare_charts_code_field')])&&$product_info[$this->config->get('moneymaker2_catalog_compare_charts_code_field')]) {
					$moneymaker2_catalog_compare_charts_code_caption = $this->config->get('moneymaker2_catalog_compare_charts_code_caption');
					$moneymaker2_code = (isset($moneymaker2_catalog_compare_charts_code_caption[$this->config->get('config_language_id')]) ? $moneymaker2_catalog_compare_charts_code_caption[$this->config->get('config_language_id')] : null).$product_info[$this->config->get('moneymaker2_catalog_compare_charts_code_field')];
				} else {
					$moneymaker2_code = '';
				}
		$data['products'][$product_id] = array(
			'product_id'    => $product_info['product_id'],
			'code'          => $moneymaker2_code,
			'quantity'      => $product_info['quantity'],
			/*mmr*/
		
					'product_id'   => $product_info['product_id'],
					'name'         => $product_info['name'],
					'thumb'        => $image,
					'price'        => $price,
					'special'      => $special,
					'description'  => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
					'model'        => $product_info['model'],
					'manufacturer' => $product_info['manufacturer'],
					'availability' => $availability,
					'minimum'      => $product_info['minimum'] > 0 ? $product_info['minimum'] : 1,
					'rating'       => (int)$product_info['rating'],
					'reviews'      => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'weight'       => $this->weight->format($product_info['weight'], $product_info['weight_class_id']),
					'length'       => $this->length->format($product_info['length'], $product_info['length_class_id']),
					'width'        => $this->length->format($product_info['width'], $product_info['length_class_id']),
					'height'       => $this->length->format($product_info['height'], $product_info['length_class_id']),
					'attribute'    => $attribute_data,
					'href'         => $this->url->link('product/product', 'product_id=' . $product_id),
					'remove'       => $this->url->link('product/compare', 'remove=' . $product_id)
				);

				foreach ($attribute_groups as $attribute_group) {
					$data['attribute_groups'][$attribute_group['attribute_group_id']]['name'] = $attribute_group['name'];

					foreach ($attribute_group['attribute'] as $attribute) {
						$data['attribute_groups'][$attribute_group['attribute_group_id']]['attribute'][$attribute['attribute_id']]['name'] = $attribute['name'];
					}
				}
			} else {
				unset($this->session->data['compare'][$key]);
			}
		}

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('product/compare', $data));
	}

	public function add() {
		$this->load->language('product/compare');

		$json = array();

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (!in_array($this->request->post['product_id'], $this->session->data['compare'])) {
				if (count($this->session->data['compare']) >= 4) {
					array_shift($this->session->data['compare']);
				}

				$this->session->data['compare'][] = $this->request->post['product_id'];
			}

			$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('product/compare'));

			$json['total'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
