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

class ControllerModuleReviews extends Controller
{
	private $folder = "module";
	private $extension = "reviews";
	private $params = array();
	
	public function __construct($registry)
	{
		parent::__construct($registry);
		
		$this->language->load($this->folder.'/'.$this->extension);
		
		$this->fieldbase = (version_compare(VERSION, '3.0', '>=') ? $this->folder.'_' : '').$this->extension;
	}
			
    public function index($setting)
    {
    	$this->params = $setting;
    	
        $this->language->load($this->folder.'/'.$this->extension);
        $this->load->model($this->folder.'/'.$this->extension);
			
		// Customer group check	
		
		$group = $this->customer->getGroupId();
		$customer_groups = $this->getOption('customer_groups', array());
		
		if (!empty($customer_groups) && !in_array($group, $customer_groups)) {
			return false;
		}

		// Check store
		
		$stores = $this->getOption('stores', array());
		
		if (!empty($stores) && !in_array($this->config->get('config_store_id'), $stores)) return false;
		
		$data['extension'] = $this->extension;
        $data['heading_title'] = $this->language->get($this->extension.'_heading');

		$total = $this->{'model_'.$this->folder.'_'.$this->extension}->getTotalReviews();

		if ($this->getOption('total')) {
			$data['heading_title'] .= sprintf($this->language->get($this->extension.'_total'), $total);
		}
			
		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$data['products'] = array();

        if ($this->getOption('sensitive') && !empty($this->request->get['path'])) {
            $path = explode('_', $this->request->get['path']);
            $category = (int) array_pop($path);
        } else {
            $category = 0;
        }
        
		$results = $this->{'model_'.$this->folder.'_'.$this->extension}->getReviews($category, $this->getOption('ordering', 'random'), $this->getOption('available'));

		if ($results) {
			if ($this->getOption('shuffle')) shuffle($results);
			
			$results = array_slice($results, 0, $this->getOption('limit', 4));
						
        	$this->load->model('catalog/product');
        	$this->load->model('catalog/category');
        	$this->load->model('tool/image');

        	foreach ($results as $result) {
				$product = $this->model_catalog_product->getProduct($result['product_id']);
               
				if ($product['image']) {
					if (version_compare(VERSION, '2.2', '<')) {
						$image_width = $this->config->get('config_image_thumb_width');
						$image_height = $this->config->get('config_image_thumb_height');
					} else {
						$image_width = $this->config->get((version_compare(VERSION, '3.0', '>=') ? 'theme_' : '').$this->config->get('config_theme').'_image_thumb_width');
						$image_height = $this->config->get((version_compare(VERSION, '3.0', '>=') ? 'theme_' : '').$this->config->get('config_theme').'_image_thumb_height');
					}
											
            		$image = $this->model_tool_image->resize($product['image'], $this->getOption('width', $image_width), $this->getOption('height', $image_height));
				} else {
					$image = "";
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $this->getCurrentCurrency());
				} else {
					$price = false;
				}

				if ((float)$product['special']) {
					$special = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')), $this->getCurrentCurrency());
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$product['special'] ? $product['special'] : $product['price'], $this->getCurrentCurrency());
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}
				
				$product['description'] = strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8'));
				
				if (!empty($product['description'])) {
					if (version_compare(VERSION, '2.2', '<')) {
						$characters = $this->config->get('config_product_description_length');
					} else {
						$characters = $this->config->get((version_compare(VERSION, '3.0', '>=') ? 'theme_' : '').$this->config->get('config_theme').'_product_description_length');
					}
				
					if (mb_strlen($product['description']) > $characters) {
						$product['description'] = mb_substr($product['description'], 0, $characters).'...';
					}
				}
				
				$result['text'] = strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8'));
				
				$characters = $this->getOption('characters', 200);
				
				if (mb_strlen($result['text']) > $characters) {
					$result['text'] = mb_substr($result['text'], 0, $characters).'...';
				}
				
            	$data['products'][] = array(
	                'review_id'   	=> $result['review_id'],
        	        'review_author' => $result['author'],
            	    'review_text'	=> $result['text'],
                	'review_date'	=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
	                'href'      	=> $this->url->link('product/product', 'product_id='.$product['product_id']),
    	            'product_id'	=> $product['product_id'],
            	    'name'   		=> $product['name'],
            	    'category' 		=> $category,
					'description' 	=> $product['description'],
					'thumb'			=> $image,
					'rating'      	=> $rating,
					'price'       	=> $price,
					'special'     	=> $special,
					'tax'         	=> $tax);                
        	}
        } else {
        	 return "";
        }

		$tpl = $this->folder."/".$this->extension;

		if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/'.$tpl.'.tpl')) {
			$data['template'] = $this->config->get('config_template');
		} else {
			$data['template'] = "default";
		}

		$template = version_compare(VERSION, '2.2', '<') ? $data['template'].'/template/'.$tpl.'.tpl' : $tpl;
		
		return $this->load->view($template, $data);       
    }
			
	private function getOption($option, $default = "")
	{
		if (isset($this->params[$this->fieldbase.'_'.$option])) {
			$value = $this->params[$this->fieldbase.'_'.$option];
			if (!is_numeric($value) && is_numeric($default)) $value = $default;
		} else {
			$value = $default;
		}
		
		return $value;
	}
			
	private function getCurrentCurrency()
	{	
		$code = "";
		
		$this->load->model('localisation/currency');
		$currencies = $this->model_localisation_currency->getCurrencies();
		
		if (isset($this->session->data['currency'])) {
			$code = $this->session->data['currency'];
		}
		
		if (isset($this->request->cookie['currency']) && !array_key_exists($code, $currencies)) {
			$code = $this->request->cookie['currency'];
		}
		
		if (!array_key_exists($code, $currencies)) {
			$code = $this->config->get('config_currency');
		}
		
		return $code;
	}    
}

?>