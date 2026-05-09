<?php
class ModelExtensionModuleOptionsImage extends Model {
	public function createColumns() {
		// Option Value Product Image
		$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_option_value");
		$option_product_image = false;

		if ($query->rows) {
			foreach ($query->rows as $row) {
				if ($row['Field'] == 'product_image') {
					$option_product_image = true;
				}
			}
			
			if (!$option_product_image) {
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value`  ADD `product_image` varchar(255) DEFAULT NULL;");
			}
		}
	}
}