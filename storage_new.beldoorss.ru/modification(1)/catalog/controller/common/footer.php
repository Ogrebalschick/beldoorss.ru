<?php
class ControllerCommonFooter extends Controller {

		/*mmr*/
		public function addCallback() {
			$this->load->language('extension/module/moneymaker2');
			$data = array();
			$json = array();
			if (!isset($this->request->post['quickorderphone'])||!$this->request->post['quickorderphone']) {
				$json['error']['validation'] = $this->language->get('error_quickorder_phone');
			}
			if (!$json) {
				$data['telephone'] = (string)$this->request->post['quickorderphone'];
				if (isset($this->request->post['quickordername'])||$this->request->post['quickordername']) {
					$data['telephone'] .= " (" . (string)$this->request->post['quickordername'] . ")";
				}
				$data['comment'] = (string)$this->request->post['quickordercomment'];
				$subject = $this->config->get('config_name') . " - " . $this->language->get('text_callback_mail_subject') . " (" . date('Y.m.d H:i') . ")";
				$message  = $this->language->get('text_callback_mail_message') . "\n\n";
				$message .= $this->language->get('text_quickorder_phone') . ": " . $data['telephone'] . "\n";
				$message .= $this->language->get('text_quickorder_comment') . ": " . $data['comment'] . "\n\n";
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
				$mail->smtp_username = $this->config->get('config_mail_smtp_username');
				$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
				$mail->smtp_port = $this->config->get('config_mail_smtp_port');
				$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
				$mail->setTo($this->config->get('moneymaker2_modules_callback_recipient'));
				$mail->setFrom($this->config->get('moneymaker2_modules_callback_sender'));
				$mail->setSender($this->language->get('text_callback_mail_subject'));
				$mail->setSubject($subject);
				$mail->setText($message);
				$mail->send();
				$json['success'] = sprintf($this->language->get('text_callback_mail_success'), date('Y.m.d H:i'));
			}
			$this->response->setOutput(json_encode($json));
		}
		public function addSubscriber() {
			$this->load->language('extension/module/moneymaker2');
			$data = array();
			$json = array();
			$this->load->model('account/customer');
			if (!isset($this->request->post['quickorderemail'])||!$this->request->post['quickorderemail']||!filter_var($this->request->post['quickorderemail'], FILTER_VALIDATE_EMAIL)) {
				$json['error']['validation'] = $this->language->get('error_quickorder_email');
			}
			if (!$json) {
				$data['email'] = (string)$this->request->post['quickorderemail'];
				$customer = $this->model_account_customer->getCustomerByEmail($data['email']);
				if(empty($customer)) {
					$data['telephone'] = '';
					if (isset($this->request->post['quickordername'])&&$this->request->post['quickordername']) {
						$data['firstname'] = (string)$this->request->post['quickordername'];
					} else {
						$data['firstname'] = $this->language->get('text_newsletter_subscriber');
					}
					$data['lastname'] = '';
					$data['fax'] ='';
					$data['password'] = '';
					$data['company'] =  '';
					$data['address_1'] =  '';
					$data['address_2'] ='';
					$data['tax_id'] = '';
					$data['postcode'] = '';
					$data['country_id'] = $this->config->get('config_country_id');
					$data['company_id']= '';
					$data['zone_id'] = '';
					$data['approval'] = '1';
					$data['newsletter'] = '1';
					$data['city'] =  '';
					$this->model_account_customer->addCustomer($data);
					$this->load->language('mail/forgotten');
					$code = token(40);
					$this->model_account_customer->editCode($data['email'], $code);
					$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$message  = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
					$message .= $this->language->get('text_change') . "\n\n";
					$message .= $this->url->link('account/reset', 'code=' . $code, true) . "\n\n";
					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
					$mail->smtp_username = $this->config->get('config_mail_smtp_username');
					$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
					$mail->smtp_port = $this->config->get('config_mail_smtp_port');
					$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
					$mail->setTo($data['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
					$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
					$mail->send();
					$json['success'] = $this->language->get('text_newsletter_new_sub_success_message');
				} else {
					if ($this->customer->isLogged()) {
						$this->model_account_customer->editNewsletter("1");
						$json['success'] = $this->language->get('text_newsletter_existing_sub_success_message');
					} else {
						$json['error']['validation'] = sprintf($this->language->get('error_newsletter_existing_sub_not_logged'), $this->url->link('account/newsletter', '', true));
					}
				}
			}
			$this->response->setOutput(json_encode($json));
		}
		/*mmr*/
		

		/*mmr*/
		public function addquickorder() {
			$this->load->language('extension/module/moneymaker2');
			$this->load->language('checkout/cart');
			$data = array();
			$json = array();
			if (isset($this->request->post['product_id'])) {
				$product_id = (int)$this->request->post['product_id'];
				$this->load->model('account/customer');
				$this->load->model('catalog/product');
				$product_info = $this->model_catalog_product->getProduct($product_id);
			} else {
				$product_id = 0;
				$json['error']['validation'] = $this->language->get('error_quickorder_product_undefined');
			}
			if (isset($this->request->post['quantity']) && (int)$this->request->post['product_id'] && ((int)$this->request->post['quantity'] > $product_info['quantity']) && !$this->config->get('config_stock_checkout')) {
				$json['error']['validation'] = $this->language->get('error_quickorder_product_quantity');
			}
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$json['error']['validation'] = sprintf($this->language->get('error_minimum'), $product_info['name'], $product_info['minimum']);
			}
			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}
			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);
			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
					$json['error']['validation'] = $this->language->get('error_quickorder_product_options');
				}
			}
			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}
			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);
			if ($recurrings) {
				$recurring_ids = array();
				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}
				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}
			if (!isset($this->request->post['quickorderphone'])||!$this->request->post['quickorderphone']) {
				$json['error']['validation'] = $this->language->get('error_quickorder_phone');
			}
			if (!isset($this->request->post['quickorderemail'])||!$this->request->post['quickorderemail']||!filter_var($this->request->post['quickorderemail'], FILTER_VALIDATE_EMAIL)) {
				$json['error']['validation'] = $this->language->get('error_quickorder_email');
			}
			if ($this->config->get('config_sms_alert')&&(!$this->config->get('config_sms_to')&&!$this->config->get('config_sms_from')&&!$this->config->get('config_sms_gate_username')&&!$this->config->get('config_sms_gate_password'))) {
				$json['error']['validation'] = $this->language->get('error_quickorder_sms');
			}
			if (!$json) {
				if ((int)$this->request->post['product_id']) {
					$this->cart->add($product_id, $quantity, $option, $recurring_id);
				}
				$data['email'] = (string)$this->request->post['quickorderemail'];
				$data['telephone'] = (string)$this->request->post['quickorderphone'];
				$customer = $this->model_account_customer->getCustomerByEmail($data['email']);
				if(empty($customer)) {
					if (isset($this->request->post['quickordername'])&&$this->request->post['quickordername']) {
						$data['firstname'] = (string)$this->request->post['quickordername'];
					} else {
						$data['firstname'] = $this->language->get('text_quickorder');
					}
					$data['lastname'] = (string)$this->request->post['quickorderphone'];
					$data['fax'] ='';
					$data['password'] = '';
					$data['company'] =  $this->language->get('text_quickorder');
					$data['address_1'] =  $this->language->get('text_quickorder');
					$data['address_2'] ='';
					$data['tax_id'] = '';
					$data['postcode'] = '';
					$data['country_id'] = $this->config->get('config_country_id');
					$data['company_id']= '';
					$data['zone_id'] = '';
					$data['approval'] = '1';
					$data['city'] =  $this->language->get('text_quickorder');
					$this->model_account_customer->addCustomer($data);
					$this->load->language('mail/forgotten');
					$code = token(40);
					$this->model_account_customer->editCode($data['email'], $code);
					$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$message  = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
					$message .= $this->language->get('text_change') . "\n\n";
					$message .= $this->url->link('account/reset', 'code=' . $code, true) . "\n\n";
					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
					$mail->smtp_username = $this->config->get('config_mail_smtp_username');
					$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
					$mail->smtp_port = $this->config->get('config_mail_smtp_port');
					$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
					$mail->setTo($data['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
					$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
					$mail->send();
				}
				$customer = $this->model_account_customer->getCustomerByEmail($data['email']);
				$this->load->model('extension/extension');
				$totals = array();
				$taxes = $this->cart->getTaxes();
				$total = 0;
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);
				$sort_order = array();
				$results = $this->model_extension_extension->getExtensions('total');
				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}
				array_multisort($sort_order, SORT_ASC, $results);
				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}
				$sort_order = array();
				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $totals);
				$data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
				$data['store_id'] = $this->config->get('config_store_id');
				$data['store_name'] = $this->config->get('config_name');
				if ($data['store_id']) {
					$data['store_url'] = $this->config->get('config_url');
				} else {
					$data['store_url'] = HTTP_SERVER;
				}
				if ($this->customer->isLogged()) {
					$data['customer_id'] = $this->customer->getId();
					$data['customer_group_id'] = $this->config->get('config_customer_group_id');
					if (isset($this->request->post['quickordername'])) {
						$data['firstname'] = (string)$this->request->post['quickordername'];
					} else {
						$data['firstname'] = $this->customer->getFirstName();
					}
					$data['lastname'] = $this->customer->getLastName();
					$data['telephone'] = (string)$this->request->post['quickorderphone'];
					$data['fax'] = $this->customer->getFax();
				} else {
					$data['customer_id'] = $customer['customer_id'];
					$data['customer_group_id'] = $customer['customer_group_id'];
					if (isset($this->request->post['quickordername'])&&$this->request->post['quickordername']) {
						$data['firstname'] = (string)$this->request->post['quickordername'];
					} else {
						$data['firstname'] = $customer['firstname'];
					}
					$data['lastname'] = (string)$this->request->post['quickorderphone'];
					$data['telephone'] = (string)$this->request->post['quickorderphone'];
					$data['fax'] = $customer['fax'];
				}
				$data['payment_firstname'] = $data['firstname'];
				$data['payment_lastname'] = '';
				$data['payment_company'] = '';
				$data['payment_company_id'] = '';
				$data['payment_tax_id'] = '';
				$data['payment_address_1'] = '';
				$data['payment_address_2'] = '';
				$data['payment_city'] = '';
				$data['payment_postcode'] = '';
				$data['payment_zone'] = '';
				$data['payment_zone_id'] = '';
				$data['payment_country'] = '';
				$data['payment_country_id'] = '';
				$data['payment_address_format'] = '';
				$data['payment_method'] = '';
				$data['payment_code'] = 'cod'; /*correct order preview*/
				$data['shipping_firstname'] = $data['firstname'];
				$data['shipping_lastname'] = '';
				$data['shipping_company'] = '';
				$data['shipping_address_1'] = '';
				$data['shipping_address_2'] = '';
				$data['shipping_city'] = '';
				$data['shipping_postcode'] = '';
				$data['shipping_zone'] = '';
				$data['shipping_zone_id'] = '';
				$data['shipping_country'] = '';
				$data['shipping_country_id'] = '';
				$data['shipping_address_format'] = '';
				$data['shipping_method'] = '';
				$data['shipping_code'] = '';
				$product_data = array();
				foreach ($this->cart->getProducts() as $product) {
					$option_data = array();
					foreach ($product['option'] as $option) {
						$option_data[] = array(
							'product_option_id'       => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id'               => $option['option_id'],
							'option_value_id'         => $option['option_value_id'],
							'name'                    => $option['name'],
							'value'                   => $option['value'],
							'type'                    => $option['type']
						);
					}
					$product_data[] = array(
						'product_id' => $product['product_id'],
						'name'       => $product['name'],
						'model'      => $product['model'],
						'option'     => $option_data,
						'download'   => $product['download'],
						'quantity'   => $product['quantity'],
						'subtract'   => $product['subtract'],
						'price'      => $product['price'],
						'total'      => $product['total'],
						'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
						'reward'     => $product['reward']
					);
				}
				$voucher_data = array();
				if (!empty($this->session->data['vouchers'])) {
					foreach ($this->session->data['vouchers'] as $voucher) {
						$voucher_data[] = array(
							'description'      => $voucher['description'],
							'code'             => token(10),
							'to_name'          => $voucher['to_name'],
							'to_email'         => $voucher['to_email'],
							'from_name'        => $voucher['from_name'],
							'from_email'       => $voucher['from_email'],
							'voucher_theme_id' => $voucher['voucher_theme_id'],
							'message'          => $voucher['message'],
							'amount'           => $voucher['amount']
						);
					}
				}
				$data['products'] = $product_data;
				$data['vouchers'] = $voucher_data;
				$data['totals'] = $totals;
				if (isset($this->request->post['quickordercomment'])&&$this->request->post['quickordercomment']) {
					$data['comment'] = (string)$this->request->post['quickordercomment']."\n\r--\n\r".$this->language->get('text_quickorder');
				} else {
					$data['comment'] = $this->language->get('text_quickorder');
				}
				$data['total'] = $total;
				if (isset($this->request->cookie['tracking'])) {
					$data['tracking'] = $this->request->cookie['tracking'];
					$subtotal = $this->cart->getSubTotal();
					$this->load->model('affiliate/affiliate');
					$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
					if ($affiliate_info) {
						$data['affiliate_id'] = $affiliate_info['affiliate_id'];
						$data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
					} else {
						$data['affiliate_id'] = 0;
						$data['commission'] = 0;
					}
					$this->load->model('checkout/marketing');
					$marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);
					if ($marketing_info) {
						$data['marketing_id'] = $marketing_info['marketing_id'];
					} else {
						$data['marketing_id'] = 0;
					}
				} else {
					$data['affiliate_id'] = 0;
					$data['commission'] = 0;
					$data['marketing_id'] = 0;
					$data['tracking'] = '';
				}
				$data['language_id'] = $this->config->get('config_language_id');
				$data['currency_id'] = $this->currency->getId($this->session->data['currency']);
				$data['currency_code'] = $this->session->data['currency'];
				$data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
				$data['ip'] = $this->request->server['REMOTE_ADDR'];
				if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
					$data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
				} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
					$data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
				} else {
					$data['forwarded_ip'] = '';
				}
				if (isset($this->request->server['HTTP_USER_AGENT'])) {
					$data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
				} else {
					$data['user_agent'] = '';
				}
				if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
					$data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
				} else {
					$data['accept_language'] = '';
				}
				$this->load->model('checkout/order');
				$this->session->data['order_id'] = $this->model_checkout_order->addOrder($data);
				$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('config_order_status_id'));
				$json['success'] = sprintf($this->language->get('text_quickorder_success_message'), $this->session->data['order_id']);
				$this->cart->clear();
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
				unset($this->session->data['guest']);
				unset($this->session->data['comment']);
				unset($this->session->data['order_id']);
				unset($this->session->data['coupon']);
				unset($this->session->data['reward']);
				unset($this->session->data['voucher']);
				unset($this->session->data['vouchers']);
				unset($this->session->data['totals']);
				$json['total'] = sprintf($this->language->get('text_items'), 0, $this->currency->format(0, $this->session->data['currency']));
			}
			$this->cart->remove($product_id);
			$this->response->setOutput(json_encode($json));
		}
		/*mmr*/
		
	public function index() {
		$this->load->language('common/footer');

		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}


					//microdatapro 7.0 start - 1 - main
					$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/company');
					$microdatapro_main_flag = 1;
					//microdatapro 7.0 end - 1 - main
					
		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);

		/*mmr*/
		$this->load->language('extension/module/moneymaker2');
		$data['button_submit'] = $this->language->get('button_submit');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['button_shopping'] = $this->language->get('button_shopping');
		$data['button_back'] = $this->language->get('button_back');
		$data['text_compare'] = $this->language->get('text_compare');
		$data['compare'] = $this->url->link('product/compare', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['button_left_panel'] = $this->language->get('button_left_panel');
		$data['button_right_panel'] = $this->language->get('button_right_panel');
		$data['button_show_more_items'] = $this->language->get('button_show_more_items');
		$data['moneymaker2_common_sidebars_responsive'] = $this->config->get('moneymaker2_common_sidebars_responsive');
		$data['moneymaker2_footer_information_hide'] = $this->config->get('moneymaker2_footer_information_hide');
		$data['moneymaker2_footer_customer_hide'] = $this->config->get('moneymaker2_footer_customer_hide');
		$data['moneymaker2_footer_extras_hide'] = $this->config->get('moneymaker2_footer_extras_hide');
		$data['moneymaker2_footer_account_hide'] = $this->config->get('moneymaker2_footer_account_hide');
		$data['moneymaker2_footer_contacts_enabled'] = $this->config->get('moneymaker2_footer_contacts_enabled');
		if ($data['moneymaker2_footer_contacts_enabled']) {
			$data['moneymaker2_footer_contacts_icon'] = $this->config->get('moneymaker2_footer_contacts_icon');
			$data['moneymaker2_footer_contacts_title'] = $this->config->get('moneymaker2_footer_contacts_title');
			$data['moneymaker2_footer_contacts_title'] = isset($data['moneymaker2_footer_contacts_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_footer_contacts_title'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_footer_contacts'] = array();
			$moneymaker2_footer_contacts = $this->config->get('moneymaker2_footer_contacts');
			if (!empty($moneymaker2_footer_contacts)) {
				foreach ($moneymaker2_footer_contacts as $key => $value) {
					$data['moneymaker2_footer_contacts'][] = array(
						'caption' => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
						'link' => $value['link'],
						'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					);
					$moneymaker2_footer_contacts_sort_order[$key] = $value['sort_order'];
				}
				array_multisort($moneymaker2_footer_contacts_sort_order, SORT_ASC, $data['moneymaker2_footer_contacts']);
			}
		}
		$data['moneymaker2_footer_links_enabled'] = $this->config->get('moneymaker2_footer_links_enabled');
		if ($data['moneymaker2_footer_links_enabled']) {
			$data['moneymaker2_footer_links_icon'] = $this->config->get('moneymaker2_footer_links_icon');
			$data['moneymaker2_footer_links_title'] = $this->config->get('moneymaker2_footer_links_title');
			$data['moneymaker2_footer_links_title'] = isset($data['moneymaker2_footer_links_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_footer_links_title'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_footer_links'] = array();
			$moneymaker2_footer_links = $this->config->get('moneymaker2_footer_links');
			if (!empty($moneymaker2_footer_links)) {
				foreach ($moneymaker2_footer_links as $key => $value) {
					$data['moneymaker2_footer_links'][] = array(
						'caption' => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
						'link' => $value['link'],
						'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
					);
					$moneymaker2_footer_links_sort_order[$key] = $value['sort_order'];
				}
				array_multisort($moneymaker2_footer_links_sort_order, SORT_ASC, $data['moneymaker2_footer_links']);
			}
		}
		$data['moneymaker2_footer_text1_enabled'] = $this->config->get('moneymaker2_footer_text1_enabled');
		if ($data['moneymaker2_footer_text1_enabled']) {
			$data['moneymaker2_footer_text1_icon'] = $this->config->get('moneymaker2_footer_text1_icon');
			$data['moneymaker2_footer_text1_title'] = $this->config->get('moneymaker2_footer_text1_title');
			$data['moneymaker2_footer_text1_title'] = isset($data['moneymaker2_footer_text1_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_footer_text1_title'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_footer_text1'] = $this->config->get('moneymaker2_footer_text1');
			$data['moneymaker2_footer_text1'] = isset($data['moneymaker2_footer_text1'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_footer_text1'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		}
		$data['moneymaker2_footer_text2_enabled'] = $this->config->get('moneymaker2_footer_text2_enabled');
		if ($data['moneymaker2_footer_text2_enabled']) {
			$data['moneymaker2_footer_text2_icon'] = $this->config->get('moneymaker2_footer_text2_icon');
			$data['moneymaker2_footer_text2_title'] = $this->config->get('moneymaker2_footer_text2_title');
			$data['moneymaker2_footer_text2_title'] = isset($data['moneymaker2_footer_text2_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_footer_text2_title'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_footer_text2'] = $this->config->get('moneymaker2_footer_text2');
			$data['moneymaker2_footer_text2'] = isset($data['moneymaker2_footer_text2'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_footer_text2'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
		}
		$data['moneymaker2_footer_socials_enabled'] = $this->config->get('moneymaker2_footer_socials_enabled');
		if ($data['moneymaker2_footer_socials_enabled']) {
			$data['moneymaker2_footer_socials_target_blank'] = $this->config->get('moneymaker2_footer_socials_target_blank');
			$data['moneymaker2_footer_socials'] = array();
			$moneymaker2_footer_socials = $this->config->get('moneymaker2_footer_socials');
			if (!empty($moneymaker2_footer_socials)) {
				foreach ($moneymaker2_footer_socials as $key => $value) {
					$data['moneymaker2_footer_socials'][] = array(
						'caption' => isset($value['caption'][$this->config->get('config_language_id')]) ? $value['caption'][$this->config->get('config_language_id')] : null,
						'link' => $value['link'],
						'multilink'  => isset($value['multilink'][$this->config->get('config_language_id')]) ? $value['multilink'][$this->config->get('config_language_id')] : null,
						'icon' => $value['icon'],
					);
					$moneymaker2_footer_socials_sort_order[$key] = $value['sort_order'];
				}
				array_multisort($moneymaker2_footer_socials_sort_order, SORT_ASC, $data['moneymaker2_footer_socials']);
			}
		}
		$data['moneymaker2_footer_copyrights_hide'] = $this->config->get('moneymaker2_footer_copyrights_hide');
		$data['moneymaker2_footer_powered_hide'] = $this->config->get('moneymaker2_footer_powered_hide');
		$data['moneymaker2_footer_powered_custom_enabled'] = $this->config->get('moneymaker2_footer_powered_custom_enabled');
		if ($data['moneymaker2_footer_powered_custom_enabled']) {
			$data['moneymaker2_footer_powered_custom_text'] = $this->config->get('moneymaker2_footer_powered_custom_text');
			$data['moneymaker2_footer_powered_custom_text'] = isset($data['moneymaker2_footer_powered_custom_text'][$this->config->get('config_language_id')]) ? html_entity_decode($data['moneymaker2_footer_powered_custom_text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8') : null;
			$data['moneymaker2_footer_powered_custom_title'] = $this->config->get('moneymaker2_footer_powered_custom_title');
			$data['moneymaker2_footer_powered_custom_title'] = isset($data['moneymaker2_footer_powered_custom_title'][$this->config->get('config_language_id')]) ? $data['moneymaker2_footer_powered_custom_title'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_footer_powered_custom_year'] = $this->config->get('moneymaker2_footer_powered_custom_year');
		}
		$data['moneymaker2_common_dropdown_hover'] = $this->config->get('moneymaker2_common_dropdown_hover');
		if ($data['moneymaker2_common_dropdown_hover']) $this->document->addScript('catalog/view/javascript/jquery/moneymaker2/bootstrap-hover-dropdown.min.js');
		$data['moneymaker2_common_scrolltop'] = $this->config->get('moneymaker2_common_scrolltop');
		$data['moneymaker2_common_scrolltop_text'] = $this->config->get('moneymaker2_common_scrolltop_text');
		$data['moneymaker2_common_scrolltop_text'] = isset($data['moneymaker2_common_scrolltop_text'][$this->config->get('config_language_id')]) ? $data['moneymaker2_common_scrolltop_text'][$this->config->get('config_language_id')] : null;
		$data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
		$data['moneymaker2_modules_callback_enabled'] = $this->config->get('moneymaker2_modules_callback_enabled');
		$data['moneymaker2_modules_newsletter_enabled'] = $this->config->get('moneymaker2_modules_newsletter_enabled');
		if ($data['moneymaker2_modules_quickorder_enabled']||$data['moneymaker2_modules_callback_enabled']||$data['moneymaker2_modules_newsletter_enabled']) {
			$this->document->addScript('catalog/view/javascript/jquery/moneymaker2/jquery.mask.min.js');
			$data['moneymaker2_modules_quickorder_hide_email'] = $this->config->get('moneymaker2_modules_quickorder_hide_email');
			$data['moneymaker2_modules_quickorder_recipient'] = $this->config->get('moneymaker2_modules_quickorder_recipient');
			$data['moneymaker2_modules_quickorder_display_thumb'] = $this->config->get('moneymaker2_modules_quickorder_display_thumb');
			$data['moneymaker2_modules_quickorder_phone_mask_enabled'] = $this->config->get('moneymaker2_modules_quickorder_phone_mask_enabled');
			$data['moneymaker2_modules_quickorder_phone_mask'] = $this->config->get('moneymaker2_modules_quickorder_phone_mask');
			if ($this->customer->isLogged()) {
				$data['moneymaker2_customer_name'] = $this->customer->getFirstName();
				$data['moneymaker2_customer_email'] = $this->customer->getEmail();
			} else {
				$data['moneymaker2_customer_name'] = '';
				$data['moneymaker2_customer_email'] = '';
			}
			$data['text_optional'] = $this->language->get('text_optional');
			$data['text_quickorder_email'] = $this->language->get('text_quickorder_email');
			$data['text_quickorder_phone'] = $this->language->get('text_quickorder_phone');
			$data['text_quickorder_name'] = $this->language->get('text_quickorder_name');
			$data['text_quickorder_comment'] = $this->language->get('text_quickorder_comment');
			$data['text_quickorder_email_help'] = $this->language->get('text_quickorder_email_help');
			$data['text_quickorder_cart_items_help'] = sprintf($this->language->get('text_quickorder_cart_items_help'), $this->url->link('checkout/cart'));
			$data['text_quickorder_help'] = $this->language->get('text_quickorder_help');
			if ($this->config->get('moneymaker2_common_agree_warning')) {
				$this->load->language('affiliate/register');
				$this->load->model('catalog/information');
				$information_info = $this->model_catalog_information->getInformation($this->config->get('moneymaker2_common_agree_warning'));
				if ($information_info) {
					$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('moneymaker2_common_agree_warning'), true), $information_info['title'], $information_info['title']);
					$data['error_agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
				} else {
					$data['text_agree'] = '';
				}
			} else {
				$data['text_agree'] = '';
			}
			$data['text_quickorder_submit'] = $this->language->get('text_quickorder_submit');
			$data['text_callback_submit'] = $this->language->get('text_callback_submit');
			$data['text_callback_help'] = $this->language->get('text_callback_help');
			$data['button_quickorder_success_message'] = $this->language->get('button_quickorder_success_message');
			$data['button_callback_success_message'] = $this->language->get('button_callback_success_message');
			$data['error_quickorder_email'] = $this->language->get('error_quickorder_email');
			$data['error_quickorder_phone'] = $this->language->get('error_quickorder_phone');
			if (isset($this->request->get['route'])&&strpos($this->request->get['route'], 'checkout') !== false) {
				$data['moneymaker2_modules_quickorder_checkout_page'] = true;
			} else {
				$data['moneymaker2_modules_quickorder_checkout_page'] = false;
			};
			$this->load->model('tool/image');
			$data['moneymaker2_modules_newsletter_header'] = $this->config->get('moneymaker2_modules_newsletter_header');
			$data['moneymaker2_modules_newsletter_header'] = isset($data['moneymaker2_modules_newsletter_header'][$this->config->get('config_language_id')]) ? $data['moneymaker2_modules_newsletter_header'][$this->config->get('config_language_id')] : null;
			$data['moneymaker2_modules_newsletter_caption'] = $this->config->get('moneymaker2_modules_newsletter_caption');
			$data['moneymaker2_modules_newsletter_caption'] = isset($data['moneymaker2_modules_newsletter_caption'][$this->config->get('config_language_id')]) ? trim(preg_replace('/\s+/', ' ', html_entity_decode($data['moneymaker2_modules_newsletter_caption'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'))) : null;

			$data['moneymaker2_modules_newsletter_image'] = $this->config->get('moneymaker2_modules_newsletter_image');
			if ($data['moneymaker2_modules_newsletter_image']) {
				$moneymaker2_modules_newsletter_image = is_file(DIR_IMAGE . $this->config->get('moneymaker2_modules_newsletter_image_src')) ? $this->model_tool_image->resize($this->config->get('moneymaker2_modules_newsletter_image_src'), $this->config->get('moneymaker2_modules_newsletter_thumbs_width') ? $this->config->get('moneymaker2_modules_newsletter_thumbs_width') : 228, $this->config->get('moneymaker2_modules_newsletter_thumbs_height') ? $this->config->get('moneymaker2_modules_newsletter_thumbs_height') : 228) : $this->model_tool_image->resize('no_image.png', $this->config->get('moneymaker2_modules_newsletter_thumbs_width') ? $this->config->get('moneymaker2_modules_newsletter_thumbs_width') : 228, $this->config->get('moneymaker2_modules_newsletter_thumbs_height') ? $this->config->get('moneymaker2_modules_newsletter_thumbs_height') : 228);
				$data['moneymaker2_modules_newsletter_image'] = $moneymaker2_modules_newsletter_image;
			}
			$data['text_newsletter_submit'] = $this->language->get('text_newsletter_submit');
			$data['text_newsletter_help'] = $this->language->get('text_newsletter_help');
			$data['button_newsletter_success_message'] = $this->language->get('button_newsletter_success_message');
		}
		$data['moneymaker2_modules_popup'] = $this->config->get('moneymaker2_modules_popup');
		$data['moneymaker2_header_alert'] = $this->config->get('moneymaker2_header_alert');
		if ($data['moneymaker2_modules_popup']||$data['moneymaker2_header_alert']) {
			$this->document->addScript('catalog/view/javascript/jquery/moneymaker2/js.cookie.js');
		}
		if ($data['moneymaker2_modules_popup']) {
			$data['moneymaker2_modules_popup_link'] = $this->config->get('moneymaker2_modules_popup_link');
			if ($data['moneymaker2_modules_popup_link']!='newsletter') {
				$this->load->model('catalog/information');
				$information_info = $this->model_catalog_information->getInformation($data['moneymaker2_modules_popup_link']);
				$data['moneymaker2_modules_popup_title'] = isset($information_info['title']) ? $information_info['title'] : '';
			} else if (($data['moneymaker2_modules_popup_link']=='newsletter')&&(!$data['moneymaker2_modules_newsletter_enabled'])) {
				$data['moneymaker2_modules_popup_link'] = null;
			}
			$data['moneymaker2_modules_popup_limit'] = $this->config->get('moneymaker2_modules_popup_limit');
			$data['moneymaker2_modules_popup_delay'] = $this->config->get('moneymaker2_modules_popup_delay')."000";
		}
		if ($data['moneymaker2_header_alert']) {
			$data['moneymaker2_header_alert_text'] = $this->config->get('moneymaker2_header_alert_text');
			$data['moneymaker2_header_alert_text'] = isset($data['moneymaker2_header_alert_text'][$this->config->get('config_language_id')]) ? trim(preg_replace('/\s+/', ' ', html_entity_decode($data['moneymaker2_header_alert_text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'))) : null;
		}
		$data['moneymaker2_modules_quickorder_goal_google'] = $this->config->get('moneymaker2_modules_quickorder_goal_google');
		$data['moneymaker2_modules_quickorder_goal_google_gtag'] = $this->config->get('moneymaker2_modules_quickorder_goal_google_gtag');
		$data['moneymaker2_modules_quickorder_goal_yandex'] = $this->config->get('moneymaker2_modules_quickorder_goal_yandex');
		$data['moneymaker2_modules_quickorder_goal_yandex_counter'] = $this->config->get('moneymaker2_modules_quickorder_goal_yandex_counter');
		$data['moneymaker2_modules_callback_goal_google'] = $this->config->get('moneymaker2_modules_callback_goal_google');
		$data['moneymaker2_modules_callback_goal_google_gtag'] = $this->config->get('moneymaker2_modules_callback_goal_google_gtag');
		$data['moneymaker2_modules_callback_goal_yandex'] = $this->config->get('moneymaker2_modules_callback_goal_yandex');
		$data['moneymaker2_modules_callback_goal_yandex_counter'] = $this->config->get('moneymaker2_modules_callback_goal_yandex_counter');
		/*mmr*/
		


					//microdatapro 7.0 start - 2 - extra
					if(!isset($microdatapro_main_flag)){
						$data['microdatapro'] = $this->load->controller('extension/module/microdatapro/company');
					}
					//microdatapro 7.0 end - 2 - extra
					
		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		return $this->load->view('common/footer', $data);
	}
}
