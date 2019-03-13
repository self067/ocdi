<?php
class ControllerCommonFooter extends Controller {

                    public function addToNewsletter(){
            
                        $email = $this->request->post['email'];
                        
                        $this->load->language('common/footer');
                        $this->load->model('account/customer');

                        $this->createNewsletterTables();
                        
                        $count = $this->checkEmailSubscribe($email);
                        
                        if($count == 0){
                            
                            $newsletter_id = $this->model_account_customer->addToNewsletter($email);
                            $msg = $this->language->get('text_success_subcribe');
                            
                        } else {
                            
                            $msg = $this->language->get('text_error_subcribe');
                        }
                        
                        echo $msg;

                    }
        
                    public function createNewsletterTables() {

                        $query = $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "newsletter (
                        `id` INT( 11 ) NOT NULL AUTO_INCREMENT ,
                        `email` VARCHAR( 255 ) NOT NULL ,
                        `group` VARCHAR( 25 ) NOT NULL ,
                        `date_added` DATETIME NOT NULL ,
                        PRIMARY KEY ( `id` )
                        )");
                    } 
        
                    public function checkEmailSubscribe($email){

                        $this->load->model('account/customer');

                        $count = $this->model_account_customer->checkEmailSubscribe($email);

                        return $count;

                    }

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

		$data['geocode'] = $this->config->get('config_geocode');
		$data['geocode_hl'] = $this->config->get('config_language');
		$data['button_map'] = $this->language->get('button_map');


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


                    $data['text_newsletter_text'] = $this->language->get('text_newsletter_text');
                    $data['text_subcribe'] = $this->language->get('text_subcribe');
                    $data['text_error_subcribe'] = $this->language->get('text_error_subcribe');
                    $data['text_success_subcribe'] = $this->language->get('text_success_subcribe');


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
