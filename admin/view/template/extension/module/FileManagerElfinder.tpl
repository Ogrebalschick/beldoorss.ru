<?php
$elfinder_config = array(
  'url' => 'index.php?route=extension/module/FileManagerElfinder/connector' . (isset($token) && $token !== '' ? '&token=' . $token : ''),
  'baseUrl' => isset($base_url) ? $base_url : 'view/javascript/FileManagerElfinder/',
  'token' => isset($token) ? $token : '',
  'multiple' => !empty($multiple),
  'target' => isset($target) ? $target : '',
  'thumb' => isset($thumb) ? $thumb : '',
  'summernote' => isset($summernote) ? $summernote : '',
  'ckeditor' => isset($ckeditor) ? $ckeditor : ''
);
$elfinder_config_attr = htmlspecialchars(json_encode($elfinder_config), ENT_QUOTES, 'UTF-8');
?>
<div id="filemanager" class="modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"><?php echo $heading_title; ?></h4>
    </div>
    <div class="modal-body">
      <div class="elfinder">
        <div id="elfinder" data-fm-config="<?php echo $elfinder_config_attr; ?>"></div>
      </div>
    </div>
  </div>
</div>
<style>
  #modal-image.modal.ckeditor.in {
    z-index: 10010;
  }
  @media (min-width: 1200px) {
    #filemanager.modal-lg {
        width: 1200px;
    }
  }
</style>
