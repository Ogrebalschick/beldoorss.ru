<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['text_footer'] = $this->language->get('text_footer');

		if ($this->user->isLogged() && isset($this->request->get['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
			$data['text_version'] = sprintf($this->language->get('text_version'), VERSION);
		} else {
			$data['text_version'] = '';
		}
		
 
            // data passer
            //$data['con_implus_height'] = $this->config->get('implus_height');
            //$data['con_implus_width'] = $this->config->get('implus_width');
            $data['ftp_save_status'] = $this->config->get('implus_ftp_save_status');
            $data['tp_save_path'] = $this->config->get('implus_ftp_save_path');
            $data['double_images'] = $this->config->get('implus_double_images');
            $data['default_root'] = $this->config->get('implus_default_root');

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

            // multy fix
            $data['im_root_folder'] = "";
            if ($this->config->get('implus_default_root')) {
              $data['im_root_folder'] = $this->config->get('implus_default_root');
            }
            ///
            
            $data['con_implus_lazy_load'] = $this->config->get('implus_lazy_load');
            $data['con_implus_lazy_load_treshold'] = $this->config->get('implus_lazy_load_treshold');
            $data['con_implus_only_images'] = $this->config->get('implus_only_images');
            $data['con_implus_height'] = 800;
            $data['con_implus_width'] = 600;
            $data['image_manager_language'] = 'en';
            $data['implus_status'] = 0;
            $data['theme_status'] = 0;
            $data['implus_image_folder'] = 0;
            if ($this->config->get('implus_status')) {
                $data['implus_status'] = $this->config->get('implus_status');
                $data['con_implus_height'] = $this->config->get('implus_height');
                $data['con_implus_width'] = $this->config->get('implus_width');
                $data['image_manager_language'] = 'en';
                if ($this->config->get('implus_language')) {$data['image_manager_language'] = $this->config->get('implus_language');}
                if ($this->config->get('implus_design_status')) {$data['theme_status'] = $this->config->get('implus_design_status');}
                if ($this->config->get('implus_image_folder')) {$data['implus_image_folder'] = $this->config->get('implus_image_folder');}
            }  

            $data['con_implus_ckeditor'] = $this->config->get('implus_ckeditor');
            $data['con_implus_journal'] = $this->config->get('implus_journal');
            $data['ckeditorplus_status_legacy'] = 0;
            if ($this->config->get('ckeditorplus_status')) {
            $data['ckeditorplus_status_legacy'] = $this->config->get('ckeditorplus_status');
            }
        
		return $this->load->view('common/footer', $data);
	}
}
