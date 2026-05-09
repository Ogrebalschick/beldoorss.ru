<?php
/**
 * @total-module	Image Manager Plus
 * @author-name 	◘ Dotbox Creative
 * @copyright		Copyright (C) 2014 ◘ Dotbox Creative www.dotbox.eu
 */
class ControllerToolImplus extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/implus');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');


		$data['heading_title'] = $this->language->get('heading_title');


		$data['token'] = $this->session->data['token'];
    
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
 		if (isset($this->error['folder'])) {
			$data['error_folder'] = $this->error['folder'];
		} else {
			$data['error_folder'] = '';
		}    
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('tool/implus', 'token=' . $this->session->data['token'], 'SSL')
		);

		
		// THE STUFF
		// data passer
            //$data['con_implus_height'] = $this->config->get('implus_height');
            //$data['con_implus_width'] = $this->config->get('implus_width');
            $data['con_implus_theme_toolbar_bg_color'] = $this->config->get('implus_theme_toolbar_bg_color');
            $data['con_implus_theme_left_panel'] = $this->config->get('implus_theme_left_panel');
            $data['con_implus_theme_toolbar_round'] = $this->config->get('implus_theme_toolbar_round'); 
            $data['con_implus_theme_hower'] = $this->config->get('implus_theme_hower');     
            $data['con_implus_theme_icon_active'] = $this->config->get('implus_theme_icon_active'); 
            $data['con_implus_theme_icon_inactive'] = $this->config->get('implus_theme_icon_inactive'); 
            $data['con_implus_theme_icon_hover'] = $this->config->get('implus_theme_icon_hover'); 
            $data['con_implus_theme_right_panel'] = $this->config->get('implus_theme_right_panel'); 
            $data['con_implus_theme_icon_round'] = $this->config->get('implus_theme_icon_round'); 
            $data['con_implus_theme_selected'] = $this->config->get('implus_theme_selected'); 
            $data['con_implus_theme_icon_border'] = $this->config->get('implus_theme_icon_border');  
            if ($this->user->isLogged() && isset($this->request->get['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
            $data['token'] = $this->session->data['token'];
            } else {
            $data['token'] = ''; 
            }

            if ($this->user->isLogged()) {
                    $data['current_user_name'] = $this->user->getUserName();
                    $data['implus_user_catalog'] = $this->config->get('implus_user_catalog');
                    if ($this->user->getGroupId() == $this->config->get('implus_user_catalog_admin')) {
                          $data['implus_user_catalog'] = 0;
                    }
            } else {
                $data['current_user_name'] = 0;
                $data['implus_user_catalog'] = 0;
            }

            if ($this->config->get('implus_drag_upload_allow')) {
               $data['con_implus_drag_upload_allow'] = '0';
            } else {
               $data['con_implus_drag_upload_allow'] = '1';
            }
            
            $data['con_implus_lazy_load'] = $this->config->get('implus_lazy_load');
            $data['con_implus_lazy_load_treshold'] = $this->config->get('implus_lazy_load_treshold');
            $data['con_implus_only_images'] = $this->config->get('implus_only_images');
            $data['con_implus_height'] = 800;
            $data['con_implus_width'] = 600;
            $data['image_manager_language'] = 'en';
            $data['implus_status'] = 0;
            $data['theme_status'] = 0;
            if ($this->config->get('implus_status')) {
                $data['implus_status'] = $this->config->get('implus_status');
                $data['con_implus_height'] = $this->config->get('implus_height');
                $data['con_implus_width'] = $this->config->get('implus_width');
                $data['image_manager_language'] = 'en';
                if ($this->config->get('implus_language')) {$data['image_manager_language'] = $this->config->get('implus_language');}
                if ($this->config->get('implus_design_status')) {$data['theme_status'] = $this->config->get('implus_design_status');}
            }  

            $data['con_implus_ckeditor'] = $this->config->get('implus_ckeditor');
            $data['con_implus_journal'] = $this->config->get('implus_journal');
            $data['ckeditorplus_status_legacy'] = 0;
            if ($this->config->get('ckeditorplus_status')) {
            $data['ckeditorplus_status_legacy'] = $this->config->get('ckeditorplus_status');
            }
            
		// RENDER
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('tool/implus.tpl', $data));
	}
	
}
?>