<?php
/**
 * @total-module	Image Manager Plus
 * @author-name 	◘ Dotbox Creative
 * @copyright		Copyright (C) 2014 ◘ Dotbox Creative www.dotbox.eu
 */
class ControllerExtensionModuleImplus extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/implus');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

		$this->load->model('setting/setting');
		$this->load->model('module/implus');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('implus', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		
		$language_info = array(
		'heading_title',					'button_save',				'button_cancel',				'tab_general',
		'tab_config',						'tab_watermark',			'tab_autoresize',				'text_enabled',
		'text_disabled',					'text_megabytes',			'text_kilobytes',				'entry_width',
		'entry_height',						'entry_language',			'entry_thumb_size',				'entry_copy_overwrite',
		'entry_upload_overwrite',			'entry_upload_max_size',	'entry_drag_upload_allow',		'entry_lazy_load',	
		'entry_lazy_load_treshold',			'entry_only_images',		'entry_status',		   'entry_watermark_margin_right',
		'entry_watermark_margin_bottom',	'entry_watermark_quality',	'info_watermark',	   'entry_watermark_transparency', 'entry_watermark_middle', 
		'entry_resize_max_width',			'entry_resize_max_height',	'entry_resize_quality',			'info_resize', 
		'entry_watermark',					'text_browse',				'text_clear',					'text_image_manager',
		'tab_design',						'entry_toolbar_image',		'text_toolbar_image',			
		'entry_theme_toolbar_bg_color', 	'info_extra',				'info_colors',					'entry_status_design',
		'entry_theme_toolbar_bg_color',		'entry_theme_left_panel',	'entry_theme_right_panel',		'entry_theme_hower',
		'entry_theme_icon_color',			'entry_theme_icon_border',	'entry_theme_hower',			'entry_theme_icon_round',
		'entry_theme_toolbar_round',		'entry_theme_icon_color_hover', 'entry_theme_icon_inactive','entry_theme_selected_item',
		'text_edit',						'entry_ckeditor',			'entry_journal',		 		'tab_info',	
		'entry_sanitize',					'entry_sanitize_replace',	'entry_user_catalog',			'entry_user_catalog_admin',
		// FTP
		'tab_ftp','info_ftp_main','info_ftp','host','info_host','port','info_port','user','info_user','pass','info_pass','path','info_path','url','info_url','alias','info_alias','delete_ftp','add_ftp',

		'entry_ftp_save_status','info_entry_ftp_save_status','entry_ftp_save_path','info_entry_ftp_save_path',
		// double size
		'entry_double_images','entry_image_folder',
		// root
		'entry_default_root',
		//default
		'entry_default_image_name'
		);
		

		foreach ($language_info as $language) {
			$data[$language] = $this->language->get($language); 
		}

		$language_info_tooltips = array(
		'entry_width_info', 				 		'entry_height_info', 					'entry_copy_overwrite_info',
		'entry_upload_overwrite_info', 		 		'entry_upload_max_size_info', 			'entry_drag_upload_allow_info',
		'entry_lazy_load_info', 					'entry_lazy_load_treshold_info', 		'entry_only_images_info',
		'entry_status_design_info', 				'entry_theme_toolbar_round_info', 		'entry_theme_icon_border_info',
		'entry_theme_icon_round_info',  			'entry_toolbar_image_info', 			'entry_watermark_quality_info',
		'entry_watermark_transparency_info', 		'entry_resize_max_width_info', 			'entry_resize_max_height_info',
		'entry_resize_quality_info',				'entry_ckeditor_info', 					'entry_journal_info', 
		'entry_sanitize_info', 						'entry_sanitize_replace_info',			'entry_user_catalog_info',
		'entry_user_catalog_admin_info', 'entry_watermark_middle_info','entry_double_images_info','entry_image_folder_info','entry_default_root_info',
		//default
		'entry_default_image_name_info'
		);

		foreach ($language_info_tooltips as $tooltip) {
			$data[$tooltip] = $this->language->get($tooltip); 
		}


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
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/implus', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/implus', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		// simple imput fields
		$imput_fields = array(
		'implus_only_images',			'implus_drag_upload_allow',			'implus_upload_overwrite',		
		'implus_copy_overwrite',		'implus_language',					'implus_status',						
		'implus_watermark_status',		'implus_resize_status',				'implus_toolbar_image',
		'implus_design_status',			'implus_watermark_image_con',		'implus_ckeditor', 
		'implus_sanitize',				'implus_journal',					'implus_user_catalog',
		'implus_user_catalog_admin', 	'implus_watermark_middle',		
		// ftp
		'implus_ftp_save_status', 'implus_ftp_save_path','implus_double_images',
		// image root
		'implus_image_folder'
		);


		
		foreach ($imput_fields as $imput_field) {
			if (isset($this->request->post[$imput_field])) {
			$data[$imput_field] = $this->request->post[$imput_field];
			} else {
				$data[$imput_field] = $this->config->get($imput_field);
			}		
		}

		// special imput fields
		$imput_fields_special = array(
		'implus_width' => 800, 						'implus_upload_max_size' => 99,				'implus_lazy_load' => 30,
		'implus_height' => 500, 					'implus_upload_type' => 'M',				'implus_lazy_load_treshold' => 50,
		'implus_watermark_margin_right' => 5,		'implus_watermark_quality' => 95,
		'implus_watermark_margin_bottom' => 5,		'implus_watermark_transparency' => 70,		'implus_resize_quality' => 95,
		'implus_resize_max_width' => 1024,			'implus_resize_max_height' => 1024,			'implus_sanitize_replace'=> '_',

		'implus_theme_toolbar_bg_color' => '#CCC',  'implus_theme_left_panel' => '#DDE4EB',	'implus_theme_right_panel' => '#FFF',
		'implus_theme_hower' => '#DADADA',		'implus_theme_icon_active' => '#E6E6E6',	'implus_theme_icon_hover' => '#DADADA',
		'implus_theme_icon_border' => 0, 	'implus_theme_icon_round' => 0, 		'implus_theme_toolbar_round' => 0,
		'implus_theme_icon_inactive' => '#E6E6E6', 'implus_theme_selected' => '#CCC',

		'implus_ftp' => array(), 'implus_default_root' => '', 'implus_default_image_name' => 'Default Image:'

		);
		
		foreach ($imput_fields_special as $imput_fields_special => $value) {
			if (isset($this->request->post[$imput_fields_special])) {
			$data[$imput_fields_special] = $this->request->post[$imput_fields_special];
			} else if($this->config->get($imput_fields_special)){
			$data[$imput_fields_special] = $this->config->get($imput_fields_special);
			} else {
			$data[$imput_fields_special] = $value;	
			}	
		}

		// correcting imput values min 0 - max 100
		$corrections = array('implus_watermark_quality', 'implus_watermark_transparency', 'implus_resize_quality',);
		$data['dotbox'] = $this->model_module_implus->getplist();
		foreach ($corrections as $correction) {
			if ($data[$correction] > 100) {
			$data[$correction] = 100;
			} elseif ($data[$correction] < 0) {
				$data[$correction] = 0;
			}
		}

		// user groups
		$this->load->model('user/user_group');
		$results_usergroups = $this->model_user_user_group->getUserGroups();
		
		foreach ($results_usergroups as $usergroup) {
		$data['user_groups'][] = array(
				'user_group_id'    => $usergroup['user_group_id'],
				'name'             => $usergroup['name']
			);
		}

		// data passer
		$data['con_toolbar_image'] = $this->config->get('implus_toolbar_image');
		$data['con_implus_width'] = $this->config->get('implus_width');
		$data['con_implus_height'] = $this->config->get('implus_height');

		// watermark image
		$this->load->model('tool/image');

		if (isset($this->request->post['implus_watermark_image_con']) && is_file(DIR_IMAGE . $this->request->post['implus_watermark_image_con'])) {$data['implus_watermark_image'] = $this->model_tool_image->resize($this->request->post['implus_watermark_image_con'], 100, 100);
		} elseif ($this->config->get('implus_watermark_image_con') && is_file(DIR_IMAGE . $this->config->get('implus_watermark_image_con'))) {$data['implus_watermark_image'] = $this->model_tool_image->resize($this->config->get('implus_watermark_image_con'), 100, 100);
		} else {
			$data['implus_watermark_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


		// get the languages
		$data['languages'] = array();
		$ignore = array('LANG');
		$files = glob(DIR_APPLICATION . 'view/javascript/image_manager_plus/i18n/*.js');
		
		foreach ($files as $file) {		
			$lang_files = basename($file, '.js');
			$languages	= str_replace('elfinder.', '', $lang_files);
			if (!in_array($languages, $ignore)) { $data['languages'][] = $languages; }
		}	

		// get toolbars
		$data['toolbars'] = array();
		$ignore_toolbar = array('color');
		$toolbar_files = glob(DIR_APPLICATION . 'view/image/image_manager_pro/toolbars/*.png');
			
		foreach ($toolbar_files as $file) {		
			$toolbar_file = basename($file, '.png');
			$toolbar_refined = str_replace('toolbar-', '', $toolbar_file);
			if (!in_array($toolbar_refined, $ignore_toolbar)) { $data['toolbars'][] = $toolbar_refined; }		
		}

		// RENDER
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/implus.tpl', $data));
	}
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/implus')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	public function install(){}		
	}
?>