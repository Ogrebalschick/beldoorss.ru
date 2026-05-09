<?php 
// Image Manager Plus
// author: DataIc - www.dataic.eu
 ?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<style type="text/css">
  .image-box{height: 28px;}
  .rotated {
  transform: rotate(-90deg);
  transform-origin: 0 0;
  -ms-transform: rotate(-90deg); /* IE 9 */
  -ms-transform-origin: 0 0;
  -moz-transform: rotate(-90deg); /* Firefox */
  -moz-transform-origin: 0 0;
  -webkit-transform: rotate(-90deg); /* Safari and Chrome */
  -webkit-transform-origin: 0 0;
  -o-transform: rotate(-90deg); /* Opera */
  -o-transform-origin: 0 0;
  position: relative;
  top: 100%;}
  .color{width: 100%;}
  .listborder{clear: both;border-bottom: 2px dashed #DADADA;padding-top: 15px;margin-bottom: 20px;}
</style>
<div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-implus" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
<div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
<!-- form -->      
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-implus" class="form-horizontal">
          <ul class="nav nav-tabs">
                      <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                      <li><a href="#tab-config" data-toggle="tab"><?php echo $tab_config; ?></a></li> 
                      <li><a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a></li> 
                      <li><a href="#tab-watermark" data-toggle="tab"><?php echo $tab_watermark; ?></a></li> 
                      <li><a href="#tab-autoresize" data-toggle="tab"><?php echo $tab_autoresize; ?></a></li> 
                      <li><a href="#tab-ftp-t" data-toggle="tab"><?php echo $tab_ftp; ?></a></li>
                      <li><a href="#tab-info" data-toggle="tab"><?php echo $tab_info; ?></a></li> 
          </ul>
    <div class="tab-content">  
  <div class="tab-pane active" id="tab-general">
             <div class="form-group"> 
                <label class="col-sm-2 control-label" for="input-pstatus"><?php echo $entry_language; ?></label>
                <div class="col-sm-10">
                  <select name="implus_language" id="input-implus_language" class="form-control">
                    <option value=""> ENG </option>
                     <?php foreach ($languages as $language) {?>
                      <option value="<?php echo $language;?>" <?php if ($language==$implus_language){ echo " selected";}?>><?php echo strtoupper($language);?></option>
                      <?php } ?>
                  </select>  
                </div>
              </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_width"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $entry_width_info; ?>"><?php echo $entry_width; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_width" name="implus_width"  value="<?php echo $implus_width; ?>" placeholder="<?php echo $implus_width; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_height"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $entry_height_info; ?>"><?php echo $entry_height; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_height" name="implus_height"  value="<?php echo $implus_height; ?>" placeholder="<?php echo $implus_height; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group"> 
                <label class="col-sm-2 control-label" for="implus_status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="implus_status" id="input-implus_status" class="form-control">
                     <?php if ($implus_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
       </div>
       <div class="tab-pane" id="tab-config">


             <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_default_root"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_default_root_info; ?>"><?php echo $entry_default_root; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_default_root" name="implus_default_root"  value="<?php echo $implus_default_root; ?>" placeholder="<?php echo $entry_default_root; ?>"   class="form-control" />
              </div>
            </div>

            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_default_image_name"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_default_image_name_info; ?>"><?php echo $entry_default_image_name; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_default_image_name" name="implus_default_image_name"  value="<?php echo $implus_default_image_name; ?>" placeholder="<?php echo $entry_default_image_name; ?>"   class="form-control" />
              </div>
            </div>


            <div class="form-group"> 
              <label class="col-sm-2 control-label" for="implus_drag_upload_allow"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_drag_upload_allow_info; ?>"><?php echo $entry_drag_upload_allow; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_drag_upload_allow" id="input-implus_drag_upload_allow" class="form-control">
                     <?php if ($implus_drag_upload_allow) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>


              <div class="form-group"> 
              <label class="col-sm-2 control-label" for="implus_image_folder"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_image_folder_info; ?>"><?php echo $entry_image_folder; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_image_folder" id="input-implus_image_folder" class="form-control">
                     <?php if ($implus_image_folder) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>


               <div class="form-group"> 
              <label class="col-sm-2 control-label" for="input-implus_user_catalog"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_user_catalog_info; ?>"><?php echo $entry_user_catalog; ?></span></label>
                <div class="col-sm-4">
                  <select name="implus_user_catalog" id="input-implus_user_catalog" class="form-control">
                     <?php if ($implus_user_catalog) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
                <label class="col-sm-2 control-label" for="input-implus_user_catalog_admin"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_user_catalog_admin_info; ?>"><?php echo $entry_user_catalog_admin; ?></span></label>
                <div class="col-sm-4">
                  <select name="implus_user_catalog_admin" id="input-implus_user_catalog_admin" class="form-control">
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php if ($user_groups) { ?>
                            <?php foreach ($user_groups as $user_group) { ?>
                                <option 
                                <?php if ((int)$implus_user_catalog_admin == (int)$user_group['user_group_id']) { ?>selected="selected"<?php } ?>
                                value="<?php echo $user_group['user_group_id']; ?>"><?php echo $user_group['name']; ?></option>
                            <?php } ?>
                   <?php } ?>
                  </select>  
                </div> 
              </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_lazy_load"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_lazy_load_info; ?>"><?php echo $entry_lazy_load; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_lazy_load" name="implus_lazy_load"  value="<?php echo $implus_lazy_load; ?>" placeholder="<?php echo $implus_lazy_load; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_lazy_load_treshold"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_lazy_load_treshold_info; ?>"><?php echo $entry_lazy_load_treshold; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_lazy_load_treshold" name="implus_lazy_load_treshold"  value="<?php echo $implus_lazy_load_treshold; ?>" placeholder="<?php echo $implus_lazy_load_treshold; ?>"   class="form-control" />
              </div>
            </div>
             <div class="form-group"> 
              <label class="col-sm-2 control-label" for="implus_only_images"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_only_images_info; ?>"><?php echo $entry_only_images; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_only_images" id="input-implus_only_images" class="form-control">
                     <?php if ($implus_only_images) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
              <div class="form-group"> 
              <label class="col-sm-2 control-label" for="implus_copy_overwrite"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_copy_overwrite_info; ?>"><?php echo $entry_copy_overwrite; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_copy_overwrite" id="input-implus_copy_overwrite" class="form-control">
                     <?php if ($implus_copy_overwrite) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
              <div class="form-group"> 
              <label class="col-sm-2 control-label" for="implus_upload_overwrite"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_upload_overwrite_info; ?>"><?php echo $entry_upload_overwrite; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_upload_overwrite" id="input-implus_upload_overwrite" class="form-control">
                     <?php if ($implus_upload_overwrite) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
             <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_upload_max_size"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_upload_max_size_info; ?>"><?php echo $entry_upload_max_size; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_upload_max_size" name="implus_upload_max_size"  value="<?php echo $implus_upload_max_size; ?>" placeholder="<?php echo $implus_upload_max_size; ?>"   class="form-control" style="width: 50%; float: left;" />
                <select name="implus_upload_type" id="input-implus_upload_type" class="form-control" style="width: 50%; float: right;">
                  <option value="M" <?php if ($implus_upload_type == 'M' || !$implus_upload_type) {
                    echo " selected";}?> ><?php echo $text_megabytes; ?>
                  </option>
                  <option value="K" <?php if ($implus_upload_type == 'K') { 
                    echo " selected";}?>><?php echo $text_kilobytes; ?>
                  </option>
              </select>
              </div>
            </div>

            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_sanitize"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_sanitize_info; ?>"><?php echo $entry_sanitize; ?></span></label>
              <div class="col-sm-4">
                <select name="implus_sanitize" id="input-implus_sanitize" class="form-control">
                     <?php if ($implus_sanitize) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
              </div> 
               <label class="col-sm-2 control-label" for="implus_sanitize"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_sanitize_replace_info; ?>"><?php echo $entry_sanitize_replace; ?></span></label>
              <div class="col-sm-4">  
                <input type="text" id="implus_sanitize_replace" name="implus_sanitize_replace"  value="<?php echo $implus_sanitize_replace; ?>" placeholder="<?php echo $implus_sanitize_replace; ?>"   class="form-control" style="width: 50%; float: left;" />
                 </div>
            </div>

            <div class="form-group"> 
               <label class="col-sm-2 control-label" for="implus_ckeditor"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_ckeditor_info; ?>"><?php echo $entry_ckeditor; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_ckeditor" id="input-implus_ckeditor" class="form-control">
                     <?php if ($implus_ckeditor) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>

              <div class="form-group"> 
               <label class="col-sm-2 control-label" for="implus_journal"><span data-toggle="tooltip" data-container="#tab-config" title="<?php echo $entry_journal_info; ?>"><?php echo $entry_journal; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_journal" id="input-implus_journal" class="form-control">
                     <?php if ($implus_journal) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
       </div>
      <div class="tab-pane" id="tab-design">

            <div class="form-group"> 
               <label class="col-sm-2 control-label" for="implus_double_images"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_double_images_info; ?>"><?php echo $entry_double_images; ?></span></label>
              <div class="col-sm-10">
                <select name="implus_double_images" id="input-implus_double_images" class="form-control">
                   <?php if ($implus_double_images) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select> 
              </div>
            </div>

            <div class="form-group"> 
                 <label class="col-sm-2 control-label" for="implus_design_status"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_status_design_info; ?>"><?php echo $entry_status_design; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_design_status" id="input-implus_design_status" class="form-control">
                     <?php if ($implus_design_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
              <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_toolbar_image"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_toolbar_image_info; ?>"><?php echo $entry_toolbar_image; ?></span></label>
              <div class="col-sm-10">
                <select name="implus_toolbar_image" id="input-implus_toolbar_image" class="form-control" style="">
                  <option value="color"><?php echo $text_toolbar_image; ?></option>
                  <?php foreach ($toolbars as $toolbar) {?>
                      <option value="<?php echo $toolbar;?>" <?php if ($toolbar==$implus_toolbar_image){ echo " selected";}?>><?php echo strtoupper($toolbar);?></option>
                  <?php } ?>
              </select>
              <?php if ($con_toolbar_image) {
                    $default_src = HTTP_SERVER . "view/image/image_manager_pro/toolbars/toolbar-" . $con_toolbar_image . ".png"; } else {  $default_src = HTTP_SERVER . "view/image/image_manager_pro/toolbars/toolbar-color.png"; } ?>
                <div class="image-box"><img class ="rotated" src="<?php echo $default_src; ?>" name="toolbar-image-swap"></div> 
              </div>
            </div>
             <div class="form-group">   
              <label style="font-size: 17px;" class="col-sm-2 control-label" for="implus_lazy_load_treshold"><?php echo $info_colors; ?></label>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_lazy_load_treshold"><?php echo $entry_theme_toolbar_bg_color; ?></label>
              <div class="col-sm-2">
                <input class="color" id="implus_theme_toolbar_bg_color" name="implus_theme_toolbar_bg_color"  value="<?php echo $implus_theme_toolbar_bg_color; ?>" placeholder="<?php echo $implus_theme_toolbar_bg_color; ?>"   class="form-control" />
              </div>
            </div>
             <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_left_panel"><?php echo $entry_theme_left_panel; ?></label>
              <div class="col-sm-2">
                <input class="color" id="implus_theme_left_panel" name="implus_theme_left_panel"  value="<?php echo $implus_theme_left_panel; ?>" placeholder="<?php echo $implus_theme_left_panel; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_right_panel"><?php echo $entry_theme_right_panel; ?></label>
              <div class="col-sm-2">
                <input class="color" id="implus_theme_right_panel" name="implus_theme_right_panel"  value="<?php echo $implus_theme_right_panel; ?>" placeholder="<?php echo $implus_theme_right_panel; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_hower"><?php echo $entry_theme_hower; ?></label>
              <div class="col-sm-2">
                <input class="color" id="implus_theme_hower" name="implus_theme_hower"  value="<?php echo $implus_theme_hower; ?>" placeholder="<?php echo $implus_theme_hower; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_selected"><?php echo $entry_theme_selected_item; ?></label>
              <div class="col-sm-2">
                <input class="color" id="implus_theme_selected" name="implus_theme_selected"  value="<?php echo $implus_theme_selected; ?>" placeholder="<?php echo $implus_theme_selected; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_icon_active"><?php echo $entry_theme_icon_color; ?></label>
              <div class="col-sm-1">
                <input class="color" id="implus_theme_icon_active" name="implus_theme_icon_active"  value="<?php echo $implus_theme_icon_active; ?>" placeholder="<?php echo $implus_theme_icon_active; ?>"   class="form-control" />
              </div>
              <label class="col-sm-3 control-label" for="implus_theme_icon_inactive"><?php echo $entry_theme_icon_inactive; ?></label>
              <div class="col-sm-1">
                <input class="color" id="implus_theme_icon_inactive" name="implus_theme_icon_inactive"  value="<?php echo $implus_theme_icon_inactive; ?>" placeholder="<?php echo $implus_theme_icon_inactive; ?>"   class="form-control" />
              </div>
              <label class="col-sm-2 control-label" for="implus_theme_icon_hover"><?php echo $entry_theme_icon_color_hover; ?></label>
              <div class="col-sm-1">
                <input class="color" id="implus_theme_icon_hover" name="implus_theme_icon_hover"  value="<?php echo $implus_theme_icon_hover; ?>" placeholder="<?php echo $implus_theme_icon_hover; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label style="font-size: 17px;" class="col-sm-2 control-label"><?php echo $info_extra; ?></label>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_icon_border"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_theme_icon_border_info; ?>"><?php echo $entry_theme_icon_border; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_theme_icon_border" name="implus_theme_icon_border"  value="<?php echo $implus_theme_icon_border; ?>" placeholder="<?php echo $implus_theme_icon_border; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_icon_round"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_theme_icon_round_info; ?>"><?php echo $entry_theme_icon_round; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_theme_icon_round" name="implus_theme_icon_round"  value="<?php echo $implus_theme_icon_round; ?>" placeholder="<?php echo $implus_theme_icon_round; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_theme_toolbar_round"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_theme_toolbar_round_info; ?>"><?php echo $entry_theme_toolbar_round; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_theme_toolbar_round" name="implus_theme_toolbar_round"  value="<?php echo $implus_theme_toolbar_round; ?>" placeholder="<?php echo $implus_theme_toolbar_round; ?>"   class="form-control" />
              </div>
            </div>
       </div>
       <div class="tab-pane" id="tab-watermark">  
        <div class="form-group">   
              <label style="text-align: left;" class="col-sm-12 control-label" ><?php echo $info_watermark; ?></label>
        </div>
            <div class="form-group"> 
                 <label class="col-sm-2 control-label" for="implus_watermark_status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="implus_watermark_status" id="input-implus_watermark_status" class="form-control">
                     <?php if ($implus_watermark_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="implus_watermark_image"><?php echo $entry_watermark; ?></label>
              <div class="col-sm-10"><a href="" id="implus_watermark_image-thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo $implus_watermark_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                <input type="hidden" name="implus_watermark_image_con" value="<?php echo $implus_watermark_image_con; ?>" id="implus_watermark_image" />
              </div>
            </div>        
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_watermark_margin_right"><?php echo $entry_watermark_margin_right; ?></label>
              <div class="col-sm-10">
                <input type="text" id="implus_watermark_margin_right" name="implus_watermark_margin_right"  value="<?php echo $implus_watermark_margin_right; ?>" placeholder="<?php echo $implus_watermark_margin_right; ?>"   class="form-control" />
              </div>
            </div>
           <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_watermark_margin_bottom"><?php echo $entry_watermark_margin_bottom; ?></label>
              <div class="col-sm-10">
                <input type="text" id="implus_watermark_margin_bottom" name="implus_watermark_margin_bottom"  value="<?php echo $implus_watermark_margin_bottom; ?>" placeholder="<?php echo $implus_watermark_margin_bottom; ?>"   class="form-control" />
              </div>
            </div>

<!-- middle -->
          <div class="form-group"> 
                 <label class="col-sm-2 control-label" for="implus_watermark_middle"><span data-toggle="tooltip" data-container="#tab-design" title="<?php echo $entry_watermark_middle_info; ?>"><?php echo $entry_watermark_middle; ?></span></label>
                <div class="col-sm-10">
                  <select name="implus_watermark_middle" id="input-implus_watermark_middle" class="form-control">
                     <?php if ($implus_watermark_middle) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
              </div>
<!-- middle -->

            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_watermark_quality"><span data-toggle="tooltip" data-container="#tab-watermark" title="<?php echo $entry_watermark_quality_info; ?>"><?php echo $entry_watermark_quality; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_watermark_quality" name="implus_watermark_quality"  value="<?php echo $implus_watermark_quality; ?>" placeholder="<?php echo $implus_watermark_quality; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_watermark_transparency"><span data-toggle="tooltip" data-container="#tab-watermark" title="<?php echo $entry_watermark_transparency_info; ?>"><?php echo $entry_watermark_transparency; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_watermark_transparency" name="implus_watermark_transparency"  value="<?php echo $implus_watermark_transparency; ?>" placeholder="<?php echo $implus_watermark_transparency; ?>"   class="form-control" />
              </div>
            </div>
       </div>
       <div class="tab-pane" id="tab-autoresize">
          <div class="form-group">   
                <label style="text-align: left;" class="col-sm-12 control-label" ><?php echo $info_resize; ?></label>
          </div>
            <div class="form-group"> 
                 <label class="col-sm-2 control-label" for="implus_resize_status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="implus_resize_status" id="input-implus_resize_status" class="form-control">
                     <?php if ($implus_resize_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select> 
                </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_resize_max_width"><span data-toggle="tooltip" data-container="#tab-autoresize" title="<?php echo $entry_resize_max_width_info; ?>"><?php echo $entry_resize_max_width; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_resize_max_width" name="implus_resize_max_width"  value="<?php echo $implus_resize_max_width; ?>" placeholder="<?php echo $implus_resize_max_width; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_resize_max_height"><span data-toggle="tooltip" data-container="#tab-autoresize" title="<?php echo $entry_resize_max_height_info; ?>"><?php echo $entry_resize_max_height; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_resize_max_height" name="implus_resize_max_height"  value="<?php echo $implus_resize_max_height; ?>" placeholder="<?php echo $implus_resize_max_height; ?>"   class="form-control" />
              </div>
            </div>
            <div class="form-group">   
              <label class="col-sm-2 control-label" for="implus_resize_quality"><span data-toggle="tooltip" data-container="#tab-autoresize" title="<?php echo $entry_resize_quality_info; ?>"><?php echo $entry_resize_quality; ?></span></label>
              <div class="col-sm-10">
                <input type="text" id="implus_resize_quality" name="implus_resize_quality"  value="<?php echo $implus_resize_quality; ?>" placeholder="<?php echo $implus_resize_quality; ?>"   class="form-control" />
              </div>
            </div>
        </div>


        <div class="tab-pane" id="tab-ftp-t">
         
          <div class="form-group">   
                <label style="text-align: left; font-size: 1.2em;margin-left: 50px;" class="col-sm-12 control-label" ><?php echo $info_ftp_main; ?></label>
          </div>
          <div class="form-group">   
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_entry_ftp_save_status; ?>"><?php echo $entry_ftp_save_status; ?></span></label>
              <div class="col-sm-4">
                <select name="implus_ftp_save_status" id="implus_ftp_save_status" class="form-control">
                   <?php if ($implus_ftp_save_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select> 
              </div>
  
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_entry_ftp_save_path; ?>"><?php echo $entry_ftp_save_path; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_port" name="implus_ftp_save_path"  value="<?php echo $implus_ftp_save_path; ?>" placeholder="<?php echo $entry_ftp_save_path; ?>"   class="form-control" />
              </div>
          </div>


        <div class="listborder"></div> 
        <div id="extra-ftp"> 
<?php $ftp_row = 0; ?>
<?php foreach ($implus_ftp as $ftp) { ?>
        
      <div id="ftp-<?php echo $ftp_row; ?>">  

          <div class="form-group">   
              <div class="col-sm-3">  
                <label style="text-align: left; font-size: 1.2em; margin-left: 50px;" class="col-sm-12 control-label" ><?php echo $info_ftp; ?>  <?php echo $ftp['host']; ?></label>
              </div>
              <div class="col-sm-7">  
                    <button type="button" data-lastrow="<?php echo $ftp_row; ?>" onclick="deleteftp(this.getAttribute('data-lastrow'));" class="btn btn-danger" style="float: right;"><i class="fa fa-minus-circle"></i> <?php echo $delete_ftp; ?></button>
              </div>
          </div>

          <!-- TREAB PRIDAT VALUE A ZMENIT PALCEHOLDER AJ LABEL-->
          <div class="form-group">   
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_host; ?>"><?php echo $host; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_host" name="implus_ftp[<?php echo $ftp_row; ?>][host]"  value="<?php echo $ftp['host']; ?>" placeholder="Add Host"   class="form-control" />
              </div>
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_port; ?>"><?php echo $port; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_port" name="implus_ftp[<?php echo $ftp_row; ?>][port]"  value="<?php echo $ftp['port']; ?>" placeholder="Add Port"   class="form-control" />
              </div>
          </div>
          <div class="form-group">   
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_user; ?>"><?php echo $user; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_user" name="implus_ftp[<?php echo $ftp_row; ?>][user]"  value="<?php echo $ftp['user']; ?>" placeholder="Add Username"   class="form-control" />
              </div>
      
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_pass; ?>"><?php echo $pass; ?></span></label>
              <div class="col-sm-4">
                <input type="password" id="implus_ftp_pass" name="implus_ftp[<?php echo $ftp_row; ?>][pass]"  value="<?php echo $ftp['pass']; ?>" placeholder="Add Password"   class="form-control" />
              </div>
          </div>
          <div class="form-group">   
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_path; ?>"><?php echo $path; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_path" name="implus_ftp[<?php echo $ftp_row; ?>][path]"  value="<?php echo $ftp['path']; ?>" placeholder="Define path" class="form-control" />
              </div>
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_url; ?>"><?php echo $url; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_url" name="implus_ftp[<?php echo $ftp_row; ?>][url]"  value="<?php echo $ftp['url']; ?>" placeholder="Define URL" class="form-control" />
              </div>
          </div>
          <div class="form-group">   
              <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $info_alias; ?>"><?php echo $alias; ?></span></label>
              <div class="col-sm-4">
                <input type="text" id="implus_ftp_alias" name="implus_ftp[<?php echo $ftp_row; ?>][alias]"  value="<?php echo $ftp['alias']; ?>" placeholder="Add FTP Alias"   class="form-control" />
              </div>
              <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
              <div class="col-sm-4">
                <select name="implus_ftp[<?php echo $ftp_row; ?>][status]" id="implus_ftp_status" class="form-control">
                   <?php if ($ftp['status']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select> 
              </div>
          </div>
          <div class="listborder"></div>

      </div>

<?php $ftp_row++; ?>
<?php } ?>

        </div>
   

          <div class="form-group">
              <div class="row">
                  <div class="col-sm-10">  
                      <button type="button" id="ftpbutton" data-lastrow="<?php echo $ftp_row; ?>" onclick="addextraftp(this.getAttribute('data-lastrow'));" class="btn btn-primary" style="float: right;"><i class="fa fa-plus-circle"></i> <?php echo $add_ftp; ?></button>
                  </div>
              </div>
          </div>

          


        </div>



        <div class="tab-pane" id="tab-info">
          <div class="form-group"> 
              <div class="col-sm-12"> 
                <p style="font-size: 18px;color: #00a3d9;"><b>Thank you for using our extensions.</b></p>
                <p>To get support email us to <a href="mailto:support@dotbox.eu">support@dotbox.eu</a>.</p>
                <p>We are happy to help.</p>
                <p>If you like what you see leave us a comment and rate our extensions.</p>
              </div>   
          </div>
          <?php if ($dotbox) { ?>
          <div class="form-group"> 
            <div class="col-sm-12"> 
              <p style="font-size: 16px;color: #f27f0f;"><b>Have a look at our other extensions:</b></p>
            </div>
            <div class="col-sm-12"> 
              <div class="row">
                <?php foreach ($dotbox[0] as $extension) { ?>
                  <?php if ($extension['id'] != 0) { ?>
                  <div class="col-xs-6 col-md-2 col-sm-3">
                    <div class="thumbnail" title="Click to Read more..." style="margin-bottom: 0px;" >
                      <a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=<?php echo $extension['id']; ?>" target="_blank">
                      <img src="<?php echo $extension['img']; ?>" alt="<?php echo $extension['title']; ?>" width="100%" />
                      </a> 
                    </div>
                    <span style="height: 40px;text-align: center;display: block;font-weight: 300;font-size: 14px;"><?php echo $extension['title']; ?></span>
                  </div>
                  <?php } ?>
                <?php } ?>
                </div>
                <div class="row">
                <?php foreach ($dotbox[1] as $info) { ?>
                  <?php if ($info['id'] != 0) { ?>
                  <div class="col-xs-12 ">
                    <span style="<?php echo $info['style']; ?>">
                      <?php echo $info['textb']; ?>
                      <a href="<?php echo $info['url']; ?>" target="_blank"><?php echo $info['title']; ?></a>
                      <?php echo $info['texta']; ?>
                    </span>
                  </div>
                  <?php } ?>
                <?php } ?>
                </div>
              </div>  
            </div>
          <?php } ?>
      </div>
      </div>
     </form>   
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

function addextraftp(last_row) { 

html  = '<div id="ftp-' + last_row + '">'; 

html  += '<div class="form-group">';    
html  += '<div class="col-sm-3">';   
html  += '<div class="form-group"><label style="text-align: left; font-size: 1.2em;margin-left: 50px;" class="col-sm-12 control-label" ><?php echo $info_ftp; ?></label></div>';
html  += '</div>';
html  += '<div class="col-sm-7">';  
html  += '<button type="button" data-lastrow="' + last_row + '" onclick="deleteftp(' + last_row + ');" class="btn btn-danger" style="float: right;"><i class="fa fa-minus-circle"></i> <?php echo $delete_ftp; ?></button>';
html  += '</div></div>';


html  += '<div class="form-group">'; 
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_host; ?>"><?php echo $host; ?></span></label>'; 
html  += '<div class="col-sm-4">'; 
html  += '<input type="text" id="implus_ftp_host" name="implus_ftp[' + last_row + '][host]"  value="" placeholder="Add Host"   class="form-control" />'; 
html  += '</div>'; 
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_port; ?>"><?php echo $port; ?></span></label>'; 
html  += '<div class="col-sm-4">'; 
html  += '<input type="text" id="implus_ftp_port" name="implus_ftp[' + last_row + '][port]"  value="" placeholder="Add Port"   class="form-control" />'; 
html  += '</div>'; 
html  += '</div>'; 


html  += '<div class="form-group">';   
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_user; ?>"><?php echo $user; ?></span></label>';
html  += '<div class="col-sm-4">';
html  += '<input type="text" id="implus_ftp_user" name="implus_ftp[' + last_row + '][user]"  value="" placeholder="Add Username"   class="form-control" />';
html  += '</div>';
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_pass; ?>"><?php echo $pass; ?></span></label>';
html  += '<div class="col-sm-4">';
html  += '<input type="password" id="implus_ftp_pass" name="implus_ftp[' + last_row + '][pass]"  value="" placeholder="Add Password"   class="form-control" />';
html  += '</div></div>';

html  += '<div class="form-group">';   
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_path; ?>"><?php echo $path; ?></span></label>';
html  += '<div class="col-sm-4">';
html  += '<input type="text" id="implus_ftp_path" name="implus_ftp[' + last_row + '][path]"  value="" placeholder="Define path" class="form-control" />';
html  += '</div>';
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_url; ?>"><?php echo $url; ?></span></label>';
html  += '<div class="col-sm-4">';
html  += '<input type="text" id="implus_ftp_url" name="implus_ftp[' + last_row + '][url]"  value="" placeholder="Define URL" class="form-control" />';
html  += '</div></div>';

html  += '<div class="form-group">';  
html  += '<label class="col-sm-2 control-label"><span class="new-label" data-toggle="tooltip" title="<?php echo $info_alias; ?>"><?php echo $alias; ?></span></label>';
html  += '<div class="col-sm-4">';
html  += '<input type="text" id="implus_ftp_alias" name="implus_ftp[' + last_row + '][alias]"  value="" placeholder="Add FTP Alias"   class="form-control" />';
html  += '</div>';
html  += '<label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>';
html  += '<div class="col-sm-4">';
html  += '<select name="implus_ftp[' + last_row + '][status]" id="implus_ftp_status" class="form-control">';
html  += '<option value="1"><?php echo $text_enabled; ?></option>';
html  += '<option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
html  += '</select>';
html  += '</div>';
html  += '</div>';
html  += '<div class="listborder"></div>';
 
html  += '</div>';

$("#extra-ftp").append( html );

var datatuchange = parseInt(last_row) + 1;

//console.log(datatuchange);
$('#ftpbutton').attr('data-lastrow','' + datatuchange + '');

$('.new-label').tooltip();

}

function deleteftp(row) { 
    console.log(row);
    $("#ftp-" + row).remove();      
}

//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: <?php echo $con_implus_width?$con_implus_width:800;?>,
    height: <?php echo $con_implus_height?$con_implus_height:400;?>,
    resizable: false,
    modal: false
  });
};
//--></script> 
 <script type="text/javascript"> <!--
$(document).ready(function(){
 var imagepath = '<?php echo HTTP_SERVER."view/image/image_manager_pro/toolbars/toolbar-";?>';

   $("#input-implus_toolbar_image").change(function(){
     $("img[name=toolbar-image-swap]").attr("src",imagepath + $(this).val() + ".png");
   });

});
//--></script>
<script type="text/javascript" src="view/javascript/image_manager_plus/jscolor/jscolor.js"></script>
<?php echo $footer; ?>