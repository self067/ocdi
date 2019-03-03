<?php

/**
 * @category   OpenCart
 * @package    SEO URL Generator
 * @copyright  © Serge Tkach, 2017, https://opencartforum.com/profile/717101-sergetkach/
 */

class ModelExtensionModuleSeoUrlGenerator extends Model {
	public function translit($string, $test_mode = false) {
		$this->load->model('tool/translit');

		$string = html_entity_decode($string);

		$code_for_translit = $this->config->get('seo_url_generator_code_for_translit');

		switch ($code_for_translit) {
			case "rus":
				$translit_function = 'cyrillicToLatinaFromRus';
				break;
			case "ukr":
				$translit_function = 'cyrillicToLatinaFromUkr';
				break;
			default:
				$translit_function = '';
				break;
		}

		if ($translit_function) {
			$string = $this->model_tool_translit->$translit_function($string);
		}

		$string = $this->model_tool_translit->clearWasteChars($string);

		$string = mb_strtolower($this->model_tool_translit->clearWasteChars($string), 'UTF-8');

		return $string;
	}

	public function getUniqueUrl($url, $test_mode = false) {
		$valid = false;
		$i		 = 0;

		while (false === $valid) {

			$unique_url	 = $url;
			if ($i > 0)
				$unique_url	 .= "-$i";

			$sql = "SELECT `url_alias_id` FROM `" . DB_PREFIX . "url_alias` WHERE `keyword`='" . $this->db->escape($unique_url) . "'";

			if ($test_mode) {
				file_put_contents(
					$this->request->server['DOCUMENT_ROOT'] . "/seo_url_generator.log", date("Y-m-d H:i:s") . " : " . PHP_EOL
					. "\$sql = $sql" . PHP_EOL
					. "------------------------------------------" . PHP_EOL . PHP_EOL, FILE_APPEND | LOCK_EX
				);
			}

			$check_url = $this->db->query($sql);
			if (0 == $check_url->num_rows) {
				$valid = true;
			}

			$i++;
		}

		return $unique_url;
	}

}
