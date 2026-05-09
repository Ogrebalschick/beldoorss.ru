<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	    <button onclick="$('#input-apply').attr('value', '1'); $('#' + $('#content form').attr('id')).submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-save"></i></button>
        <button type="submit" form="form-options-image" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
	<?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-options-image" class="form-horizontal">
		  <input type="hidden" name="options_image_apply" id="input-apply" value="0" />
		  <input type="hidden" name="options_image_status" value="1" />
		  <div class="form-group">
			<label class="col-sm-3 control-label" for="input-product-popup-element"><?php echo $entry_product_popup_element; ?></label>
			<div class="col-sm-9">
			  <input type="text" name="options_image_product_popup_element" value="<?php echo $options_image_product_popup_element; ?>" placeholder="<?php echo $entry_product_popup_element; ?>" id="input-product-popup-element" class="form-control" />
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-3 control-label" for="input-product-popup-attr"><?php echo $entry_product_popup_attr; ?></label>
			<div class="col-sm-9">
			  <input type="text" name="options_image_product_popup_attr" value="<?php echo $options_image_product_popup_attr; ?>" placeholder="<?php echo $entry_product_popup_attr; ?>" id="input-product-popup-attr" class="form-control" />
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-3 control-label" for="input-product-thumb-element"><?php echo $entry_product_thumb_element; ?></label>
			<div class="col-sm-9">
			  <input type="text" name="options_image_product_thumb_element" value="<?php echo $options_image_product_thumb_element; ?>" placeholder="<?php echo $entry_product_thumb_element; ?>" id="input-product-thumb-element" class="form-control" />
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-3 control-label" for="input-product-thumb-attr"><?php echo $entry_product_thumb_attr; ?></label>
			<div class="col-sm-9">
			  <input type="text" name="options_image_product_thumb_attr" value="<?php echo $options_image_product_thumb_attr; ?>" placeholder="<?php echo $entry_product_thumb_attr; ?>" id="input-product-thumb-attr" class="form-control" />
			</div>
		  </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>