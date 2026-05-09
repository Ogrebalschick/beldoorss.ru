<?php
class ControllerCommonLanguage extends Controller {
	public function index() {
		$this->load->language('common/language');

		$data['text_language'] = $this->language->get('text_language');

		$data['action'] = $this->url->link('common/language/language', '', $this->request->server['HTTPS']);

		$data['code'] = $this->session->data['language'];

		$this->load->model('localisation/language');

		$data['languages'] = array();

		$data['moneymaker2_header_strip_language'] = $this->config->get('moneymaker2_header_strip_language');
		$data['moneymaker2_header_strip_language'] = isset($data['moneymaker2_header_strip_language']) ? $data['moneymaker2_header_strip_language'] : 1;
		if ($data['moneymaker2_header_strip_language']>1) {
			switch ($data['moneymaker2_header_strip_language']) {
				case 2: $data['moneymaker2_header_strip_language_class'] = "hidden-lg hidden-md hidden-sm"; break;
				case 3: $data['moneymaker2_header_strip_language_class'] = "hidden-lg hidden-md hidden-sm visible-xlg"; break;
				case 4: $data['moneymaker2_header_strip_language_class'] = "hidden-md hidden-sm"; break;
				case 5: $data['moneymaker2_header_strip_language_class'] = "hidden-sm"; break;
				case 6: $data['moneymaker2_header_strip_language_class'] = ""; break;
			}
		}
		

		$results = $this->model_localisation_language->getLanguages();

		foreach ($results as $result) {
			if ($result['status']) {
				$data['languages'][] = array(
					'name' => $result['name'],
					'code' => $result['code']
				);
			}
		}

		if (!isset($this->request->get['route'])) {
			$data['redirect'] = $this->url->link('common/home');
		} else {
			$url_data = $this->request->get;

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$data['redirect'] = $this->url->link($route, $url, $this->request->server['HTTPS']);
		}

		return $this->load->view('common/language', $data);
	}

	public function language() {
		if (isset($this->request->post['code'])) {
			$this->session->data['language'] = $this->request->post['code'];
		}

		if (isset($this->request->post['redirect'])) {
			$this->response->redirect($this->request->post['redirect']);
		} else {
			$this->response->redirect($this->url->link('common/home'));
		}
	}
}