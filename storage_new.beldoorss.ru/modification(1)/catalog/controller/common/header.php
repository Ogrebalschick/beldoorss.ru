<?php
class ControllerCommonHeader extends Controller {
	public function index() {

		/*mmr*/
		if ($this->config->get('moneymaker2_header_search_ajax')) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/livesearch.js');
		if ($this->config->get('moneymaker2_common_browser_warned')) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/browser.update.js');
		if ($this->config->get('moneymaker2_common_sidebars_responsive')) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/sidebars.responsive.js');
		if ($this->config->get('moneymaker2_common_scrolltop')) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/scrolltop.js');
		if ($this->config->get('moneymaker2_modules_snow')) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/snowstorm-min.js');
		$this->document->addStyle('catalog/view/theme/moneymaker2/stylesheet/bootstrap-theme-colors.store'.$this->config->get('config_store_id').'.css?v=270-1');
		$this->document->addStyle('catalog/view/theme/moneymaker2/stylesheet/stylesheet.css?v=270');
		$this->document->addStyle('catalog/view/theme/moneymaker2/stylesheet/stylesheet.custom.store'.$this->config->get('config_store_id').'.css?v='.$this->config->get('moneymaker2_date'));
		/*mmr*/
		
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}


					//microdatapro 7.0 start - 1 - main
					$data['tc_og'] = $this->document->getTc_og();
					$data['tc_og_prefix'] = $this->document->getTc_og_prefix();
					$microdatapro_main_flag = 1;
					//microdatapro 7.0 end - 1 - main
					
		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();

    // OCFilter start
    $data['noindex'] = $this->document->isNoindex();
    // OCFilter end
      
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');


					//microdatapro 7.0 start - 2 - extra
					if(!isset($microdatapro_main_flag)){
						$data['tc_og'] = $this->document->getTc_og();
						$data['tc_og_prefix'] = $this->document->getTc_og_prefix();
					}
					//microdatapro 7.0 end - 2 - extra
					
		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		$this->load->model('account/wishlist');
		if ($this->customer->isLogged()) {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			
      $wishlist = isset($_COOKIE['cookieWishlist']) ? json_decode($_COOKIE['cookieWishlist'],1) : [];
      $wishlist = array_unique($wishlist);
        $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), count($wishlist));
        
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

		/*mmr*/
		if ($this->config->get('moneymaker2_common_minify')) {
			$data['moneymaker2_minify'] = array("ext_js" => array(), "int_js" => array(), "ext_css" => array(), "int_css" => array() );
			foreach ($data['scripts'] as $script) {
				if ((substr($script,0,4)=="http")||(substr($script,0,3)=="www")||(substr($script,0,2)=="//")) {
					$data['moneymaker2_minify']['ext_js'][] = $script;
				} else if (strpos($script, ".js")) {
					$data['moneymaker2_minify']['int_js'][] = str_replace('//', '/', strpos($script, "?") ? substr($script, 0, strpos($script, "?")) : $script);
				}
			}
			foreach ($data['styles'] as $style) {
				if ((substr($style['href'],0,4)=="http")||(substr($style['href'],0,3)=="www")||(substr($style['href'],0,2)=="//")) {
					$data['moneymaker2_minify']['ext_css'][] = $style;
				} else if (strpos($style['href'], ".css")) {
					$data['moneymaker2_minify']['int_css'][] = str_replace('//', '/', strpos($style['href'], "?") ? substr($style['href'], 0, strpos($style['href'], "?")) : $style['href']);
				}
			}
		}
		$this->load->model('tool/image');
		$data['compare'] = $this->url->link('product/compare', '', 'SSL');
		$data['moneymaker2_text_customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
		$this->load->language('extension/module/moneymaker2');
		$data['text_menu'] = $this->language->get('text_menu');
		$data['text_compare'] = $this->language->get('text_compare').' ('.(isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0).')';
		$data['text_search'] = $this->language->get('text_search');
		$data['moneymaker2_header_strip_language'] = $this->config->get('moneymaker2_header_strip_language');
		$data['moneymaker2_header_strip_language'] = isset($data['moneymaker2_header_strip_language']) ? $data['moneymaker2_header_strip_language'] : 1;
		$data['moneymaker2_header_strip_currency'] = $this->config->get('moneymaker2_header_strip_currency');
		$data['moneymaker2_header_strip_currency'] = isset($data['moneymaker2_header_strip_currency']) ? $data['moneymaker2_header_strip_currency'] : 1;
		$data['moneymaker2_header_strip_toggle_cart'] = $this->config->get('moneymaker2_header_strip_toggle_cart');
		$data['moneymaker2_header_strip_toggle_search'] = $this->config->get('moneymaker2_header_strip_toggle_search');
		$data['moneymaker2_header_strip_toggle_language'] = $this->config->get('moneymaker2_header_strip_toggle_language');
		$data['moneymaker2_header_logo_custom'] = $this->config->get('moneymaker2_header_logo_custom');
		if ($data['moneymaker2_header_logo_custom']) {
			$data['moneymaker2_header_logo_custom_icon'] = $this->config->get('moneymaker2_header_logo_custom_icon');
			$data['moneymaker2_header_logo_custom_header'] = $this->config->get('moneymaker2_header_logo_custom_header');
			$data['moneymaker2_header_logo_custom_header'] = isset($data['moneymaker2_header_logo_custom_header'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_header_logo_custom_header'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
			$data['moneymaker2_header_logo_custom_caption'] = $this->config->get('moneymaker2_header_logo_custom_caption');
			$data['moneymaker2_header_logo_custom_caption'] = isset($data['moneymaker2_header_logo_custom_caption'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_header_logo_custom_caption'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		}
		$data['moneymaker2_header_contacts'] = array();
		$moneymaker2_header_contacts = $this->config->get('moneymaker2_header_contacts');
		if (!empty($moneymaker2_header_contacts)){
			foreach ($moneymaker2_header_contacts as $key => $value) {
				$data['moneymaker2_header_contacts'][] = array(
					'icon'  => $value['icon'],
					'text'  => isset($value['text'][$this->config->get('config_language_id')]) ? $value['text'][$this->config->get('config_language_id')] : null,
					'link'  => $value['link'],
					'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					'mode' => $value['mode'],
					'image' => is_file(DIR_IMAGE . $value['image']) ? $this->model_tool_image->resize($value['image'], 16, 16) : ''
				);
				$moneymaker2_header_contacts_sort_order[$key] = $value['sort_order'];
			}
			array_multisort($moneymaker2_header_contacts_sort_order, SORT_ASC, $data['moneymaker2_header_contacts']);
		}
		$data['moneymaker2_header_contacts_icon'] = $this->config->get('moneymaker2_header_contacts_icon');
		$data['moneymaker2_header_contacts_phone'] = html_entity_decode($this->config->get('moneymaker2_header_contacts_phone'), ENT_QUOTES, 'UTF-8');
		$data['moneymaker2_header_contacts_title'] = $this->config->get('moneymaker2_header_contacts_title');
		$data['moneymaker2_header_contacts_title'] = isset($data['moneymaker2_header_contacts_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_header_contacts_title'][$this->config->get('config_language_id')] : null;
		$data['moneymaker2_header_categories_menu_hide'] = $this->config->get('moneymaker2_header_categories_menu_hide');
		$data['moneymaker2_header_categories_menu_hidechilds'] = $this->config->get('moneymaker2_header_categories_menu_hidechilds');
		$data['moneymaker2_header_categories_menu_caption'] = $this->config->get('moneymaker2_header_categories_menu_caption');
		$data['moneymaker2_header_categories_menu_caption'] = isset($data['moneymaker2_header_categories_menu_caption'][$this->config->get('config_language_id')]) ? $data['moneymaker2_header_categories_menu_caption'][$this->config->get('config_language_id')] : null;
		$data['moneymaker2_header_categories_menu_mod'] = $this->config->get('moneymaker2_header_categories_menu_mod');
		$data['moneymaker2_header_categories_panel'] = $this->config->get('moneymaker2_header_categories_panel');
		$data['moneymaker2_header_categories_menu_icons'] = $this->config->get('moneymaker2_header_categories_menu_icons');
		$data['moneymaker2_header_strip_expanded'] = $this->config->get('moneymaker2_header_strip_expanded');
		$data['moneymaker2_header_strip_fixed'] = $this->config->get('moneymaker2_header_strip_fixed');
		$data['moneymaker2_header_categories_panel_expanded'] = $this->config->get('moneymaker2_header_categories_panel_expanded');
		$data['moneymaker2_header_categories_panel_fixed'] = $this->config->get('moneymaker2_header_categories_panel_fixed');
		$data['moneymaker2_common_categories_icons_enabled'] = $this->config->get('moneymaker2_common_categories_icons_enabled');
		$data['moneymaker2_common_categories_icons'] = $this->config->get('moneymaker2_common_categories_icons');
		$data['moneymaker2_header_categories_menu_hidethumbs'] = $this->config->get('moneymaker2_header_categories_menu_hidethumbs');
		$data['moneymaker2_header_categories_menu_columns'] = $this->config->get('moneymaker2_header_categories_menu_columns');
		$data['moneymaker2_header_categories_panel_mod'] = $this->config->get('moneymaker2_header_categories_panel_mod');
		$data['moneymaker2_header_categories_panel_icons'] = $this->config->get('moneymaker2_header_categories_panel_icons');
		$data['moneymaker2_header_categories_panel_hideparents'] = $this->config->get('moneymaker2_header_categories_panel_hideparents');
		$data['moneymaker2_header_categories_panel_hidechilds'] = $this->config->get('moneymaker2_header_categories_panel_hidechilds');
		$data['moneymaker2_header_categories_panel_hidethumbs'] = $this->config->get('moneymaker2_header_categories_panel_hidethumbs');
		$data['moneymaker2_header_categories_panel_child_icons'] = $this->config->get('moneymaker2_header_categories_panel_child_icons');
		$data['moneymaker2_header_categories_panel_columns'] = $this->config->get('moneymaker2_header_categories_panel_columns');
		$data['moneymaker2_header_search_moved'] = $this->config->get('moneymaker2_header_search_moved');
		$data['moneymaker2_common_minify'] = $this->config->get('moneymaker2_common_minify');
		$data['moneymaker2_header_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
		$data['moneymaker2_common_wishlist_hide'] = $this->config->get('moneymaker2_common_wishlist_hide');
		$data['moneymaker2_common_compare_hide'] = $this->config->get('moneymaker2_common_compare_hide');
		$data['moneymaker2_header_banners'] = array();
		$moneymaker2_header_banners = $this->config->get('moneymaker2_header_banners');
		if (!empty($moneymaker2_header_banners)){
			foreach ($moneymaker2_header_banners as $key => $value) {
				$data['moneymaker2_header_banners'][] = array(
					'name'  => isset($value['name'][$this->config->get('config_language_id')]) ? $value['name'][$this->config->get('config_language_id')] : null,
					'text'  => isset($value['text'][$this->config->get('config_language_id')]) ? html_entity_decode($value['text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null,
					'link'  => $value['link'],
					'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					'style' => $value['style'],
					'icon'  => $value['icon'],
					'sort_order'  => $value['sort_order'],
					'image' => is_file(DIR_IMAGE . $value['image']) ? $this->model_tool_image->resize($value['image'], $this->config->get('moneymaker2_header_categories_menu_thumbs_width') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_menu_thumbs_height') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height')) : '',
				);
			}
		}
		$data['moneymaker2_header_panelbanners'] = array();
		$moneymaker2_header_panelbanners = $this->config->get('moneymaker2_header_panelbanners');
		if ($data['moneymaker2_header_categories_panel_mod']&&!empty($moneymaker2_header_panelbanners)){
			foreach ($moneymaker2_header_panelbanners as $key => $value) {
				$data['moneymaker2_header_panelbanners'][] = array(
					'name'  => isset($value['name'][$this->config->get('config_language_id')]) ? $value['name'][$this->config->get('config_language_id')] : null,
					'text'  => isset($value['text'][$this->config->get('config_language_id')]) ? html_entity_decode($value['text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null,
					'link'  => $value['link'],
					'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					'style' => $value['style'],
					'icon'  => $value['icon'],
					'sort_order'  => $value['sort_order'],
					'sort_order_outer'  => $value['sort_order_outer'],
					'image' => is_file(DIR_IMAGE . $value['image']) ? $this->model_tool_image->resize($value['image'], $this->config->get('moneymaker2_header_categories_panel_thumbs_width') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_panel_thumbs_height') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height')) : '',
				);
			}
		}
		$data['moneymaker2_header_panellinks'] = array();
		$moneymaker2_header_panellinks = $this->config->get('moneymaker2_header_panellinks');
		if (!empty($moneymaker2_header_panellinks)){
			foreach ($moneymaker2_header_panellinks as $key => $value) {
				$data['moneymaker2_header_panellinks'][] = array(
					'caption'  => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
					'link'  => $value['link'],
					'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					'icon'  => $value['icon'],
					'sort_order'  => $value['sort_order'],
				);
				$moneymaker2_header_panellinks_sort_order[$key] = $value['sort_order'];
			}
			array_multisort($moneymaker2_header_panellinks_sort_order, SORT_ASC, $data['moneymaker2_header_panellinks']);
		}
		$data['moneymaker2_header_cart_items'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['moneymaker2_header_strip_menu'] = $this->config->get('moneymaker2_header_strip_menu');
		$data['moneymaker2_header_strip_menu'] = isset($data['moneymaker2_header_strip_menu']) ? $data['moneymaker2_header_strip_menu'] : 1;
		switch ($data['moneymaker2_header_strip_menu']) {
			case 1: $data['moneymaker2_header_strip_menu_class'] = "hidden-lg hidden-md hidden-sm"; break;
			case 2: $data['moneymaker2_header_strip_menu_class'] = "hidden-lg hidden-md hidden-sm visible-xlg"; break;
			case 3: $data['moneymaker2_header_strip_menu_class'] = "hidden-md hidden-sm"; break;
			case 4: $data['moneymaker2_header_strip_menu_class'] = "hidden-sm"; break;
			case 5: $data['moneymaker2_header_strip_menu_class'] = ""; break;
		}
		$data['moneymaker2_header_menu_links_enabled'] = $this->config->get('moneymaker2_header_menu_links_enabled');
		$data['moneymaker2_header_menu_links_top_enabled'] = $this->config->get('moneymaker2_header_menu_links_top_enabled');
		if ($data['moneymaker2_header_menu_links_enabled']||$data['moneymaker2_header_menu_links_top_enabled']) {
			$data['moneymaker2_header_menu_links_caption'] = $this->config->get('moneymaker2_header_menu_links_caption');
			$data['moneymaker2_header_menu_links_caption'] = isset($data['moneymaker2_header_menu_links_caption'][$this->config->get('config_language_id')]) ? $data['moneymaker2_header_menu_links_caption'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_header_links'] = array();
			$moneymaker2_header_links = $this->config->get('moneymaker2_header_links');
			if (!empty($moneymaker2_header_links)){
				foreach ($moneymaker2_header_links as $key => $value) {
					$data['moneymaker2_header_links'][] = array(
						'caption'  => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
						'link'  => $value['link'],
						'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
						'icon'  => $value['icon'],
						'sort_order'  => $value['sort_order'],
					);
					$moneymaker2_header_links_sort_order[$key] = $value['sort_order'];
				}
				array_multisort($moneymaker2_header_links_sort_order, SORT_ASC, $data['moneymaker2_header_links']);
			}
		}
		$data['moneymaker2_modules_callback_enabled'] = $this->config->get('moneymaker2_modules_callback_enabled');
		if ($data['moneymaker2_modules_callback_enabled']) {
			$data['moneymaker2_modules_callback_header'] = $this->config->get('moneymaker2_modules_callback_header');
			$data['moneymaker2_modules_callback_header'] = isset($data['moneymaker2_modules_callback_header'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_callback_header'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_modules_callback_caption'] = $this->config->get('moneymaker2_modules_callback_caption');
			$data['moneymaker2_modules_callback_caption'] = isset($data['moneymaker2_modules_callback_caption'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_callback_caption'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_modules_callback_image'] = $this->config->get('moneymaker2_modules_callback_image');
			if ($data['moneymaker2_modules_callback_image']) {
				$moneymaker2_modules_callback_image = is_file(DIR_IMAGE . $this->config->get('moneymaker2_modules_callback_image_src')) ? $this->model_tool_image->resize($this->config->get('moneymaker2_modules_callback_image_src'), $this->config->get('moneymaker2_modules_callback_thumbs_width') ? $this->config->get('moneymaker2_modules_callback_thumbs_width') : 228, $this->config->get('moneymaker2_modules_callback_thumbs_height') ? $this->config->get('moneymaker2_modules_callback_thumbs_height') : 228) : $this->model_tool_image->resize('no_image.png', $this->config->get('moneymaker2_modules_callback_thumbs_width') ? $this->config->get('moneymaker2_modules_callback_thumbs_width') : 228, $this->config->get('moneymaker2_modules_callback_thumbs_height') ? $this->config->get('moneymaker2_modules_callback_thumbs_height') : 228);
				$data['moneymaker2_modules_callback_image'] = $moneymaker2_modules_callback_image;
			}
		}
		/*mmr*/
		

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					
		/*mmr*/
		$moneymaker2_children_data = array();
		if (!$this->config->get('moneymaker2_header_categories_panel_hidechilds')) {
			$moneymaker2_children = $this->model_catalog_category->getCategories($child['category_id']);
			foreach ($moneymaker2_children as $moneymaker2_child) {
				$moneymaker2_data = array(
					'filter_category_id' => $moneymaker2_child['category_id'],
					'filter_sub_category' => true
				);
				$moneymaker2_children_data[] = array(
					'name' => $moneymaker2_child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($moneymaker2_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $moneymaker2_child['category_id'])
				);
			}
		}
		if ($child['image']) {
			$child_image = $this->model_tool_image->resize($child['image'], $this->config->get('moneymaker2_header_categories_panel_thumbs_width') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_panel_thumbs_height') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height'));
		} else {
			$child_image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('moneymaker2_header_categories_panel_thumbs_width') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_panel_thumbs_height') ? $this->config->get('moneymaker2_header_categories_panel_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height'));
		}
		if ($data['moneymaker2_common_categories_icons_enabled']&&isset($data['moneymaker2_common_categories_icons'][$child['category_id']])&&$this->config->get('moneymaker2_header_categories_panel_child_icons')) {
			$icon = $data['moneymaker2_common_categories_icons'][$child['category_id']];
		} else $icon = false;
		$children_data[] = array(
			'child_image' => $child_image,
			'icon'        => $icon,
			'children' => $moneymaker2_children_data,
			'sort_order'     => $child['sort_order'],
		/*mmr*/
		
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				
		/*mmr*/
		if ($category['image']) {
			$image = $this->model_tool_image->resize($category['image'], $this->config->get('moneymaker2_header_categories_menu_thumbs_width') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_menu_thumbs_height') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height'));
		} else {
			$image = $this->model_tool_image->resize('no_image.png', $this->config->get('moneymaker2_header_categories_menu_thumbs_width') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_width') : $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get('moneymaker2_header_categories_menu_thumbs_height') ? $this->config->get('moneymaker2_header_categories_menu_thumbs_height') : $this->config->get($this->config->get('config_theme') . '_image_category_height'));
		}
		if ($data['moneymaker2_common_categories_icons_enabled']&&isset($data['moneymaker2_common_categories_icons'][$category['category_id']])) {
			$icon = $data['moneymaker2_common_categories_icons'][$category['category_id']];
		} else $icon = false;
		$data['categories'][] = array(
			'image'         => $image,
			'icon'          => $icon,
			'sort_order'    => $category['sort_order'],
			'description'   => $this->config->get('moneymaker2_header_categories_panel_description')&&in_array($category['category_id'], $this->config->get('moneymaker2_header_categories_panel_description_categories')) ? utf8_substr(strip_tags(html_entity_decode($category['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('moneymaker2_header_categories_panel_description_limit')) . '..' : false,
		/*mmr*/
		
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}


		/*mmr*/
		if ($this->config->get('moneymaker2_header_categories_menu_hideparents')) {
			$data['header_categories'] = array();
		} else {
			$data['header_categories'] = $data['categories'];
		}
		if ($data['moneymaker2_header_banners']) {
			foreach ($data['moneymaker2_header_banners'] as $key => $value) {
				$data['header_categories'][] = array('image' => $value['image'], 'icon' => $value['icon'], 'name' => $value['name'], 'children' => '', 'href' => $value['multilink'] ? $value['multilink'] : $value['link'], 'text' => $value['text'], 'style' => $value['style'], 'sort_order' => $value['sort_order']);
			}
		}
		$moneymaker2_categories = $data['header_categories'];
		$data['header_categories'] = array();
		if (!empty($moneymaker2_categories)){
			foreach ($moneymaker2_categories as $key => $value) {
				$data['header_categories'][] = array(
					'name'  => isset($value['name']) ? $value['name'] : '',
					'children' => isset($value['children']) ? $value['children'] : '',
					'column' => isset($value['column']) ? $value['column'] : '',
					'href' => isset($value['href']) ? $value['href'] : '',
					'text'  => isset($value['text']) ? $value['text'] : '',
					'style' => isset($value['style']) ? $value['style'] : '',
					'icon'  => isset($value['icon']) ? $value['icon'] : '',
					'image' => isset($value['image']) ? $value['image'] : '',
				);
				$moneymaker2_categories_sort_order[$key] = $value['sort_order'];
			}
			array_multisort($moneymaker2_categories_sort_order, SORT_ASC, $data['header_categories']);
		}
		$moneymaker2_categories = $data['categories'];
		$data['categories'] = [];
		$moneymaker2_categories_sort_order = array();
		if (!empty($moneymaker2_categories)){
			foreach ($moneymaker2_categories as $key => $value) {
				$data['categories'][] = array(
					'name'  => isset($value['name']) ? $value['name'] : '',
					'children' => isset($value['children']) ? $value['children'] : '',
					'column' => isset($value['column']) ? $value['column'] : '',
					'href' => isset($value['href']) ? $value['href'] : '',
					'text'  => isset($value['text']) ? $value['text'] : '',
					'style' => isset($value['style']) ? $value['style'] : '',
					'icon'  => isset($value['icon']) ? $value['icon'] : '',
					'image' => isset($value['image']) ? $value['image'] : '',
					'sort_order' => isset($value['sort_order']) ? $value['sort_order'] : '',
					'description' => isset($value['description']) ? $value['description'] : '',
				);
				$moneymaker2_categories_sort_order[$key] = $value['sort_order'];
			}
			array_multisort($moneymaker2_categories_sort_order, SORT_ASC, $data['categories']);
		}
		$moneymaker2_sort_order_outer = array();
		if ($data['moneymaker2_header_panelbanners']) {
			foreach ($data['moneymaker2_header_panelbanners'] as $key => $value) {
				foreach ($data['categories'] as $key2 => $value2) {
					if ($value2['sort_order']==$value['sort_order_outer']) {
						$data['categories'][$key2]['children'][] = array('child_image' => $value['image'], 'icon' => $value['icon'], 'name' => $value['name'], 'children' => '', 'href' => $value['multilink'] ? $value['multilink'] : $value['link'], 'text' => $value['text'], 'style' => $value['style'], 'sort_order' => $value['sort_order']);
						$moneymaker2_sort_order_outer[]=$value['sort_order_outer'];
					}
				}
			}
		}
		foreach ($data['categories'] as $key => $value) {
			if (in_array($value['sort_order'], $moneymaker2_sort_order_outer)) {
				$moneymaker2_categories = $data['categories'][$key]['children'];
				$data['categories'][$key]['children'] = array();
				$moneymaker2_categories_sort_order = array();
				if (!empty($moneymaker2_categories)){
					foreach ($moneymaker2_categories as $key2 => $value2) {
						$data['categories'][$key]['children'][] = array(
							'child_image' => isset($value2['child_image']) ? $value2['child_image'] : '',
							'style'  => isset($value2['style']) ? $value2['style'] : '',
							'icon'  => isset($value2['icon']) ? $value2['icon'] : '',
							'children' => isset($value2['children']) ? $value2['children'] : '',
							'name'  => isset($value2['name']) ? $value2['name'] : '',
							'href' => isset($value2['href']) ? $value2['href'] : '',
							'text' => isset($value2['text']) ? $value2['text'] : '',
						);
						$moneymaker2_categories_sort_order[$key2] = $value2['sort_order'];
					}
					array_multisort($moneymaker2_categories_sort_order, SORT_ASC, $data['categories'][$key]['children']);
				}
			}
		}
		/*mmr*/
		

      	$this->load->model('newsblog/category');
        $this->load->model('newsblog/article');

		$data['newsblog_categories'] = array();

		$categories = $this->model_newsblog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['settings']) {
				$settings=unserialize($category['settings']);
				if ($settings['show_in_top']==0) continue;
			}

			$articles = array();

			if ($category['settings'] && $settings['show_in_top_articles']) {
				$filter=array('filter_category_id'=>$category['category_id'],'filter_sub_category'=>true);
				$results = $this->model_newsblog_article->getArticles($filter);

				foreach ($results as $result) {
					$articles[] = array(
						'name'        => $result['name'],
						'href'        => $this->url->link('newsblog/article', 'newsblog_path=' . $category['category_id'] . '&newsblog_article_id=' . $result['article_id'])
					);
				}
            }
			$data['categories'][] = array(
				'name'     => $category['name'],
				'children' => $articles,
				'column'   => 1,
				'href'     => $this->url->link('newsblog/category', 'newsblog_path=' . $category['category_id'])
			);
		}
		
		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		return $this->load->view('common/header', $data);
	}
}