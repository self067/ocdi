<?php
/*------------------------------------------------------------------------
# Customer Reviews
# ------------------------------------------------------------------------
# The Krotek
# Copyright (C) 2011-2019 The Krotek. All Rights Reserved.
# @license - http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
# Website: https://thekrotek.com
# Support: support@thekrotek.com
-------------------------------------------------------------------------*/

class ModelModuleReviews extends Model
{
    public function getTotalReviews()
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM ".DB_PREFIX."review r LEFT JOIN ".DB_PREFIX."product AS p ON r.product_id = p.product_id LEFT JOIN ".DB_PREFIX."product_to_store AS p2s ON p.product_id = p2s.product_id WHERE p2s.store_id = '".(int)$this->config->get('config_store_id')."' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1'");

        return $query->row['total'];
    }

    public function getReviews($category, $ordering, $available)
    {
        $sql  = "SELECT DISTINCT r.*, pd.name, p.price, p.image FROM ".DB_PREFIX."review r ";
        $sql .= "LEFT JOIN ".DB_PREFIX."product AS p ON r.product_id = p.product_id ";
        $sql .= "LEFT JOIN ".DB_PREFIX."product_description AS pd ON p.product_id = pd.product_id ";
        $sql .= "LEFT JOIN ".DB_PREFIX."product_to_store p2s ON p.product_id = p2s.product_id ";
        $sql .= "LEFT JOIN ".DB_PREFIX."product_to_category p2c ON p.product_id = p2c.product_id ";
		$sql .= "WHERE p2s.store_id = '".(int)$this->config->get('config_store_id')."' AND p.date_available <= NOW() ";
		$sql .= "AND p.status = '1' AND r.status = '1' AND pd.language_id = '".(int)$this->config->get('config_language_id')."' ";
		$sql .= ($category ? "AND p2c.category_id = '".(int)$category."'" : "").($available ? "AND p.quantity > 0" : "");
        $sql .= " ORDER BY ".($ordering == 'random' ? "RAND()" : "date_added ".$ordering);

        $query = $this->db->query($sql);

        return $query->rows;
    }
}

?>