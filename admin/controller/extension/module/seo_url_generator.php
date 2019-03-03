<?php

/**
 * @category   OpenCart
 * @package    SEO URL Generator
 * @copyright  © Serge Tkach, 2017, https://opencartforum.com/profile/717101-sergetkach/
 */

class ControllerExtensionModuleSeoUrlGenerator extends Model {

	private $error;

	public function install() {
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'extension/module/seo_url_generator');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'extension/module/seo_url_generator');
	}

	public function index() {
		$this->load->language('extension/module/seo_url_generator');

		$this->load->model('extension/module/seo_url_generator');
		$this->load->model('setting/setting');

		$data['success'] = '';

		// Save
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateForm()) {

			$this->model_setting_setting->editSetting('seo_url_generator', $this->request->post);

			$data['success'] = $this->language->get('success'); // if no success redirect
		}

		// Error
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['errors'])) {
			$data['errors'] = $this->error['errors'];
		} else {
			$data['errors'] = '';
		}

		// Text
		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/seo_url_generator', 'token=' . $this->session->data['token'], true)
		);

		$data['heading_title']			 = $this->language->get('heading_title');
		$data['text_success']				 = $this->language->get('text_success');
		$data['text_edit']					 = $this->language->get('text_edit');
		$data['text_enabled']				 = $this->language->get('text_enabled');
		$data['text_disabled']			 = $this->language->get('text_disabled');
		$data['text_edit']					 = $this->language->get('text_edit');
		$data['text_author']				 = $this->language->get('text_author');
		$data['text_author_name']		 = $this->language->get('text_author_name');
		$data['text_author_support'] = $this->language->get('text_author_support');

		$data['text_formula_product_vars'] = $this->language->get('text_formula_product_vars');

		$data['entry_status']						 = $this->language->get('entry_status');
		$data['entry_code_for_translit'] = $this->language->get('entry_code_for_translit');
		$data['entry_formula_product']	 = $this->language->get('entry_formula_product');

		$data['button_save']	 = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['action']	 = $this->url->link('extension/module/seo_url_generator', 'token=' . $this->session->data['token'], true);
		$data['cancel']	 = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);


		$data['seo_url_generator_code_for_translit'] = '';
		if (isset($this->request->post['seo_url_generator_code_for_translit'])) {
			$data['seo_url_generator_code_for_translit'] = $this->request->post['seo_url_generator_code_for_translit'];
		} else {
			$data['seo_url_generator_code_for_translit'] = $this->config->get('seo_url_generator_code_for_translit');
		}

		$data['a_codes_for_translit'] = array(
			'rus'	 => $this->language->get('text_code_russian'),
			'ukr'	 => $this->language->get('text_code_ukrainian'),
		);

		$data['seo_url_generator_status']	 = '';
		if (isset($this->request->post['seo_url_generator_status'])) {
			$data['seo_url_generator_status']	 = $this->request->post['seo_url_generator_status'];
		}
		else {
			$data['seo_url_generator_status']	 = $this->config->get('seo_url_generator_status');
		}

		if (isset($this->request->post['seo_url_generator_formula_product'])) {
			$data['seo_url_generator_formula_product'] = $this->request->post['seo_url_generator_formula_product'];
		}
		else {
			$data['seo_url_generator_formula_product'] = $this->config->get('seo_url_generator_formula_product');
		}

		$data['header']			 = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer']			 = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/seo_url_generator', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'extension/module/seo_url_generator')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$this->request->post['seo_url_generator_formula_product'] = trim($this->request->post['seo_url_generator_formula_product']);

		if (!$this->request->post['seo_url_generator_formula_product']) {
			$this->error['errors']['formula_product'] = $this->language->get('error_formula_product');
		} else {

			// need be at least 1 variable
			if (false === strstr($this->request->post['seo_url_generator_formula_product'], '[product_name]') && false === strstr($this->request->post['seo_url_generator_formula_product'], '[model]') && false === strstr($this->request->post['seo_url_generator_formula_product'], '[sku]')) {
				$this->error['errors']['formula_product'] = $this->language->get('error_formula_product');
			} else {
				$str_without_vars = str_replace(
					array('[product_name]', '[model]', '[sku]'), array('', '', ''), $this->request->post['seo_url_generator_formula_product']
				);
				if (!empty($str_without_vars)) {
					if (!preg_match("/^[\-]+$/", $str_without_vars)) {
						$this->error['errors']['formula_product'] = $this->language->get('error_formula_product_pattern');
					}
				}
			}
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	public function getSeoUrl($a_data) {
		$test_mode = false;

		$keyword = '';

		if ($test_mode) {
			ob_start();
			echo "\$a_data in getSeoUrl()" . PHP_EOL;
			print_r($a_data);
			$c = ob_get_contents();
			ob_clean();

			file_put_contents(
				$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
				. "$c" . PHP_EOL
				. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
			);
		}

		$this->load->model('extension/module/seo_url_generator');

		/* Определить сущность
		 * Определить, какие переменные есть в формуле
		 * Вырезать из формулы лишние - (транслит сам это сделает)
		 * Транлитировать
		 * Запросить уникальность
		 * Если URL не уникален, то использовать индекс N - причем, это не зависит от того, есть ли в формуле генерации доп переменные или нет
		 */

		if ($a_data['essence']) {
			if ('product' == $a_data['essence']) {
				$keyword = $this->getProductKeywordByForumla($a_data);
			} else {
				$keyword = trim($a_data['name']);
			}
		}

		$keyword = $this->model_extension_module_seo_url_generator->translit($keyword, $test_mode);

		if ($test_mode) {
			file_put_contents(
				$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
				. "\$keyword after translit = $keyword" . PHP_EOL
				. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
			);
		}

		// Unique

		$keyword = $this->model_extension_module_seo_url_generator->getUniqueUrl($keyword, $test_mode);

		if ($test_mode) {
			file_put_contents(
				$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
				. "\$keyword after unique = $keyword" . PHP_EOL
				. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
			);
		}

		return $keyword;
	}

	public function getSeoUrlByAjax() {
		$test_mode = false;
		$data			 = array('result' => '');
		if (!isset($this->request->post)) return false;

		$result = $this->getSeoUrl($this->request->post);

		if ($result) {
			$data['result'] = $result;
		}

		header('Content-type:application/json;charset=utf-8');
		echo json_encode($data);
		exit;
	}

	private function getProductKeywordByForumla($a_data, $test_mode = false) {
		if ($test_mode) {
			file_put_contents(
				$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
				. "getProductKeywordByForumla() is called" . PHP_EOL
				. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
			);

			ob_start();
			echo "\$a_data" . PHP_EOL;
			print_r($a_data);
			$c = ob_get_contents();
			ob_clean();

			file_put_contents(
				$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
				. "$c" . PHP_EOL
				. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
			);
		}

		$keyword = '';
		$formula = $this->config->get('seo_url_generator_formula_product');

		$search = array('[product_name]', '[model]', '[sku]');

		$replace	 = array();
		$replace[] = isset($a_data['name']) ? trim($a_data['name']) : '';
		$replace[] = isset($a_data['model']) ? trim($a_data['model']) : '';
		$replace[] = isset($a_data['sku']) ? trim($a_data['sku']) : '';

		$keyword = str_replace($search, $replace, $formula);

		return $keyword;
	}

}
