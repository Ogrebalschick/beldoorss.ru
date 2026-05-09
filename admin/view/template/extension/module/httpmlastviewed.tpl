<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-httpmlastviewed" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-httpmlastviewed" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip" title="<?php echo $help_product; ?>"><?php echo $entry_product; ?></span><div class="text-info"><?php echo $product_desc; ?></div></label>

            <div class="col-sm-10">
              <input type="text" name="product_name" value="" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
              <div id="httpmlastviewed-product" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($products as $product) { ?>
                <div id="httpmlastviewed-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                  <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name2; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name2" value="<?php echo $name2; ?>" placeholder="<?php echo $entry_name2; ?>" id="input-name2" class="form-control" />
              <div class="text-info"><?php echo $name2_desc; ?></div>
            </div>
          </div>  
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-view"><?php echo $entry_view; ?></label>
            <div class="col-sm-10">
              <select name="view" id="input-view" class="form-control">
                <?php if ($view == 'm') { ?>
                <option value="s"><?php echo $entry_view_standart; ?></option>
                <option value="m" selected="selected"><?php echo $entry_view_min; ?></option>
                <?php } else { ?>
                <option value="s" selected="selected"><?php echo $entry_view_standart; ?></option>
                <option value="m"><?php echo $entry_view_min; ?></option>
                <?php } ?>
              </select>
              <div class="text-info"><?php echo $entry_view_desc; ?></div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-class"><?php echo $entry_class; ?></label>
            <div class="col-sm-10">
              <input type="text" name="class" value="<?php echo $class; ?>" placeholder="<?php echo $entry_class; ?>" id="input-class" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-class"><?php echo $entry_rowclass; ?></label>
            <div class="col-sm-10">
              <input type="text" name="rowclass" value="<?php echo $rowclass; ?>" placeholder="<?php echo $entry_rowclass; ?>" id="input-rowclass" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('input[name=\'product_name\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'product_name\']').val('');
		
		$('#httpmlastviewed-product' + item['value']).remove();
		
		$('#httpmlastviewed-product').append('<div id="httpmlastviewed-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');	
	}
});
	
$('#httpmlastviewed-product').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
//--></script></div>
<?php echo $footer; ?>
