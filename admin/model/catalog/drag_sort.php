<?php
class ModelCatalogDragSort extends Model {

    public function updateAttributeSort($attributes) {
        foreach ($attributes as $attribute_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "attribute SET sort_order = '" . $sort_order . "' WHERE attribute_id = '" . (int)$attribute_id . "'");
        }
    }

    public function updateAttributeGroupSort($attribute_groups) {
        foreach ($attribute_groups as $attribute_group_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "attribute_group SET sort_order = '" . $sort_order . "' WHERE attribute_group_id = '" . (int)$attribute_group_id . "'");
        }
    }

    public function updateOptionSort($options) {
        foreach ($options as $option_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "option SET sort_order = '" . $sort_order . "' WHERE option_id = '" . (int)$option_id . "'");
        }
    }

    public function updateInformationSort($informations) {
        foreach ($informations as $information_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "information SET sort_order = '" . $sort_order . "' WHERE information_id = '" . (int)$information_id . "'");
        }
    }

    public function updateManufacturerSort($manufacturers) {
        foreach ($manufacturers as $manufacturer_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "manufacturer SET sort_order = '" . $sort_order . "' WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
        }
    }

    public function updateCategorySort($categories) {
        foreach ($categories as $category_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_order = '" . $sort_order . "' WHERE category_id = '" . (int)$category_id . "'");
        }
    }

    public function updateProductSort($products) {
        foreach ($products as $product_id => $sort_order) {
            $this->db->query("UPDATE " . DB_PREFIX . "product SET sort_order = '" . $sort_order . "' WHERE product_id = '" . (int)$product_id . "'");
        }
    }

    public function getCategoriesByParentId($parent_id = 0) {
        $query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name");

        return $query->rows;
    }

    public function getTotalCategoriesByParentId($parent_id = 0) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category WHERE parent_id = '" . $parent_id . "'");

        return $query->row['total'];
    }

    public function makeOrderInProducts() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "product SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInManufacturers() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "manufacturer SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInAttributes() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "attribute SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInAttributeGroups() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "attribute_group SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInOptions() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "option SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInInformations() {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "information SET sort_order = (@i := @i+1) ORDER BY sort_order");
    }

    public function makeOrderInCategories($category_id) {
        $this->db->query("SELECT @i := -1");
        $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_order = (@i := @i+1) WHERE parent_id = '" . $category_id . "' ORDER BY sort_order");
    }
}
