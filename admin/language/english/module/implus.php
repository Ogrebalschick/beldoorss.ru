<?php
// Image Manager Plus
// author: DataIc - www.dataic.eu

// Heading
$_['heading_title']  = '<b style="color:#E0590F">Image Manager Pro+</b>';

// Text
$_['text_module']    = 'Modules';
$_['text_success']   = 'Success: You have modified module Image Manager Pro+!';

$_['tab_general']    = 'General';
$_['tab_config']     = 'Configuration';
$_['tab_design']     = 'Design';
$_['tab_watermark']  = 'Watermark';
$_['tab_autoresize'] = 'Auto-Resize';
$_['tab_ftp'] 		 = 'FTP';
$_['tab_info'] 		 = 'Info';

$_['text_enabled']  = 'Enabled';
$_['text_disabled'] = 'Disabled';

$_['text_megabytes']  = 'Megabyte';
$_['text_kilobytes']  = 'Kilobyte';

$_['text_image_manager'] = 'Image Manager';
$_['text_browse']        = 'Browse';
$_['text_clear']         = 'Clear';

$_['text_edit']        = 'Edit Image Manager Pro+ Module';


// settings
$_['entry_width']    	   	   = 'Image Manager Width:';
$_['entry_width_info']    	   = 'In pixels.';
$_['entry_height']    	       = 'Image Manager Height:';
$_['entry_height_info']    	   = 'In pixels.';
$_['entry_language']      	   = 'Language: ';
$_['entry_copy_overwrite']     = 'Copy Overwrite:';
$_['entry_copy_overwrite_info']= 'Replace files on paste or give new names to pasted files';
$_['entry_upload_overwrite']   = 'Upload Overwrite:';
$_['entry_upload_overwrite_info']   = 'Replace files on upload or give them new names';
$_['entry_upload_max_size']    = 'Upload Max Size:';
$_['entry_upload_max_size_info']    = 'Maximum upload file size.';

$_['entry_default_root']       = 'Default Root';
$_['entry_default_root_info']  = 'Set the root folder for the Image Manager. ( set this to: catalog/ ) - If empty root will be images folder.';

$_['entry_drag_upload_allow']  = 'Disable Drag & Drop:';
$_['entry_drag_upload_allow_info']  = 'Disable drag and drop to upload files.';

$_['entry_image_folder']  = 'Product Image folder on load:';
$_['entry_image_folder_info']  = 'Automatically open image folder of edited products.';

$_['entry_lazy_load']  		   = 'Lazy Load:';
$_['entry_lazy_load_info']     = 'Amount of files display at once.';

$_['entry_user_catalog']  		  = 'User Catalog:';
$_['entry_user_catalog_info']     = 'When this option is enabled each user have own ImageManager root (The folder will be created for that user and he will able to see, use, upload only to that folder.)';

$_['entry_user_catalog_admin']  		  = 'Admin for Catalog:';
$_['entry_user_catalog_admin_info']     = 'When User Catalog is enabled you can define the admin group that will manage all the image folders.';


$_['entry_lazy_load_treshold'] = 'Lazy Load Threshol:';
$_['entry_lazy_load_treshold_info'] = 'Distance in px to cwd bottom edge to start displaying files.';

$_['entry_only_images'] 	   = 'Display Only Images:';
$_['entry_only_images_info'] 	   = 'If this is &quot;enabled&quot;, manager will show only image type';

$_['entry_status']        	   = 'Status:';

$_['entry_sanitize']           = 'Sanitize:';
$_['entry_sanitize_info']      = 'Santizer will replace all special characers (\\/:*?&quot;<>|) in your file names, so you will not get broken links to your images.';

$_['entry_sanitize_replace']           = 'Sanitize Replace Char:';
$_['entry_sanitize_replace_info']      = 'Choose a character for sanytazer to replace the special characters. Default is "_"';

$_['entry_ckeditor']           = 'ckEditor compatibility:';
$_['entry_ckeditor_info']      = 'Enable this field <b>only</b> when you have ckEditor installed';

$_['entry_journal']           = 'Journal 2 compatibility:';
$_['entry_journal_info']      = 'Enable this field <b>only</b> when you have Journal 2 installed';

$_['entry_default_image_name']  = 'Default Image Tab Name:';
$_['entry_default_image_name_info']  = 'Set the name of the default image column in the product image tab. (default: Default Image:)';

// design
$_['info_extra']        	   = 'Extra Options:';
$_['info_colors']        	   = 'Colors:';

$_['entry_double_images']        	= 'Double-Sized Images:';
$_['entry_double_images_info']      = 'When enabled, product images in Image Manager will be doubled. To make sure every image is resized properrly you have to delete the content of the image>catalog>.tmb folder.';

$_['entry_status_design']        	= 'Status:';
$_['entry_status_design_info']      = 'When disabled the default template is loaded.';
$_['entry_theme_toolbar_bg_color']  = 'Toolbar Background Color:';
$_['entry_theme_left_panel']        = 'Left Panel Color:';
$_['entry_theme_right_panel']       = 'Right Panel Color:';
$_['entry_theme_hower']        	    = 'Hover Color:';
$_['entry_theme_icon_color_hover']  = 'Icon Hover Color:';
$_['entry_theme_icon_color']        = 'Icon Background Color:';
$_['entry_theme_icon_inactive']     = 'Inactive Icon Background Color:';
$_['entry_theme_selected_item']     = 'Selected Item Background Color';

$_['entry_theme_toolbar_round']     = 'Toolbar Round Corners:';
$_['entry_theme_toolbar_round_info']     = 'In pixels.';
$_['entry_theme_icon_border']       = 'Icons Borders:';
$_['entry_theme_icon_border_info']       = 'In pixels.';
$_['entry_theme_icon_round']        = 'Icons Round Corners:';
$_['entry_theme_icon_round_info']        = 'In pixels.';

$_['entry_toolbar_image']        	   = 'Toolbar Style:';
$_['entry_toolbar_image_info']        	   = 'Set the icon set and style of the image manager toolbar.';
$_['text_toolbar_image']        	   = 'DEFAULT';
$_['entry_theme_toolbar_bg_color']     = 'Toolbar Background Color:';

//WATERMARK
$_['info_watermark']          		= 'This tool will apply watermark to image when uploading a new image';
$_['entry_watermark']          		= 'Watermark Image:';
$_['entry_watermark_margin_right']  = 'Right Margin in Pixels:';
$_['entry_watermark_margin_bottom'] = 'Bottom Margin in Pixels:';
$_['entry_watermark_quality']       = 'JPEG image save quality:';
$_['entry_watermark_quality_info']       = 'Minimum 0 - Maximum 100.';
$_['entry_watermark_transparency']  = 'Water mark image transparency:';
$_['entry_watermark_transparency_info']  = 'Other than PNG';

$_['entry_watermark_middle']          		= 'Set Middle:';
$_['entry_watermark_middle_info']          	= 'If this option is enabled, Watermark will be set in the middle. Bottom Margin and Right Margin are not taken into consideration.';

// FTP
$_['info_ftp_main']        		   = 'Configuration';

$_['entry_ftp_save_status']         = 'Copy to store ';
$_['info_entry_ftp_save_status']    = 'Copy image to store from ftp if it is selected. (this option has to be enabled if you want to assign the product image from ftp connection)';

$_['entry_ftp_save_path']          = 'Copied image path';
$_['info_entry_ftp_save_path']     = 'Define the path where the images ( copied from ftp appon assign ) will be saved. (example: catalog/ftp-img/ )';


$_['info_ftp']          	= 'FTP for: ';

$_['add_ftp']          		= 'Add FTP';
$_['delete_ftp']          	= 'Delete FTP';

$_['host']          		= 'Host:';
$_['info_host']          	= 'Set your ftp host address ( Example: ftp.yoursite.com)';

$_['port']          		= 'Port:';
$_['info_port']          	= 'Set ftp port (default 21).';

$_['user']          		= 'Username:';
$_['info_user']          	= 'Set your ftp username.';

$_['pass']          		= 'Password:';
$_['info_pass']          	= 'Set your ftp password.';

$_['path']          		= 'Path:';
$_['info_path']          	= 'Here write the path to the image folder like it is on your ftp account (example: web/images)';

$_['url']          			= 'URL:';
$_['info_url']          	= 'Here write the http URL of the ftp site with the image location. If you leave this empty than your images will not be placed into image fields properrly. (example: http://yoursite.com/images )';

$_['alias']          			= 'Alias:';
$_['info_alias']          	= 'Set Alias for your ftp connection. (how it will be displayed in the Image Manager.)';


//RESIZE
$_['info_resize']          			= 'This tool will resize image when uploading a new image';
$_['entry_resize_max_width']        = 'Width:';
$_['entry_resize_max_width_info']        = 'Width of the image after resizing';
$_['entry_resize_max_height']       = 'Height:';
$_['entry_resize_max_height_info']       = 'Height of the image after resizing';
$_['entry_resize_quality']          = 'JPEG image save quality:';
$_['entry_resize_quality_info']          = 'Minimum 0 - Maximum 100.';

//Error
$_['error_permission']      = 'Warning: You do not have permission to modify module Image Manager Pro+!';
?>