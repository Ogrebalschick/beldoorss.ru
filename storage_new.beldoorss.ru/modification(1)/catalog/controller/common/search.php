<?php
class ControllerCommonSearch extends Controller {

		/*mmr*/
		public function ajaxsearch() {
			$this->load->model('tool/image');
			$this->load->language('common/header');
			$data = array();
			if( isset($this->request->get['search']) ) {
				function custom_escape_string($inp) {
					if(is_array($inp))
						return array_map(__METHOD__, $inp);
					if(!empty($inp) && is_string($inp)) {
						return str_replace(array('\\', "\0", "\n", "\r", "'", '"', "\x1a"), array('\\\\', '\\0', '\\n', '\\r', "\\'", '\\"', '\\Z'), $inp);
					}
					return $inp;
				}
				$keywords = custom_escape_string( $this->request->get['search'] );
				if( strlen($keywords) >= 3 ) {
					$parts = $keywords;
					$add = '';
					$add .= ' AND ((LOWER(pd.name) LIKE "%' . $this->db->escape($parts) . '%")';
					$add .= ' OR (LOWER(p.sku) LIKE "%' . $this->db->escape($parts) . '%")';
					$add .= ' OR (LOWER(p.model) LIKE "%' . $this->db->escape($parts) . '%"))';
					$add = substr( $add, 4 );
					$sql  = "SELECT DISTINCT pd.product_id, pd.name, p.image";
					if ($this->config->get('moneymaker2_header_search_ajax_code')) {
					$sql .= ", p.model, p.sku, p.upc, p.ean, p.jan, p.isbn, p.mpn";
					}
					if ($this->config->get('moneymaker2_header_search_ajax_price')) {
					$sql .= ", p.tax_class_id, p.price, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";
					}
					$sql  .= " FROM " . DB_PREFIX . "product_description AS pd ";
					$sql .= 'LEFT JOIN ' . DB_PREFIX . 'product AS p ON p.product_id = pd.product_id ';
					$sql .= 'LEFT JOIN ' . DB_PREFIX . 'product_to_store AS p2s ON p2s.product_id = pd.product_id ';
					$sql .= 'WHERE ' . $add . ' AND p.status = 1 ';
					$sql .= 'AND pd.language_id = ' . (int)$this->config->get('config_language_id');
					$sql .= ' AND p2s.store_id =  ' . (int)$this->config->get('config_store_id');
					$sql .= ' ORDER BY p.sort_order ASC, LOWER(pd.name) ASC, LOWER(p.model) ASC';
					$sql .= ' LIMIT 9';
					$res = $this->db->query( $sql );
					if( $res ) {
						$data = ( isset($res->rows) ) ? $res->rows : $res->row;
						$basehref = 'product/product&search=' . $this->request->get['search'] . '&product_id=';
						foreach( $data as $key => $values ) {
							$data[$key] = array(
								'name' => htmlspecialchars_decode($values['name'], ENT_QUOTES),
								'code' => $this->config->get('moneymaker2_header_search_ajax_code')&&$values[$this->config->get('moneymaker2_header_search_ajax_code_field')]&&isset($values[$this->config->get('moneymaker2_header_search_ajax_code_field')]) ? $values[$this->config->get('moneymaker2_header_search_ajax_code_field')] : '',
								'price' => $this->config->get('moneymaker2_header_search_ajax_price') ? (($this->config->get('config_customer_price') && $this->customer->isLogged())||!$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($values['discount'] ? $values['discount'] : $values['price'], $values['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']) : '' : '',
								'special' => $this->config->get('moneymaker2_header_search_ajax_price') ? (float)$values['special'] ? $this->currency->format($this->tax->calculate($values['special'], $values['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']) : '' : '',
								'image' => $this->config->get('moneymaker2_header_search_ajax_image') ? is_file(DIR_IMAGE . $values['image']) ? $this->model_tool_image->resize($values['image'], $this->config->get('moneymaker2_header_search_ajax_image_width'), $this->config->get('moneymaker2_header_search_ajax_image_height')) : $this->model_tool_image->resize('no_image.png', $this->config->get('moneymaker2_header_search_ajax_image_width'), $this->config->get('moneymaker2_header_search_ajax_image_height')) : '',
								'href' => html_entity_decode($this->url->link($basehref . $values['product_id']))
							);
						}
						if (count($data)==9) $data[8] = $this->language->get('text_all');
					}
				}
			}
			echo json_encode( $data );
		}
		/*mmr*/
		
	public function index() {
		$this->load->language('common/search');

		$data['text_search'] = $this->language->get('text_search');

		/*mmr*/
		$data['button_search'] = $this->language->get('button_search');
		$data['moneymaker2_header_strip_search'] = $this->config->get('moneymaker2_header_strip_search');
		$data['moneymaker2_header_strip_search'] = isset($data['moneymaker2_header_strip_search']) ? $data['moneymaker2_header_strip_search'] : 1;
		switch ($data['moneymaker2_header_strip_search']) {
			case 1: $data['moneymaker2_header_strip_search_class'] = "hidden-lg hidden-md hidden-sm"; break;
			case 2: $data['moneymaker2_header_strip_search_class'] = "hidden-lg hidden-md hidden-sm visible-xlg"; break;
			case 3: $data['moneymaker2_header_strip_search_class'] = "hidden-md hidden-sm"; break;
			case 4: $data['moneymaker2_header_strip_search_class'] = "hidden-sm"; break;
			case 5: $data['moneymaker2_header_strip_search_class'] = ""; break;
		}
		/*mmr*/
		

		if (isset($this->request->get['search'])) {
			$data['search'] = $this->request->get['search'];
		} else {
			$data['search'] = '';
		}

		return $this->load->view('common/search', $data);
	}
}