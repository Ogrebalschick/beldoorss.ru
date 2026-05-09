<?php
class ControllerProductSearch extends Controller {
	public function index() {
		$this->load->language('product/search');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}

		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		}

		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
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

		if (isset($this->request->get['search'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
		} elseif (isset($this->request->get['tag'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->language->get('heading_tag') . $this->request->get['tag']);
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$url = '';

		if (isset($this->request->get['search'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/search', $url)
		);

		if (isset($this->request->get['search'])) {
			$data['heading_title'] = $this->language->get('heading_title') .  ' - ' . $this->request->get['search'];
		} else {
			$data['heading_title'] = $this->language->get('heading_title');
		}

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_keyword'] = $this->language->get('text_keyword');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_sub_category'] = $this->language->get('text_sub_category');
		$data['text_quantity'] = $this->language->get('text_quantity');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_points'] = $this->language->get('text_points');
		$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$data['text_sort'] = $this->language->get('text_sort');
		$data['text_limit'] = $this->language->get('text_limit');

		$data['entry_search'] = $this->language->get('entry_search');
		$data['entry_description'] = $this->language->get('entry_description');

		$data['button_search'] = $this->language->get('button_search');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_list'] = $this->language->get('button_list');
		$data['button_grid'] = $this->language->get('button_grid');

		/*mmr*/
		$this->load->model('catalog/information');
		$this->load->language('product/product');
		$this->load->language('extension/module/moneymaker2');
		$data['moneymaker2_text_old_price'] = $this->language->get('text_old_price');
		$data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
		if ($data['moneymaker2_modules_quickorder_enabled']) {
			$data['moneymaker2_modules_quickorder_display_catalog'] = $this->config->get('moneymaker2_modules_quickorder_display_catalog');
			$data['moneymaker2_modules_quickorder_button_title'] = $this->config->get('moneymaker2_modules_quickorder_button_title');
			$data['moneymaker2_modules_quickorder_button_title'] = isset($data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')] : null;
		}
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
		/*mmr*/
		

		$data['compare'] = $this->url->link('product/compare');

		$this->load->model('catalog/category');

		// 3 Level Category Search
		$data['categories'] = array();

		$categories_1 = $this->model_catalog_category->getCategories(0);

		foreach ($categories_1 as $category_1) {
			$level_2_data = array();

			$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);

				foreach ($categories_3 as $category_3) {
					$level_3_data[] = array(
						'category_id' => $category_3['category_id'],
						'name'        => $category_3['name'],
					);
				}

				$level_2_data[] = array(
					'category_id' => $category_2['category_id'],
					'name'        => $category_2['name'],
					'children'    => $level_3_data
				);
			}

			$data['categories'][] = array(
				'category_id' => $category_1['category_id'],
				'name'        => $category_1['name'],
				'children'    => $level_2_data
			);
		}

		$data['products'] = array();

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$filter_data = array(
				'filter_name'         => $search,
				'filter_tag'          => $tag,
				'filter_description'  => $description,
				'filter_category_id'  => $category_id,
				'filter_sub_category' => $sub_category,
				'sort'                => $sort,
				'order'               => $order,
				'start'               => ($page - 1) * $limit,
				'limit'               => $limit
			);

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
		
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $result['rating'],
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url)
				);
			}

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/search', $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/search', $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/search', $url . '&page='. ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink($this->url->link('product/search', $url . '&page='. ($page + 1), true), 'next');
			}

			if (isset($this->request->get['search']) && $this->config->get('config_customer_search')) {
				$this->load->model('account/search');

				if ($this->customer->isLogged()) {
					$customer_id = $this->customer->getId();
				} else {
					$customer_id = 0;
				}

				if (isset($this->request->server['REMOTE_ADDR'])) {
					$ip = $this->request->server['REMOTE_ADDR'];
				} else {
					$ip = '';
				}

				$search_data = array(
					'keyword'       => $search,
					'category_id'   => $category_id,
					'sub_category'  => $sub_category,
					'description'   => $description,
					'products'      => $product_total,
					'customer_id'   => $customer_id,
					'ip'            => $ip
				);

				$this->model_account_search->addSearch($search_data);
			}
		}

		$data['search'] = $search;
		$data['description'] = $description;
		$data['category_id'] = $category_id;
		$data['sub_category'] = $sub_category;

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['limit'] = $limit;

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('product/search', $data));
	}
}
