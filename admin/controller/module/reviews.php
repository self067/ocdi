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
	private $module = true;
	private $folder = "module";
	private $extension = "reviews";
	private $product_id = '447';
	private $path = '';
	private $fieldbase = '';
	private $token = '';
	private $error = array();	
	private $options = array(
		'debug' => 'radio',
		'version' => 'radio',			
		'stores' => 'checkbox',		
		'customer_groups' => 'checkbox',
		'tax_class' => 'select',
		'geo_zone' => 'checkbox',
		'status' => 'select',
		'sort_order' => 'text');
	
	public function __construct($registry)
	{
		parent::__construct($registry);
		
		$this->language->load($this->folder.'/'.$this->extension);
		
		if (version_compare(VERSION, '2.3', '>=')) $this->path = 'extension/';
		
		$this->fieldbase = (version_compare(VERSION, '3.0', '>=') ? $this->folder.'_' : '').$this->extension;
		$this->token = version_compare(VERSION, '3', '>=') ? $this->session->data['user_token'] : $this->session->data['token'];
	}
		
	public function index()
	{
    	$data['folder'] = $this->folder;
		$data['extension'] = $this->extension;
		$data['token'] = $this->token;
		$data['urlquery'] = (version_compare(VERSION, '3', '>=') ? 'user_token=' : 'token=').$data['token'];
		$data['extensions'] = array('dashboard', 'feed', 'module', 'payment', 'shipping', 'total');
		
		$data['fieldbase'] = $this->fieldbase;
		
		$data['path'] = $this->path;
		
		if ((strpos($this->request->get['route'], 'uninstall') !== false) || (strpos($this->request->get['route'], 'install') !== false)) return;				
		
		if (file_exists(DIR_APPLICATION.'model/'.$this->folder.'/'.$this->extension.'.php')) {
			$this->load->model($this->folder.'/'.$this->extension);
		}
				
		$data['heading_title'] = $this->language->get('heading_title');
		
		$this->document->setTitle($data['heading_title']);
		
		$this->load->model('setting/setting');
		
		if (!isset($this->session->data['errors'])) {
			$this->session->data['errors'] = array();
		}		
		
		if ($this->module) {
			if (version_compare(VERSION, '3.0', '>=')) {
				$this->load->model('setting/module');
				$module_model = 'model_setting_module';				
			} else {				
				$this->load->model('extension/module');
				$module_model = 'model_extension_module';
			}
						
			$module_id = isset($this->request->get['module_id']) ? $this->request->get['module_id'] : 0;
		}

		if (!empty($module_id) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->{$module_model}->getModule($module_id);
		}
	
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (method_exists($this, 'preSave')) {
				$this->preSave($this->request->post, $data);
			}
			
			if ($this->module) {
				$this->request->post['name'] = $this->request->post[$this->fieldbase.'_name'];
				$this->request->post['status'] = $this->request->post[$this->fieldbase.'_status'];
					
				if (!empty($module_id)) {
					$this->{$module_model}->editModule($module_id, $this->request->post);
				} else {
					$this->{$module_model}->addModule($this->extension, $this->request->post);
					
					$query = $this->db->query("SELECT MAX(module_id) AS id FROM `".DB_PREFIX."module` WHERE code = '".$this->extension."'");
					$module_id = $query->row['id'];
				}
			} else {
				$this->model_setting_setting->editSetting($this->fieldbase, $this->request->post);
			}
			
			if (empty($this->session->data['success'])) {
				$this->session->data['success'] = sprintf($this->language->get('message_success'), $data['heading_title']);
			}

			if (method_exists($this, 'postSave')) {
				$this->postSave($this->request->post, $data);
			}
			
			$route = $this->folder.'/'.$this->extension;
			$url = $data['urlquery'];
				
			if ($this->request->post['apply']) {				
				if (in_array($this->folder, $data['extensions'])) $route = $this->path.$route;
				$url .= (!empty($module_id) ? '&module_id='.$module_id : '');
			} else {
				if (in_array($this->folder, $data['extensions'])) {
					if (version_compare(VERSION, '2.3', '<')) $route = 'extension/'.$this->folder;
					else $route = (version_compare(VERSION, '3', '>=') ? 'marketplace' : 'extension').'/extension';
				}
				
				$url .= (version_compare(VERSION, '3', '>=') ? '&type='.$this->folder : '');
			}
			
			$this->response->redirect($this->url->link($route, $url, true));
		}
		
		if (isset($this->session->data['success'])) $data['success'] = $this->session->data['success'];
		else $data['success'] = '';
		
		$this->session->data['success'] = '';
		
		$check_version = !empty($module_info) && isset($module_info[$this->fieldbase.'_version']) ? $module_info[$this->fieldbase.'_version'] : $this->config->get($this->fieldbase.'_version');
		
		if ($check_version) {
			$latest = $this->checkVersion($this->product_id);
			
			if (empty($latest['error'])) {
				$current = $this->language->get('heading_version');
				
				if (version_compare($current, $latest['version'], '=')) {
					$version = sprintf($this->language->get('heading_latest'), $latest['version']);
					$class = 'latest';
					$icon = 'check-circle';
				} elseif (version_compare($current, $latest['version'], '>')) {
					$version = sprintf($this->language->get('heading_future'), $current);
					$class = 'future';
					$icon = 'rocket';
				} else {
					$version = sprintf($this->language->get('heading_update'), $latest['version']);
					$class = 'update';
					$icon = 'exclamation-circle';
				}
			} else {
				$version = !empty($latest['error']) ? $latest['error'] : $this->language->get('error_version_data');
				$class = 'error';
				$icon = 'exclamation-triangle';
			}
		} else {
			$version = $this->language->get('error_version_disabled');
			$class = 'error';
			$icon = 'exclamation-triangle';
		}
			
		$data['version'] = "<span class='version ".$class."'><i class='fa fa-".$icon."'> </i> ".$version."</span>";
		
		$data['text_edit'] = sprintf($this->language->get('text_edit_title'), $data['heading_title']);
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$data['text_remove_all'] = $this->language->get('text_remove_all');
		$data['text_rules_empty'] = $this->language->get('text_rules_empty');		
		
		$data['breadcrumbs'] = array();
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', $data['urlquery'], true));
		
		$route = $this->folder.'/'.$this->extension;
			
		if (in_array($this->folder, $data['extensions'])) $route = $this->path.$route;
				
		if (version_compare(VERSION, '2.3', '<')) {
			if (in_array($this->folder, $data['extensions'])) {
				$data['breadcrumbs'][] = array(
					'text' => $this->language->get('text_'.$this->folder),
					'href' => $this->url->link('extension/'.$this->folder, $data['urlquery'], true));
			}

			$data['maincancel'] = $this->url->link('extension/'.$this->folder, $data['urlquery'], 'SSL');
		} else {
			if (in_array($this->folder, $data['extensions'])) {
				$data['breadcrumbs'][] = array(
					'text' => $this->language->get('text_extension'),
					'href' => $this->url->link((version_compare(VERSION, '3', '>=') ? 'marketplace' : 'extension').'/extension', $data['urlquery'] . '&type='.$this->folder, true));
			}
			
			$data['maincancel'] = $this->url->link((version_compare(VERSION, '3', '>=') ? 'marketplace' : 'extension').'/extension', $data['urlquery'].'&type='.$this->folder, true);
		}
						
		$data['breadcrumbs'][] = array(
			'text' => $data['heading_title'],
			'href' => $this->url->link($route, $data['urlquery'].(!empty($module_id) ? '&module_id='.$module_id : ''), true));
			
		$data['mainaction'] = $this->url->link($route, $data['urlquery'].(!empty($module_id) ? '&module_id='.$module_id : ''), true);
			
		$data['button_save'] = $this->language->get('button_save');
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_help'] = $this->language->get('button_help');		
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['buttons'] = array(
			array('id' => 'save', 'title' => $this->language->get('button_save'), 'class' => 'btn-primary', 'icon' => 'save'),
			array('id' => 'apply', 'title' => $this->language->get('button_apply'), 'class' => 'btn-success', 'icon' => 'check'),
			array('id' => 'cancel', 'href' => $data['maincancel'], 'title' => $this->language->get('button_cancel'), 'class' => 'btn-default', 'icon' => 'reply'));

		$this->load->model('setting/store');		
		$stores = $this->model_setting_store->getStores();
		
		$data['stores'] = array(0 => array('0', $this->config->get('config_name')));
		
		foreach ($stores as $store) {
			$data['stores'][] = array($store['store_id'], $store['name']);
		}
				
		if (version_compare(VERSION, '2.1', '<')) {
			$this->load->model('sale/customer_group');
			$groupmodel = 'model_sale_customer_group';
		} else {
			$this->load->model('customer/customer_group');
			$groupmodel = 'model_customer_customer_group';
		}
		
		$customer_groups = $this->{$groupmodel}->getCustomerGroups();
		
		foreach ($customer_groups as $customer_group) {
			$data['customer_groups'][] = array($customer_group['customer_group_id'], $customer_group['name']);
		}
		
		$this->load->model('localisation/tax_class');
		$taxes = $this->model_localisation_tax_class->getTaxClasses();
		
		$data['tax_class'][] = array(0, $this->language->get('text_none'));
		
		foreach ($taxes as $tax) {
			$data['tax_class'][] = array($tax['tax_class_id'], $tax['title']);
		}
		
		$this->load->model('localisation/geo_zone');
		$geo_zones = $this->model_localisation_geo_zone->getGeoZones();
		
		$data['geo_zone'][] = array(0, $this->language->get('text_all_zones'));
		
		foreach ($geo_zones as $geo_zone) {
			$data['geo_zone'][] = array($geo_zone['geo_zone_id'], $geo_zone['name']);
		}
		
		$this->load->model('localisation/order_status');
        $statuses = $this->model_localisation_order_status->getOrderStatuses();
		
        $data['order_status'] = array();

        foreach ($statuses as $status) {
        	$data['order_status'][] = array($status['order_status_id'], $status['name']);
        }
		
		$data['status'] = array(
			array('0', $data['text_disabled']),
			array('1', $data['text_enabled']));
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		foreach ($data['languages'] as $key => $language) {
			if (version_compare(VERSION, '2.2', '<')) {
				$data['languages'][$key]['flag'] = 'view/image/flags/'.$language['image'];
			} else {
				$data['languages'][$key]['flag'] = 'language/'.$language['code'].'/'.$language['code'].'.png';
			}
		}

		$this->load->model('localisation/stock_status');
		$statuses = $this->model_localisation_stock_status->getStockStatuses();
		
        foreach ($statuses as $status) {
        	$data['stock_status'][] = array($status['stock_status_id'], $status['name']);
        }

		$data['date_short'] = $this->language->get('date_format_short');
		$data['date_long'] = $this->language->get('date_format_long');
		$data['stylesheet'] = $this->extension;
				
		/* Extension specific code */
		
		$data['help'] = "https://thekrotek.com/opencart-extensions/free-extensions";
		
		unset($this->options['debug']);
		unset($this->options['geo_zone']);
		unset($this->options['tax_class']);
		unset($this->options['sort_order']);
		
		$data['settings'] = array(
			'general' => array_merge(array(
				'name' => 'text',
				'ordering' => 'select',
				'limit' => 'text',
				'characters' => 'text',
				'sensitive' => 'radio',
				'available' => 'radio',
				'shuffle' => 'radio',
				'total' => 'radio',
				'image_width' => 'text',
				'image_height' => 'text'), $this->options));
  		
		$data['ordering'] = array(
			array('random', $this->language->get('ordering_random')),
			array('asc', $this->language->get('ordering_asc')),
			array('desc', $this->language->get('ordering_desc')));
		
		/* Generic code */

		array_unshift($data['buttons'], array('id' => 'help', 'href' => $data['help'], 'title' => $this->language->get('button_help'), 'class' => 'btn-default', 'icon' => 'question', 'target' => '_blank'));
		
		if (!empty($module_id) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->{$module_model}->getModule($module_id);
		}
		
		foreach ($data['settings'] as $tab => $options) {
			if (empty($data['tab_'.$tab]) && ($this->language->get('tab_'.$tab) != 'tab_'.$tab)) $data['tab_'.$tab] = $this->language->get('tab_'.$tab);			
			if ($this->language->get('help_'.$tab) != 'help_'.$tab) $data['help_'.$tab] = $this->language->get('help_'.$tab);
			
			foreach ($options as $field => $fieldtype) {
				if ($fieldtype != 'hidden') {
					if (is_array($fieldtype)) {
						foreach ($fieldtype as $groupfield => $groupvalue) {
							if ($this->language->get('entry_'.$groupfield) != 'entry_'.$groupfield) $data['entry_'.$groupfield] = $this->language->get('entry_'.$groupfield);
							if ($this->language->get('help_'.$groupfield) != 'help_'.$groupfield) $data['help_'.$groupfield] = $this->language->get('help_'.$groupfield);
						}
					} else {
						if ($this->language->get('entry_'.$field) != 'entry_'.$field) $data['entry_'.$field] = $this->language->get('entry_'.$field);
						if ($this->language->get('help_'.$field) != 'help_'.$field) $data['help_'.$field] = $this->language->get('help_'.$field);
					}
				}
				
				if (is_array($fieldtype)) {
					foreach ($fieldtype as $groupfield => $groupvalue) {
						$from_post = (isset($this->request->post[$this->fieldbase.'_'.$groupfield]) ? $this->request->post[$this->fieldbase.'_'.$groupfield] : '');
						$from_config = (!empty($module_info) && isset($module_info[$this->fieldbase.'_'.$groupfield]) ? $module_info[$this->fieldbase.'_'.$groupfield] : $this->config->get($this->fieldbase.'_'.$groupfield));
						$default = ($fieldtype == 'checkbox' ? array() : '');

						if (!isset($data[$this->fieldbase.'_'.$groupfield])) {
							if (!empty($from_post)) $data[$this->fieldbase.'_'.$groupfield] = $from_post;
							elseif (isset($from_config)) $data[$this->fieldbase.'_'.$groupfield] = $from_config;
							else $data[$this->fieldbase.'_'.$groupfield] = $default;
						}						
					}
				} else {
					$from_post = (isset($this->request->post[$this->fieldbase.'_'.$field]) ? $this->request->post[$this->fieldbase.'_'.$field] : '');
					$from_config = (!empty($module_info) && isset($module_info[$this->fieldbase.'_'.$field]) ? $module_info[$this->fieldbase.'_'.$field] : $this->config->get($this->fieldbase.'_'.$field));
					$default = ($fieldtype == 'checkbox' ? array() : '');

					if (!isset($data[$this->fieldbase.'_'.$field])) {
						if (!empty($from_post)) $data[$this->fieldbase.'_'.$field] = $from_post;
						elseif (isset($from_config)) $data[$this->fieldbase.'_'.$field] = $from_config;
						else $data[$this->fieldbase.'_'.$field] = $default;
					}
				}
			}
		}
		
		if (method_exists($this, 'setDefaults')) {
			$this->setDefaults($data);
		}
					
		if (!empty($this->session->data['errors'])) {
			foreach ($this->session->data['errors'] as $key => $text) {
				$this->error[$key] = $text;
			}
		}
	
		unset($this->session->data['errors']);
		
		if (!empty($this->error)) {
			$data['errors'] = $this->error;
		} else {
			$data['errors'] = '';
		}
		
		if (isset($this->session->data['warning'])) $data['warning'] = $this->session->data['warning'];
		else $data['warning'] = '';
		
		$this->session->data['warning'] = '';		
		
		if (isset($this->session->data['information'])) $data['information'] = $this->session->data['information'];
		else $data['information'] = '';
		
		$this->session->data['information'] = '';		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$data['values'] = $data;
		
		$this->response->setOutput($this->load->view($this->folder.'/'.$this->extension.(version_compare(VERSION, '2.2', '<') ? '.tpl' : ''), $data));
	}
	
	private function setDefaults(&$data)
	{		
		if (!$data[$this->fieldbase.'_limit']) $data[$this->fieldbase.'_limit'] = '4';
		if (!$data[$this->fieldbase.'_characters']) $data[$this->fieldbase.'_characters'] = '200';
		
		if (version_compare(VERSION, '2.2', '<')) {
			$image_width = $this->config->get('config_image_thumb_width');
			$image_height = $this->config->get('config_image_thumb_height');
		} else {
			$image_width = $this->config->get((version_compare(VERSION, '3.0', '>=') ? 'theme_' : '').$this->config->get('config_theme').'_image_thumb_width');
			$image_height = $this->config->get((version_compare(VERSION, '3.0', '>=') ? 'theme_' : '').$this->config->get('config_theme').'_image_thumb_height');
		}		
		
		if (!$data[$this->fieldbase.'_image_width']) $data[$this->fieldbase.'_image_width'] = $image_width;
		if (!$data[$this->fieldbase.'_image_height']) $data[$this->fieldbase.'_image_height'] = $image_height;
	}
		
	private function preValidate($post, &$fields)
	{
		if (!empty($post[$this->fieldbase.'_task'])) return true;
		
		$fields['numerics'] = array('limit', 'characters', 'width', 'height');
	}
	
	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->folder.'/'.$this->extension)) {
			$this->error['warning'] = sprintf($this->language->get('error_permission'), $this->language->get('heading_title'));
		} else {
			$post = $this->request->post;
			
			if ($this->error) return false;
			
			if (!empty($post[$this->fieldbase.'_task'])) return true;
			
			$fields = array();
						
			if (method_exists($this, 'preValidate')) {
				$this->preValidate($post, $fields);
			}
			
			$checks = ($fields ? array_unique(call_user_func_array('array_merge', $fields)) : array());
			
			foreach ($checks as $field) {
				$value = (isset($post[$this->fieldbase.'_'.$field]) ? $post[$this->fieldbase.'_'.$field] : '');
						
				if (isset($fields['nonempty']) && in_array($field, $fields['nonempty']) && !$value) {
					$this->error[] = sprintf($this->language->get('error_empty'), $this->language->get('entry_'.$field));
				} elseif (isset($fields['date']) && in_array($field, $fields['date']) && !empty($value) && (strtotime($value) === false)) {
					$this->error[] = sprintf($this->language->get('error_date'), $this->language->get('entry_'.$field));
				} elseif (!is_array($value)) {
					$value = trim($value, '%');
							
					if (!empty($value) && !is_numeric($value)) {
						if (isset($fields['numerics']) && in_array($field, $fields['numerics'])) {
							$this->error[] = sprintf($this->language->get('error_numerical'), $this->language->get('entry_'.$field));
						} elseif (isset($fields['percent']) && in_array($field, $fields['percent'])) {
							$this->error[] = sprintf($this->language->get('error_percent'), $this->language->get('entry_'.$field));
						}
					} elseif ($value < 0) {
						$this->error[] = sprintf($this->language->get('error_positive'), $this->language->get('entry_'.$field));
					}
				}
			}
		}
		
		if (!$this->error) return true;
		else return false;
	}
	  	   	  		 
  	private function checkVersion()
  	{
  		$result = array();
  			
     	$curl = curl_init();
        
        curl_setopt($curl, CURLOPT_URL, 'https://thekrotek.com/index.php?option=com_smartseller&task=checkversion');
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, false);
        curl_setopt($curl, CURLOPT_TIMEOUT, 30);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HEADER, false);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query(array('source' => 'opencart', 'product_type' => 'files', 'product_id' => $this->product_id)));
        
        $response = curl_exec($curl);
       	$status = strval(curl_getinfo($curl, CURLINFO_HTTP_CODE));
        
       	if (($response !== false) || (!$status != '0')) {
       		$result = json_decode($response, true);
		} else {
			$result['error'] = sprintf($this->language->get('error_curl'), curl_errno($curl), curl_error($curl));
		}
						
		return $result;
  	}
}

?>