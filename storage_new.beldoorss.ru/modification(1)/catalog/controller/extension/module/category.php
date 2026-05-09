<?php
class ControllerExtensionModuleCategory extends Controller {
	public function index() {
		$this->load->language('extension/module/category');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		/*mmr*/
		$data['moneymaker2_modules_categories_specials'] = $this->config->get('moneymaker2_modules_categories_specials');
		if ($data['moneymaker2_modules_categories_specials']) {
			$this->load->language('common/footer');
			$data['text_special'] = $this->language->get('text_special');
			$data['special'] = $this->url->link('product/special');
		}
		$data['moneymaker2_common_categories_icons_enabled'] = $this->config->get('moneymaker2_common_categories_icons_enabled');
		$data['moneymaker2_modules_categories_icons'] = $this->config->get('moneymaker2_modules_categories_icons');
		if ($data['moneymaker2_common_categories_icons_enabled']&&$data['moneymaker2_modules_categories_icons']) {
			$data['moneymaker2_common_categories_icons'] = $this->config->get('moneymaker2_common_categories_icons');
		} else {
			$data['moneymaker2_common_categories_icons'] = null;
		}
		/*mmr*/
		

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$children_data = array();

			if ($category['category_id'] == $data['category_id']) {
				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach($children as $child) {
					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

					$children_data[] = array(
						'category_id' => $child['category_id'],

		/*mmr*/
		'icon' => $data['moneymaker2_common_categories_icons_enabled']&&isset($data['moneymaker2_common_categories_icons'][$child['category_id']]) ? $data['moneymaker2_common_categories_icons'][$child['category_id']] : null,
		/*mmr*/
		
						'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}
			}

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'category_id' => $category['category_id'],

		/*mmr*/
		'icon' => $data['moneymaker2_common_categories_icons_enabled']&&isset($data['moneymaker2_common_categories_icons'][$category['category_id']]) ? $data['moneymaker2_common_categories_icons'][$category['category_id']] : null,
		/*mmr*/
		
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}

		return $this->load->view('extension/module/category', $data);
	}
}