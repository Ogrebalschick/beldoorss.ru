<?php
class ControllerCommonHome extends Controller {
	public function index() {
	    

					//microdatapro 7.0 start
					$data['microdatapro_data']['meta_description'] = $this->config->get('config_meta_description');
					$data['description'] = $this->config->get('config_meta_description');
					$data['heading_title'] = $this->config->get('config_meta_title');
					$data['breadcrumbs'] = array(array("href" => $this->url->link('common/home')));
					$data['microdatapro_data']['image'] = is_file(DIR_IMAGE . $this->config->get('config_logo'))?$this->config->get('config_logo'):'';
					$this->document->setTc_og($this->load->controller('extension/module/microdatapro/tc_og', $data));
					$this->document->setTc_og_prefix($this->load->controller('extension/module/microdatapro/tc_og_prefix'));
					//microdatapro 7.0 end
				
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink($this->config->get('config_url'), 'canonical');
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		/*mmr*/
		$data['moneymaker2_catalog_home_advantages_enabled'] = $this->config->get('moneymaker2_catalog_home_advantages_enabled');
		$data['moneymaker2_catalog_home_advantages_header'] = $this->config->get('moneymaker2_catalog_home_advantages_header');
		$data['moneymaker2_catalog_home_advantages_header'] = isset($data['moneymaker2_catalog_home_advantages_header'][$this->config->get('config_language_id')]) ? $data['moneymaker2_catalog_home_advantages_header'][$this->config->get('config_language_id')] : null;
		$data['moneymaker2_catalog_home_advantages_icon'] = $this->config->get('moneymaker2_catalog_home_advantages_icon');
		if ($data['moneymaker2_catalog_home_advantages_enabled']) {
			$data['moneymaker2_categories_advantages'] = array();
			$moneymaker2_categories_advantages = $this->config->get('moneymaker2_categories_advantages');
			if (!empty($moneymaker2_categories_advantages)){
					foreach ($moneymaker2_categories_advantages as $key => $value) {
						if (isset($value['categories'])&&in_array('home', $value['categories'])) {
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
			} else {
				$data['moneymaker2_categories_advantages_l'] = null;
				$data['moneymaker2_categories_advantages_r'] = null;
			}
		}
		$data['moneymaker2_catalog_home_advantages_text'] = $this->config->get('moneymaker2_catalog_home_advantages_text');
		$data['moneymaker2_catalog_home_advantages_text'] = isset($data['moneymaker2_catalog_home_advantages_text'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_catalog_home_advantages_text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		$data['moneymaker2_categories_advantageslinks'] = array();
		$moneymaker2_categories_advantageslinks = $this->config->get('moneymaker2_categories_advantageslinks');
		if (!empty($moneymaker2_categories_advantageslinks)){
			foreach ($moneymaker2_categories_advantageslinks as $key => $value) {
				$data['moneymaker2_categories_advantageslinks'][] = array(
					'caption'  => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
					'link'  => $value['link'],
					'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					'icon'  => $value['icon'],
					'sort_order'  => $value['sort_order'],
				);
				$moneymaker2_categories_advantageslinks_sort_order[$key] = $value['sort_order'];
			}
			array_multisort($moneymaker2_categories_advantageslinks_sort_order, SORT_ASC, $data['moneymaker2_categories_advantageslinks']);
		}
		/*mmr*/
		

		$this->response->setOutput($this->load->view('common/home', $data));
		$this->load->model('catalog/category');
	}
}