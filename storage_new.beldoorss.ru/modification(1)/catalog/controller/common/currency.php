<?php
class ControllerCommonCurrency extends Controller {
	public function index() {
		$this->load->language('common/currency');

		$data['text_currency'] = $this->language->get('text_currency');

		$data['action'] = $this->url->link('common/currency/currency', '', $this->request->server['HTTPS']);

		$data['code'] = $this->session->data['currency'];

		$this->load->model('localisation/currency');

		$data['currencies'] = array();

		$results = $this->model_localisation_currency->getCurrencies();

		foreach ($results as $result) {
			if ($result['status']) {
				$data['currencies'][] = array(
					'title'        => $result['title'],
					'code'         => $result['code'],
					'symbol_left'  => $result['symbol_left'],
					'symbol_right' => $result['symbol_right']
				);
			}
		}


		$data['moneymaker2_header_strip_currency'] = $this->config->get('moneymaker2_header_strip_currency');
		$data['moneymaker2_header_strip_currency'] = isset($data['moneymaker2_header_strip_currency']) ? $data['moneymaker2_header_strip_currency'] : 1;
		if ($data['moneymaker2_header_strip_currency']>1) {
			switch ($data['moneymaker2_header_strip_currency']) {
				case 2: $data['moneymaker2_header_strip_currency_class'] = "hidden-lg hidden-md hidden-sm"; break;
				case 3: $data['moneymaker2_header_strip_currency_class'] = "hidden-lg hidden-md hidden-sm visible-xlg"; break;
				case 4: $data['moneymaker2_header_strip_currency_class'] = "hidden-md hidden-sm"; break;
				case 5: $data['moneymaker2_header_strip_currency_class'] = "hidden-sm"; break;
				case 6: $data['moneymaker2_header_strip_currency_class'] = ""; break;
			}
			$moneymaker2_header_strip_currencies = array("usd", "rub", "eur", "btc", "cny", "gbp", "ils", "inr", "jpy", "krw", "rmb", "try", "won", "yen");
			foreach ($data['currencies'] as $currency) {
				if ($currency['code'] == $data['code']) {
					if ($currency['symbol_left']) { $moneymaker2_header_strip_currency_symbol = $currency['symbol_left']; } else { $moneymaker2_header_strip_currency_symbol = $currency['symbol_right']; }
				}
			}
			if (!isset($moneymaker2_header_strip_currency_symbol)) $moneymaker2_header_strip_currency_symbol = "";
			if (in_array(strtolower($data['code']), $moneymaker2_header_strip_currencies)) {
				$data['moneymaker2_header_strip_currency_icon'] = '<i class="fa fa-fw fa-'.strtolower($data['code']).'"></i>';
			} else {
				$data['moneymaker2_header_strip_currency_icon'] = '<i class="fa fa-fw"><small>'.$moneymaker2_header_strip_currency_symbol.'</small></i>';
			}
		}
		
		if (!isset($this->request->get['route'])) {
			$data['redirect'] = $this->url->link('common/home');
		} else {
			$url_data = $this->request->get;

			unset($url_data['_route_']);

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$data['redirect'] = $this->url->link($route, $url, $this->request->server['HTTPS']);
		}

		return $this->load->view('common/currency', $data);
	}

	public function currency() {
		if (isset($this->request->post['code'])) {
			$this->session->data['currency'] = $this->request->post['code'];
		
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
		}
		
		if (isset($this->request->post['redirect'])) {
			$this->response->redirect($this->request->post['redirect']);
		} else {
			$this->response->redirect($this->url->link('common/home'));
		}
	}
}