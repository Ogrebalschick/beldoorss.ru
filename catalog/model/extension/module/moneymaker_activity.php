<?php
class ModelExtensionModuleMoneymakerActivity extends Model {
	public function getActivities() {
		$query = $this->db->query("SELECT a.key, a.data, a.date_added FROM ((SELECT CONCAT('customer_', ca.key) AS `key`, ca.data, ca.date_added FROM `" . DB_PREFIX . "customer_activity` ca) UNION (SELECT CONCAT('affiliate_', aa.key) AS `key`, aa.data, aa.date_added FROM `" . DB_PREFIX . "affiliate_activity` aa)) a ORDER BY a.date_added DESC LIMIT 0,10");
		return $query->rows;
	}
	public function getAddress($customer_id) {
		$new_address_id = $this->db->query("SELECT address_id FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
		if ($new_address_id->num_rows) {
			$address_query = $this->db->query("SELECT city FROM " . DB_PREFIX . "address WHERE address_id = '" . (int)$new_address_id->row['address_id'] . "'");
			if ($address_query->num_rows) {
				return array(
					'city'           => $address_query->row['city'],
				);
			}
		}
	}
	public function getOrderProducts($order_id) {
		$query = $this->db->query("SELECT product_id, name FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
		return $query->rows;
	}
}