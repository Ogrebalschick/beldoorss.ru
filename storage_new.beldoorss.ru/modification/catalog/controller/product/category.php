<?php
class ControllerProductCategory extends Controller
{
	public function index()
	{
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		
		if (isset($this->request->get['page']) && $this->request->get['page'] > 0) {
      
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}


		// OCFilter start
    if (isset($this->request->get['filter_ocfilter'])) {
      $filter_ocfilter = $this->request->get['filter_ocfilter'];
    } else {
      $filter_ocfilter = '';
    }
		// OCFilter end
      
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($parts);

			if ($category_id == 110) { // 110 - ID подкатегории "Специальные межкомнатные двери"
				$this->response->setOutput($this->load->controller('product/category_specialnye_mezhkomnatnye_dveri'));
				return;
			} else if ($category_id == 111) { // 111 - ID подкатегории "Межкомнатные перегородки"
				$this->response->setOutput($this->load->controller('product/category_mezhkomnatnye_peregorodki'));
				return;
			} else if ($category_id == 112) { // 112 - ID подкатегории "Декор. Стеновые панели"
				$this->response->setOutput($this->load->controller('product/category_dekor_stenovye_paneli'));
				return;
			}
		}
		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			$data['heading_title'] = $category_info['name'];

		/*mmr*/
		if ($this->config->get('moneymaker2_catalog_categories_metatitles_enabled')) {
			$data['heading_title'] = $category_info['meta_title'];
		}
		/*mmr*/
		

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

		/*mmr*/
		$this->load->model('catalog/information');
		$this->load->language('product/product');
		$this->load->language('extension/module/moneymaker2');
		$data['moneymaker2_currency'] = $this->session->data['currency'];
		$data['moneymaker2_text_old_price'] = $this->language->get('text_old_price');
		$data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$data['moneymaker2_modules_quickorder_display_catalog'] = $this->config->get('moneymaker2_modules_quickorder_display_catalog');
			$data['moneymaker2_modules_quickorder_button_title'] = $this->config->get('moneymaker2_modules_quickorder_button_title');
			$data['moneymaker2_modules_quickorder_button_title'] = isset($data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')] : null;
		}
		$data['moneymaker2_catalog_categories_hidechilds'] = $this->config->get('moneymaker2_catalog_categories_hidechilds');
		$data['moneymaker2_catalog_categories_images_hide'] = $this->config->get('moneymaker2_catalog_categories_images_hide');
		$data['moneymaker2_catalog_categories_move_description'] = $this->config->get('moneymaker2_catalog_categories_move_description');
		$data['moneymaker2_common_categories_icons_enabled'] = $this->config->get('moneymaker2_common_categories_icons_enabled');
		$data['moneymaker2_common_categories_icons'] = $this->config->get('moneymaker2_common_categories_icons');
		$data['moneymaker2_catalog_default_view'] = $this->config->get('moneymaker2_catalog_layout_default');
		$data['moneymaker2_catalog_layout_switcher_hide'] = $this->config->get('moneymaker2_catalog_layout_switcher_hide');
		$data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
		$data['moneymaker2_common_wishlist_hide'] = $this->config->get('moneymaker2_common_wishlist_hide');
		$data['moneymaker2_common_wishlist_caption'] = $this->config->get('moneymaker2_common_wishlist_caption');
		$data['moneymaker2_common_compare_hide'] = $this->config->get('moneymaker2_common_compare_hide');
		$data['moneymaker2_common_compare_caption'] = $this->config->get('moneymaker2_common_compare_caption');
		$data['moneymaker2_common_cart_outofstock_disabled'] = $this->config->get('moneymaker2_common_cart_outofstock_disabled');
		$data['moneymaker2_common_price_detached'] = $this->config->get('moneymaker2_common_price_detached');
		$data['moneymaker2_stickers_mode'] = $this->config->get('moneymaker2_modules_stickers_mode');
		$data['moneymaker2_stickers_size_catalog'] = $this->config->get('moneymaker2_modules_stickers_size_catalog');
		$data['moneymaker2_modules_promo_style'] = $this->config->get('moneymaker2_modules_promo_style');
		$data['moneymaker2_modules_promo_text_style'] = str_replace("danger", "special", $data['moneymaker2_modules_promo_style']);
		$data['moneymaker2_modules_promo_enabled'] = $this->config->get('moneymaker2_modules_promo_enabled');
		$data['moneymaker2_modules_stickers_promo_enabled'] = $this->config->get('moneymaker2_modules_stickers_promo_enabled');
		if ($data['moneymaker2_modules_promo_enabled']) {
			$data['moneymaker2_modules_promos'] = array();
			$moneymaker2_modules_promos = $this->config->get('moneymaker2_modules_promos');
			if (!empty($moneymaker2_modules_promos)){
				foreach ($moneymaker2_modules_promos as $key => $value) {
					$information_info = $this->model_catalog_information->getInformation($value['link']);
					if (isset($value['categories'])&&in_array($category_info['category_id'], $value['categories'])) {
						$data['moneymaker2_modules_promos'][] = array(
							'sort_order'    => $value['sort_order'],
							'text'          => isset($value['text'][$this->config->get('config_language_id')]) ? $value['text'][$this->config->get('config_language_id')] : null,
							'title'         => isset($value['title'][$this->config->get('config_language_id')]) ? $value['title'][$this->config->get('config_language_id')] : null,
							'link'          => $value['link'],
							'description'   => isset($value['description'][$this->config->get('config_language_id')]) ? utf8_substr(strip_tags(html_entity_decode($value['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..' : null,
							'info_title'    => isset($information_info['title']) ? $information_info['title'] : '',
							'image'         => is_file(DIR_IMAGE . $value['image']) ? $this->model_tool_image->resize($value['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize('no_image.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'))
						);
						$moneymaker2_modules_promos_sort_order[$key] = $value['sort_order'];
					}
				}
				if (isset($moneymaker2_modules_promos_sort_order)) {
					array_multisort($moneymaker2_modules_promos_sort_order, SORT_ASC, $data['moneymaker2_modules_promos']);
				}
			}
				if ($data['moneymaker2_modules_stickers_promo_enabled']) {
					$data['moneymaker2_modules_stickers_promo_caption'] = $this->config->get('moneymaker2_modules_stickers_promo_caption');
					$data['moneymaker2_modules_stickers_promo_caption'] = isset($data['moneymaker2_modules_stickers_promo_caption'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_stickers_promo_caption'][$this->config->get('config_language_id')] : '';
					$data['moneymaker2_modules_stickers_promo_icon'] = $this->config->get('moneymaker2_modules_stickers_promo_icon');
				}
		}
		if ($data['moneymaker2_common_categories_icons_enabled']&&isset($data['moneymaker2_common_categories_icons'][$category_id])&&$data['moneymaker2_common_categories_icons'][$category_id]!='-') {
			$data['category_icon'] = $data['moneymaker2_common_categories_icons'][$category_id];
		} else {
			$data['category_icon'] = false;
		}
		$data['moneymaker2_catalog_categories_images_round'] = $this->config->get('moneymaker2_catalog_categories_images_round');
		$data['moneymaker2_catalog_categories_advantages_enabled'] = $this->config->get('moneymaker2_catalog_categories_advantages_enabled');
		if ($data['moneymaker2_catalog_categories_advantages_enabled']) {
			$data['moneymaker2_categories_advantages'] = array();
			$moneymaker2_categories_advantages = $this->config->get('moneymaker2_categories_advantages');
			if (!empty($moneymaker2_categories_advantages)){
				if ($category_id){
					foreach ($moneymaker2_categories_advantages as $key => $value) {
						if (isset($value['categories'])&&in_array($category_id, $value['categories'])) {
							$data['moneymaker2_categories_advantages'][] = array(
								'icon'          => $value['icon'],
								'categories'    => isset($value['categories']) ? $value['categories'] : array(0),
								'name'          => isset($value['name'][$this->config->get('config_language_id')]) ? $value['name'][$this->config->get('config_language_id')] : null,
								'link' => $value['link'],
								'style' => $value['style'],
							);
						}
					}
					if (count($data['moneymaker2_categories_advantages'])>2) {
						$moneymaker2_rand = mt_rand(0, count($data['moneymaker2_categories_advantages']) - 1);
						$data['moneymaker2_categories_advantages_l'] = $data['moneymaker2_categories_advantages'][$moneymaker2_rand];
						unset($data['moneymaker2_categories_advantages'][$moneymaker2_rand]);
						$data['moneymaker2_categories_advantages'] = array_values($data['moneymaker2_categories_advantages']);
						$moneymaker2_rand = mt_rand(0, count($data['moneymaker2_categories_advantages']) - 1);
						$data['moneymaker2_categories_advantages_r'] = $data['moneymaker2_categories_advantages'][$moneymaker2_rand];
					} else {
						$data['moneymaker2_categories_advantages_l'] = isset($data['moneymaker2_categories_advantages'][0]) ? $data['moneymaker2_categories_advantages'][0] : null;
						$data['moneymaker2_categories_advantages_r'] = isset($data['moneymaker2_categories_advantages'][1]) ? $data['moneymaker2_categories_advantages'][1] : null;
					}
				}
			} else {
				$data['moneymaker2_categories_advantages_l'] = null;
				$data['moneymaker2_categories_advantages_r'] = null;
			}
		}
		/*mmr*/
		

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			
		/*mmr*/
		if ($page==1||$page=="{page}") {
			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
		} else {
			$data['description'] = '';
		}
		/*mmr*/
		
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				
		/*mmr*/
		if ($this->config->get('moneymaker2_catalog_categories_child_images')) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('moneymaker2_catalog_categories_child_images_width'), $this->config->get('moneymaker2_catalog_categories_child_images_height'));
			} else {
				$image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('moneymaker2_catalog_categories_child_images_width'), $this->config->get('moneymaker2_catalog_categories_child_images_height'));
			}
		}
		$data['categories'][] = array(
			'thumb' => $this->config->get('moneymaker2_catalog_categories_child_images') ? $image : false,
			'icon' => $data['moneymaker2_common_categories_icons_enabled']&&$this->config->get('moneymaker2_catalog_categories_child_icons')&&isset($data['moneymaker2_common_categories_icons'][$result['category_id']]) ? $data['moneymaker2_common_categories_icons'][$result['category_id']] : null,
			/*mmr*/
		
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);


  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					
				if ($result['price'] > 0) {
				    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
				    $price = $this->language->get('text_price_free');
				}
			

        if ($this->currency->has($this->config->get('config_currency2')) && ($this->config->get('config_currency2') != $this->session->data['currency'])) {
            $price .= ' (' . $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->config->get('config_currency2')) . ')';
        }
      
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

        if ($this->currency->has($this->config->get('config_currency2')) && ($this->config->get('config_currency2') != $this->session->data['currency'])) {
            $special .= ' (' . $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->config->get('config_currency2')) . ')';
        }
      
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

				// Дополнительные изображения
				$additional_images = array();
				$additional_images_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$result['product_id'] . "' ORDER BY sort_order ASC LIMIT 4");

				foreach ($additional_images_query->rows as $image_row) {
					if ($image_row['image']) {
						$additional_images[] = array(
							'thumb' => $this->model_tool_image->resize($image_row['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')),
							'image' => $image_row['image']
						);
					}
				}

				// Цвета
				// Цвета - безопасная версия с проверкой существования таблиц
				$colors = array();
				// Характеристики
				$attributes = array();
				$attributes_query = $this->db->query("
        SELECT ad.name, pa.text 
        FROM " . DB_PREFIX . "product_attribute pa 
        LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (pa.attribute_id = ad.attribute_id)
        WHERE pa.product_id = '" . (int)$result['product_id'] . "' 
        AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "'
        AND (ad.name LIKE '%Размер%' OR ad.name LIKE '%Тип%' OR ad.name LIKE '%Материал%' 
             OR ad.name LIKE '%Size%' OR ad.name LIKE '%Material%' OR ad.name LIKE '%Type%')
        LIMIT 3
    ");

				foreach ($attributes_query->rows as $attr_row) {
					$attributes[$attr_row['name']] = $attr_row['text'];
				}

				// Стикеры
				$stickers = array();

				if ($result['quantity'] > 0) {
					$stickers[] = array(
						'type' => 'delivery',
						'caption' => 'Доставим завтра'
					);
				}

				if ($result['rating'] >= 4.5) {
					$stickers[] = array(
						'type' => 'hit',
						'caption' => 'Хит продаж'
					);
				}

				$days_diff = (time() - strtotime($result['date_added'])) / (60 * 60 * 24);
				if ($days_diff <= 30) {
					$stickers[] = array(
						'type' => 'new',
						'caption' => 'Новинка'
					);
				}

				if ($result['special'] && (float)$result['special'] < (float)$result['price']) {
					$discount = round(((float)$result['price'] - (float)$result['special']) / (float)$result['price'] * 100);
					$stickers[] = array(
						'type' => 'sale',
						'caption' => '-' . $discount . '%'
					);
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
		if ($this->config->get('moneymaker2_catalog_products_code_field')&&isset($result[$this->config->get('moneymaker2_catalog_products_code_field')])&&$result[$this->config->get('moneymaker2_catalog_products_code_field')]&&(!$this->config->get('moneymaker2_catalog_products_list_code_hide')||!$this->config->get('moneymaker2_catalog_products_grid_code_hide'))) {$moneymaker2_code = "<span class='code'>".$this->language->get('text_model')." <span>".$result[$this->config->get('moneymaker2_catalog_products_code_field')]."</span></span>";} else {$moneymaker2_code = '';}
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
			'stock'                 => $moneymaker2_stock,
			'code'                  => $moneymaker2_code,
			'sold'                  => $data['moneymaker2_common_cart_outofstock_disabled']&&$result['quantity'] <= 0 ? true : false,
			'quantity'              => $result['quantity'],
			'sort_order'            => $result['sort_order'],
			'review_count'          => $result['reviews'],
			'addtocart_tooltip'     => $moneymaker2_addtocart_tooltip,
			'addtocart_class'       => $moneymaker2_addtocart_class,
			'quickorder_tooltip'    => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_tooltip : '',
			'quickorder_class'      => $data['moneymaker2_modules_quickorder_enabled'] ? $moneymaker2_quickorder_class : '',
		/*mmr*/
		
					'product_id'        => $result['product_id'],
					'thumb'             => $image,
					'name'              => $result['name'],
					'description'       => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'             => $price,
					'special'           => $special,
					'tax'               => $tax,
					'minimum'           => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'            => $result['rating'],
					'reviews'           => $result['reviews'] ? $result['reviews'] : 0,
					'href'              => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url),
					'quantity'          => $result['quantity'],
					'model'             => $result['model'],
					'sku'               => $result['sku'] ? $result['sku'] : $result['model'],
					'stock'             => $result['quantity'] > 0 ? 'В наличии' : 'Нет в наличии',
					'stock_status'      => $result['stock_status'],
					'date_added'        => $result['date_added'],
					'additional_images' => $additional_images,
					'colors'            => $colors,
					'attributes'        => $attributes,
					'stickers'          => $stickers
				);
			}

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach ($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}


					//microdatapro 7.0 start - 1 - main
					$data['microdatapro_data'] = $category_info;
					$data['results'] = $results;
					$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
					$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
					$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/category', $data);
					$microdatapro_main_flag = 1;
					//microdatapro 7.0 end - 1 - main
				
			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
			} elseif ($page == 2) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev');
			} else {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page=' . ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page=' . ($page + 1), true), 'next');
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

      // OCFilter Start
      if (isset($this->request->get['filter_ocfilter'])) {
        if (!$product_total) {
      	  $this->response->redirect($this->url->link('product/category', 'path=' . $this->request->get['path']));
        }

        $data['description'] = '';

        $this->document->deleteLink('canonical');
      }

      $ocfilter_page_info = $this->load->controller('extension/module/ocfilter/getPageInfo');

      if ($ocfilter_page_info) {
        $this->document->setTitle($ocfilter_page_info['meta_title']);

        if ($ocfilter_page_info['meta_description']) {
			    $this->document->setDescription($ocfilter_page_info['meta_description']);
        }

        if ($ocfilter_page_info['meta_keyword']) {
			    $this->document->setKeywords($ocfilter_page_info['meta_keyword']);
        }

			  $data['heading_title'] = $ocfilter_page_info['title'];

        if ($ocfilter_page_info['description'] && !isset($this->request->get['page']) && !isset($this->request->get['sort']) && !isset($this->request->get['order']) && !isset($this->request->get['search']) && !isset($this->request->get['limit'])) {
        	$data['description'] = html_entity_decode($ocfilter_page_info['description'], ENT_QUOTES, 'UTF-8');
        }

  			$data['breadcrumbs'][] = array(
  				'text' => $ocfilter_page_info['title'],
  				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
  			);
      } else {
        $meta_title = $this->document->getTitle();
        $meta_description = $this->document->getDescription();
        $meta_keyword = $this->document->getKeywords();

        $filter_title = $this->load->controller('extension/module/ocfilter/getSelectedsFilterTitle');

        if ($filter_title) {
          if (false !== strpos($meta_title, '{filter}')) {
            $meta_title = trim(str_replace('{filter}', $filter_title, $meta_title));
          } else {
            $meta_title .= ' ' . $filter_title;
          }

          $this->document->setTitle($meta_title);

          if ($meta_description) {
            if (false !== strpos($meta_description, '{filter}')) {
              $meta_description = trim(str_replace('{filter}', $filter_title, $meta_description));
            } else {
              $meta_description .= ' ' . $filter_title;
            }

  			    $this->document->setDescription($meta_description);
          }

          if ($meta_keyword) {
            if (false !== strpos($meta_keyword, '{filter}')) {
              $meta_keyword = trim(str_replace('{filter}', $filter_title, $meta_keyword));
            } else {
              $meta_keyword .= ' ' . $filter_title;
            }

           	$this->document->setKeywords($meta_keyword);
          }

          $heading_title = $data['heading_title'];

          if (false !== strpos($heading_title, '{filter}')) {
            $heading_title = trim(str_replace('{filter}', $filter_title, $heading_title));
          } else {
            $heading_title .= ' ' . $filter_title;
          }

          $data['heading_title'] = $heading_title;

          $data['description'] = '';

    			$data['breadcrumbs'][] = array(
    				'text' => (utf8_strlen($heading_title) > 30 ? utf8_substr($heading_title, 0, 30) . '..' : $heading_title),
    				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
    			);
        } else {
          $this->document->setTitle(trim(str_replace('{filter}', '', $meta_title)));
          $this->document->setDescription(trim(str_replace('{filter}', '', $meta_description)));
          $this->document->setKeywords(trim(str_replace('{filter}', '', $meta_keyword)));

          $data['heading_title'] = trim(str_replace('{filter}', '', $data['heading_title']));
        }
      }
      // OCFilter End
      

			$data['continue'] = $this->url->link('common/home');


					//microdatapro 7.0 start - 2 - extra
					if(!isset($microdatapro_main_flag)){
						if(isset($category_info) && $category_info){
							$data['microdatapro_data'] = $category_info;
							$data['results'] = $results;
							$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
							$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
							$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/category', $data);
						}
					}
					//microdatapro 7.0 end - 2 - extra
				
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
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
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');


					//microdatapro 7.0 start - 2 - extra
					if(!isset($microdatapro_main_flag)){
						if(isset($category_info) && $category_info){
							$data['microdatapro_data'] = $category_info;
							$data['results'] = $results;
							$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
							$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
							$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/category', $data);
						}
					}
					//microdatapro 7.0 end - 2 - extra
				
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}
}
