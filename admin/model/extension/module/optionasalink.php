<?php

class ModelExtensionModuleoptionasalink extends Model
{
    
    public function install()
    {
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value` ADD `link` int(11) NULL");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value` ADD `checked` int(11) NULL");
    }
    
    public function uninstall()
    {
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value` DROP `link` ");
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "product_option_value` DROP `checked` ");
    }   
}