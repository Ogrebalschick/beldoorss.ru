<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<script type="text/javascript" src="view/javascript/jquery/jquery-2.1.1.min.js"></script>

 <?php if ($implus_status) {?>
            <link rel="stylesheet" href="view/javascript/jquery/jquery-ui-1.11.4.custom/jquery-ui.css" />
            <?php  if (!$openbay_page) { ?> 
            <script src="view/javascript/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
            <?php } ?>  
            <script src="view/javascript/image_manager_plus/elfinder.min.js"></script>  
            <script src="view/javascript/image_manager_plus/proxy/elFinderSupportVer1.js"></script>
            
            <!-- MAIN -->
            <link rel="stylesheet" type="text/css" media="screen" href="view/stylesheet/image_manager_pro/implus-elfinder.min.css">
            <link rel="stylesheet" type="text/css" media="screen" href="view/stylesheet/image_manager_pro/implus-elfinder.theme.css">

            <!-- COLORS -->
            <?php $pathtoimage = 'view/image/image_manager_pro/toolbars/toolbar-' . $toolbar_image . '.png'; ?>
            <style type="text/css">.elfinder-lock,.elfinder-perms,.elfinder-symlink{position:absolute;width:20px;height:20px;background-image:url("<?php echo $pathtoimage; ?>");background-repeat:no-repeat;background-position:0 -528px}.elfinder-drag-helper-icon-plus{position:absolute;width:20px;height:20px;left:43px;top:55px;background:url("<?php echo $pathtoimage; ?>") 0 -544px no-repeat;display:none}.elfinder-navbar-icon{width:20px;height:20px;position:absolute;top:50%;margin-top:-8px;background-image:url("<?php echo $pathtoimage; ?>");background-repeat:no-repeat;background-position:0 -20px}.elfinder-quicklook .ui-resizable-se{width:14px;height:14px;right:5px;bottom:3px;background:url("<?php echo $pathtoimage; ?>") 0 -620px no-repeat}.elfinder-button-icon{width:20px;height:20px;display:block;background:url("<?php echo $pathtoimage; ?>") no-repeat}.ui-icon.ui-icon-circle-close{width: 16px!important;}.elfinder-cwd-filename{color:#000!important;}</style>

            <link rel="stylesheet" type="text/css" media="screen" href="view/stylesheet/image_manager_pro/toolbar-positions.css">

            <!-- LANGUAGES -->
            <?php if ($image_manager_language) { ?>
            <script type="text/javascript" src="view/javascript/image_manager_plus/i18n/elfinder.<?php echo $image_manager_language;?>.js"></script>  
            <?php } ?>
 <?php } ?>
            

            <script type="text/javascript" src="view/javascript/jquery/jquery-ui/jquery-ui.min.js"></script>
            
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>
<link href="view/stylesheet/bootstrap.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<script src="view/javascript/jquery/datetimepicker/moment.js" type="text/javascript"></script>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

        <?php if (isset($FileManagerElfinder['status']) && $FileManagerElfinder['status']) { ?>
          <script src="view/javascript/FileManagerElfinder/common.js" type="text/javascript"></script>
        <?php if ($editor) { ?>
          <script src="view/javascript/ckeditor/FileManagerElfinder_ckeditor.js"></script>
          <script type="text/javascript"><!--
              $(document).ready(function() {
                $('[data-toggle=\'summernote\'], .summernote').each(function() {
                  var element = this;
                  var elementId = $(element).attr('id');
                  ckeditorInit(elementId, getURLVar('token'));
                });
              });
            //--></script>
        <?php } else {?>
          <script src="view/javascript/summernote/FileManagerElfinder_summernote.js"></script>
        <?php } ?>
        <?php } else { ?>
          <script src="view/javascript/common.js" type="text/javascript"></script>
        <?php } ?>
      
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
</head>
<body>
<div id="container">
<header id="header" class="navbar navbar-static-top">
  <div class="navbar-header">
    <?php if ($logged) { ?>
    <a type="button" id="button-menu" class="pull-left"><i class="fa fa-indent fa-lg"></i></a>
    <?php } ?>
    <a href="<?php echo $home; ?>" class="navbar-brand"><img src="view/image/logo.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></a></div>
  <?php if ($logged) { ?>
  <ul class="nav pull-right">
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php if($alerts > 0) { ?><span class="label label-danger pull-left"><?php echo $alerts; ?></span><?php } ?> <i class="fa fa-bell fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
        <li class="dropdown-header"><?php echo $text_order; ?></li>
        <li><a href="<?php echo $processing_status; ?>" style="display: block; overflow: auto;"><span class="label label-warning pull-right"><?php echo $processing_status_total; ?></span><?php echo $text_processing_status; ?></a></li>
        <li><a href="<?php echo $complete_status; ?>"><span class="label label-success pull-right"><?php echo $complete_status_total; ?></span><?php echo $text_complete_status; ?></a></li>
        <li><a href="<?php echo $return; ?>"><span class="label label-danger pull-right"><?php echo $return_total; ?></span><?php echo $text_return; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_customer; ?></li>
        <li><a href="<?php echo $online; ?>"><span class="label label-success pull-right"><?php echo $online_total; ?></span><?php echo $text_online; ?></a></li>
        <li><a href="<?php echo $customer_approval; ?>"><span class="label label-danger pull-right"><?php echo $customer_total; ?></span><?php echo $text_approval; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_product; ?></li>
        <li><a href="<?php echo $product; ?>"><span class="label label-danger pull-right"><?php echo $product_total; ?></span><?php echo $text_stock; ?></a></li>
        <li><a href="<?php echo $review; ?>"><span class="label label-danger pull-right"><?php echo $review_total; ?></span><?php echo $text_review; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_affiliate; ?></li>
        <li><a href="<?php echo $affiliate_approval; ?>"><span class="label label-danger pull-right"><?php echo $affiliate_total; ?></span><?php echo $text_approval; ?></a></li>
      </ul>
    </li>
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-home fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_store; ?></li>
        <?php foreach ($stores as $store) { ?>
        <li><a href="<?php echo $store['href']; ?>" target="_blank"><?php echo $store['name']; ?></a></li>
        <?php } ?>
      </ul>
    </li>
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-life-ring fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_help; ?></li>
        <li><a href="http://www.opencart.com" target="_blank"><?php echo $text_homepage; ?></a></li>
        <li><a href="http://docs.opencart.com" target="_blank"><?php echo $text_documentation; ?></a></li>
        <li><a href="http://forum.opencart.com" target="_blank"><?php echo $text_support; ?></a></li>
      </ul>
    </li>
    <li><a href="<?php echo $logout; ?>"><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_logout; ?></span> <i class="fa fa-sign-out fa-lg"></i></a></li>
  </ul>
  <?php } ?>
</header>
