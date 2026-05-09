<?php 
// Image Manager Plus
// author: DataIc - www.dataic.eu
 ?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
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
        <h3 class="panel-title"><i class="fa fa-exchange"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
          <div id="elfinder" class="implus">
          </div>
      </div>
    </div>
  </div>
</div>
 <script type="text/javascript"> <!--
$(document).ready(function(){
    if($.fn.button.noConflict) { $.fn.btn = $.fn.button.noConflict(); }
    var implus_language = '<?php echo $image_manager_language;?>';
    //var implus_width = <?php echo $con_implus_width;?>;
    var implus_height = <?php echo $con_implus_height;?>;
    var implus_drag_upload_allow = <?php echo $con_implus_drag_upload_allow;?>;
    var implus_lazy_load = <?php echo $con_implus_lazy_load;?>;
    var implus_load_treshold = <?php echo $con_implus_lazy_load_treshold;?>;
    var implus_images = <?php if ($con_implus_only_images) {?>["image"]<?php } else { ?>[]<?php } ?>;

    $('#elfinder').elfinder({
    url : 'index.php?route=common/filemanager/connector&token=' + getURLVar('token'),
    lang : implus_language,
    height: implus_height, 
    defaultView: 'icons',      
    dragUploadAllow: implus_drag_upload_allow,
    showFiles: implus_lazy_load,
    showThreshold: implus_load_treshold,
    destroyOnClose : true,   
    onlyMimes: implus_images,  
    uiOptions : {toolbar : [['home', 'back', 'forward','up'],['reload'],['mkdir', 'upload'],['open', 'download', 'getfile','upmulti'],['quicklook'],['copy', 'cut', 'paste'],['rm'],['duplicate', 'rename', 'edit', 'resize'],['extract', 'archive', 'sort'],['search'],['view'],['info'],['help']]},
        }); 
});
//--></script>
<?php echo $footer; ?>