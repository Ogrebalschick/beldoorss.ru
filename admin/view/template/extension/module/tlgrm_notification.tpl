<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#input-apply').attr('value', '1'); $('#' + $('#form-tlgrm_notification').attr('id')).submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-check"></i></button>
        <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-tlgrm_notification" class="form-horizontal">
          <input type="hidden" name="apply" id="input-apply" value="0" />
          <ul class="nav nav-tabs nav-justified">
            <li class="active"><a href="#tab-setting" data-toggle="tab"><?php echo $text_setting;?></a></li>
            <li><a href="#tab-notification" data-toggle="tab"><?php echo $text_notification;?></a></li>
            <li><a href="#tab-data" data-toggle="tab"><?php echo $text_data;?></a></li>
            <li><a href="#tab-log" data-toggle="tab"><?php echo $text_log; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-setting">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_status" id="input-status" class="form-control">
                    <?php if ($tlgrm_notification_status) { ?>
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
                <label class="col-sm-2 control-label" for="input-token"><?php echo $entry_token; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="tlgrm_notification_token" value="<?php echo $tlgrm_notification_token; ?>" placeholder="<?php echo $entry_token; ?>" id="input-token" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-id"><?php echo $entry_id; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="tlgrm_notification_id" value="<?php echo $tlgrm_notification_id; ?>" placeholder="<?php echo $entry_id; ?>" id="input-id" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-log"><?php echo $entry_log; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_log" id="input-log" class="form-control">
                    <?php if ($tlgrm_notification_log) { ?>
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
                <div class="col-sm-12">
				  <button class="btn btn-primary pull-left" id="test_message"><?php echo $text_test; ?> <i class="fa fa-comment-o"></i></button>
                </div>
              </div>         
            </div>
            <div class="tab-pane" id="tab-notification">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-new_order"><?php echo $entry_new_order; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_new_order" id="input-new_order" class="form-control">
                    <?php if ($tlgrm_notification_new_order) { ?>
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
                <label class="col-sm-2 control-label" for="input-new_customer"><?php echo $entry_new_customer; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_new_customer" id="input-new_customer" class="form-control">
                    <?php if ($tlgrm_notification_new_customer) { ?>
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
                <label class="col-sm-2 control-label" for="input-new_review"><?php echo $entry_new_review; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_new_review" id="input-new_review" class="form-control">
                    <?php if ($tlgrm_notification_new_review) { ?>
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
                <label class="col-sm-2 control-label" for="input-contact_form"><?php echo $entry_contact_form; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_contact_form" id="input-contact_form" class="form-control">
                    <?php if ($tlgrm_notification_contact_form) { ?>
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
                <label class="col-sm-2 control-label" for="input-new_order_status"><?php echo $entry_new_order_status; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_new_order_status" id="input-new_order_status" class="form-control">
                    <?php if ($tlgrm_notification_new_order_status) { ?>
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
                <label class="col-sm-2 control-label" for="input-return_order"><?php echo $entry_return_order; ?></label>
                <div class="col-sm-10">
                  <select name="tlgrm_notification_return_order" id="input-return_order" class="form-control">
                    <?php if ($tlgrm_notification_return_order) { ?>
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
            <div class="tab-pane" id="tab-data">
              <ul class="nav nav-tabs nav-justified">
                <li class="active"><a href="#tab-order" data-toggle="tab"><?php echo $entry_new_order; ?></a></li>
                <li><a href="#tab-customer" data-toggle="tab"><?php echo $entry_new_customer; ?></a></li>
                <li><a href="#tab-review" data-toggle="tab"><?php echo $entry_new_review; ?></a></li>
                <li><a href="#tab-contact" data-toggle="tab"><?php echo $entry_contact_form; ?></a></li>
                <li><a href="#tab-order-status" data-toggle="tab"><?php echo $entry_new_order_status; ?></a></li>
                <li><a href="#tab-return-order" data-toggle="tab"><?php echo $entry_return_order; ?></a></li>
              </ul>
              <div class="tab-content">
                <div class="tab-pane active" id="tab-order">
                  <div class="form-group">
                    <label class="col-sm-3 control-label" for="input-status"><?php echo $text_send; ?></label>
                    <div class="col-sm-9">
                      <div class="col-sm-4">
                        <label class="control-label" for="input-tlgrm_notification_send_1"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_send_1?>"><?php echo $text_send_1; ?></span></label>
                        <?php if (isset($tlgrm_notification_send[1])) { ?>
                        <input type="checkbox" name="tlgrm_notification_send[1]" id="input-tlgrm_notification_send_1" checked="checked" />
                        <?php } else { ?>
                        <input type="checkbox"name="tlgrm_notification_send[1]" id="input-tlgrm_notification_send_1" />
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <label class="control-label" for="input-tlgrm_notification_send_2"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_send_2?>"><?php echo $text_send_2; ?></span></label>
                        <?php if (isset($tlgrm_notification_send[2])) { ?>
                        <input type="checkbox" name="tlgrm_notification_send[2]" id="input-tlgrm_notification_send_2" checked="checked" />
                        <?php } else { ?>
                        <input type="checkbox"name="tlgrm_notification_send[2]" id="input-tlgrm_notification_send_2" />
                        <?php } ?>
                      </div>
                      <div class="col-sm-4">
                        <label class="control-label" for="input-tlgrm_notification_send_3"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_send_3?>"><?php echo $text_send_3; ?></span></label>
                        <?php if (isset($tlgrm_notification_send[3])) { ?>
                        <input type="checkbox" name="tlgrm_notification_send[3]" id="input-tlgrm_notification_send_3" checked="checked" />
                        <?php } else { ?>
                        <input type="checkbox"name="tlgrm_notification_send[3]" id="input-tlgrm_notification_send_3" />
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-3 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_field_merger_help?>"><?php echo $entry_field_merger; ?></span></label>
                    <div class="col-sm-9">
                      <select name="tlgrm_notification_field_merger" class="form-control">
                        <?php if ($tlgrm_notification_field_merger) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <ul class="nav nav-pills nav-stacked col-sm-3">
                    <li class="active"><a href="#tab-info" data-toggle="tab"><?php echo $entry_info; ?></a></li>
                    <li><a href="#tab-shipping" data-toggle="tab"><?php echo $entry_shipping; ?></a></li>
                    <li><a href="#tab-payment" data-toggle="tab"><?php echo $entry_payment; ?></a></li>
                    <li><a href="#tab-product" data-toggle="tab"><?php echo $entry_product; ?></a></li>
                    <?php if (isset($tlgrm_notification_simple)) { ?><li><a href="#tab-simple" data-toggle="tab">Simple</a></li><?php } ?>
                  </ul>
                  <div class="tab-content order_notification col-sm-9">
                    <div class="tab-pane active" id="tab-info">
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_title_order" value="<?php echo $tlgrm_notification_title_order; ?>" placeholder="<?php echo $entry_info; ?>" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_separator; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_separator_order" value="<?php echo $tlgrm_notification_separator_order; ?>" placeholder="<?php echo $entry_separator; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php 
                        $common_info = array(
                          'order_id',
                          'store_name',
                          'store_url',
                          'date_added',
                          'firstname',
                          'lastname',
                          'email',
                          'telephone',
                          'comment',
                          'total',
                          'order_status',
                          'customer_id',
                          'payment_method',
                          'shipping_method'
                        );
                      ?>
                      <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                          <tr>
                            <th width="240px"></th>
                            <th class="text-center" width="80px"><?php echo $text_enabled; ?></th>
                            <th width="160px"><?php echo $text_sort; ?></th>
                            <th><?php echo $text_custom_text; ?></th>
                          </tr>
                          <?php foreach ($common_info as $key => $value) { ?> 
                          <tr>
                            <td><label for="input-<?php echo $value ?>"><?php echo ${'entry_'.$value}; ?></label></td> 
                            <td class="text-center"><?php if (${'tlgrm_notification_'.$value}) { ?>
                              <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox"name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" />
                              <?php } ?></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_sort_<?php echo $value ?>" value="<?php echo ${'tlgrm_notification_sort_'.$value}; ?>" /></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_text_<?php echo $value; ?>"  value="<?php echo ${'tlgrm_notification_text_'.$value}; ?>" placeholder="<?php echo ${'entry_'.$value}; ?>"></td>
                          </tr>
                          <?php } ?>
                        </table>
                      </div>
                    </div>
                    <div class="tab-pane" id="tab-shipping">
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_title_shipping" value="<?php echo $tlgrm_notification_title_shipping; ?>" placeholder="<?php echo $entry_shipping; ?>" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_separator; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_separator_shipping" value="<?php echo $tlgrm_notification_separator_shipping; ?>" placeholder="<?php echo $entry_separator; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php 
                        $shipping_info = array(
                          'shipping_firstname',
                          'shipping_lastname',
                          'shipping_company',
                          'shipping_address_1',
                          'shipping_address_2',
                          'shipping_postcode',
                          'shipping_city',
                          'shipping_zone',
                          'shipping_country',
                        );
                      ?>
                      <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                          <tr>
                            <th width="240px"></th>
                            <th class="text-center" width="80px"><?php echo $text_enabled; ?></th>
                            <th width="160px"><?php echo $text_sort; ?></th>
                            <th><?php echo $text_custom_text; ?></th>
                          </tr>
                          <?php foreach ($shipping_info as $key => $value) { ?> 
                          <tr>
                            <td><label for="input-<?php echo $value ?>"><?php echo ${'entry_'.$value}; ?></label></td> 
                            <td class="text-center"><?php if (${'tlgrm_notification_'.$value}) { ?>
                              <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox"name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" />
                              <?php } ?></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_sort_<?php echo $value ?>" value="<?php echo ${'tlgrm_notification_sort_'.$value}; ?>" /></td>
                            <td> <input class="form-control" type="text" name="tlgrm_notification_text_<?php echo $value; ?>"  value="<?php echo ${'tlgrm_notification_text_'.$value}; ?>" placeholder="<?php echo ${'entry_'.$value}; ?>"></td>
                          </tr>
                          <?php } ?>
                        </table>
                      </div>
                    </div>
                    <div class="tab-pane" id="tab-payment">
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_title_payment" value="<?php echo $tlgrm_notification_title_payment; ?>" placeholder="<?php echo $entry_payment; ?>" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_separator; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_separator_payment" value="<?php echo $tlgrm_notification_separator_payment; ?>" placeholder="<?php echo $entry_separator; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php 
                          $payment_info = array(
                            'payment_firstname',
                            'payment_lastname',
                            'payment_company',
                            'payment_address_1',
                            'payment_address_2',
                            'payment_postcode',
                            'payment_city',
                            'payment_zone',
                            'payment_country',
                          );
                        ?>
                      <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                          <tr>
                            <th width="240px"></th>
                            <th class="text-center" width="80px"><?php echo $text_enabled; ?></th>
                            <th width="160px"><?php echo $text_sort; ?></th>
                            <th><?php echo $text_custom_text; ?></th>
                          </tr>
                          <?php foreach ($payment_info as $key => $value) { ?> 
                          <tr>
                            <td><label for="input-<?php echo $value ?>"><?php echo ${'entry_'.$value}; ?></label></td> 
                            <td class="text-center"><?php if (${'tlgrm_notification_'.$value}) { ?>
                              <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox"name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" />
                              <?php } ?></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_sort_<?php echo $value ?>" value="<?php echo ${'tlgrm_notification_sort_'.$value}; ?>" /></td>
                            <td> <input class="form-control" type="text" name="tlgrm_notification_text_<?php echo $value; ?>"  value="<?php echo ${'tlgrm_notification_text_'.$value}; ?>" placeholder="<?php echo ${'entry_'.$value}; ?>"></td>
                          </tr>
                          <?php } ?>
                        </table>
                      </div>
                    </div>
                    <div class="tab-pane" id="tab-product">
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_title_product" value="<?php echo $tlgrm_notification_title_product; ?>" placeholder="<?php echo $entry_product; ?>" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_separator; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_separator_product" value="<?php echo $tlgrm_notification_separator_product; ?>" placeholder="<?php echo $entry_separator; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php 
                        $product_info = array(
                          'product_name',
                          'product_sku',
                          'product_model',
                          'product_id',
                          'product_link',
                          'product_quantity',
                          'product_price',
                          'product_total',
                          'product_option',
                          'product_upc',
                          'product_ean',
                          'product_jan',
                          'product_isbn',
                          'product_mpn',
                          'product_location'
                        );
                      ?>
                      <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                          <tr>
                            <th width="240px"></th>
                            <th class="text-center" width="80px"><?php echo $text_enabled; ?></th>
                            <th width="160px"><?php echo $text_sort; ?></th>
                            <th><?php echo $text_custom_text; ?></th>
                          </tr>
                          <?php foreach ($product_info as $key => $value) { ?> 
                          <tr>
                            <td><label for="input-<?php echo $value ?>"><?php echo ${'entry_'.$value}; ?></label></td> 
                            <td class="text-center"><?php if (${'tlgrm_notification_'.$value}) { ?>
                              <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox"name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value ?>" />
                              <?php } ?></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_sort_<?php echo $value ?>" value="<?php echo ${'tlgrm_notification_sort_'.$value}; ?>" /></td>
                            <td> <input class="form-control" type="text" name="tlgrm_notification_text_<?php echo $value; ?>"  value="<?php echo ${'tlgrm_notification_text_'.$value}; ?>" placeholder="<?php echo ${'entry_'.$value}; ?>"></td>
                          </tr>
                          <?php } ?>
                        </table>
                      </div>
                    </div>
                    <?php if (isset($tlgrm_notification_simple)) {?>
                    <div class="tab-pane" id="tab-simple">
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_title_simple" value="<?php echo $tlgrm_notification_title_simple; ?>" placeholder="Simple" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_separator; ?></label>
                        <div class="col-sm-9">
                          <input type="text" name="tlgrm_notification_separator_simple" value="<?php echo $tlgrm_notification_separator_simple; ?>" placeholder="<?php echo $entry_separator; ?>" class="form-control" />
                        </div>
                      </div>
                      <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                          <tr>
                            <th width="240px"></th>
                            <th class="text-center" width="80px"><?php echo $text_enabled; ?></th>
                            <th width="160px"><?php echo $text_sort; ?></th>
                            <th><?php echo $text_custom_text; ?></th>
                          </tr>
                          <?php foreach ($tlgrm_notification_simple as $key => $value) { ?> 
                          <tr>
                            <td><label for="input-simple-<?php echo $key ?>"><?php echo ${'entry_'.$key}; ?></label></td> 
                            <td class="text-center"><?php if ($tlgrm_notification_simple[$key]) { ?>
                              <input type="checkbox" name="tlgrm_notification_simple[<?php echo $key ?>]" id="input-simple-<?php echo $key ?>" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox" name="tlgrm_notification_simple[<?php echo $key ?>]" id="input-simple-<?php echo $key ?>" />
                              <?php } ?></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_sort_simple[<?php echo $key ?>]" value="<?php echo $tlgrm_notification_sort_simple[$key]; ?>" /></td>
                            <td><input class="form-control" type="text" name="tlgrm_notification_text_simple[<?php echo $key ?>]"  value="<?php echo $tlgrm_notification_text_simple[$key]; ?>" placeholder="<?php echo ${'entry_'.$key}; ?>"></td>
                          </tr>
                          <?php } ?>
                        </table>
                      </div>
                    </div>
                    <?php } ?>
                  </div>
                </div>
                <div class="tab-pane" id="tab-customer">
                  <?php 
                    $customer = array(
                      'customer_firstname',
                      'customer_lastname',
                      'customer_email',
                      'customer_telephone',
                    );
                  ?>
                  <div class="form-group">
                  <?php foreach ($customer as $key => $value) { ?> 
                    <label class="col-sm-2 control-label" for="input-<?php echo $value; ?>"><?php echo ${'entry_'.$value}; ?></label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if (${'tlgrm_notification_'.$value}) { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" checked="checked" />
                          <?php } else { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" />
                          <?php } ?>
                        </label>
                      </div>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="tab-pane" id="tab-review">
                  <?php 
                    $review = array(
                      'review_name',
                      'review_text',
                      'review_rating',
                      'review_product_name',
                    );
                  ?>
                  <div class="form-group">
                  <?php foreach ($review as $key => $value) { ?> 
                    <label class="col-sm-2 control-label" for="input-<?php echo $value; ?>"><?php echo ${'entry_'.$value}; ?></label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if (${'tlgrm_notification_'.$value}) { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" checked="checked" />
                          <?php } else { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" />
                          <?php } ?>
                        </label>
                      </div>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="tab-pane" id="tab-contact">
                  <?php 
                    $contact = array(
                      'contact_name',
                      'contact_email',
                      'contact_comment',
                    );
                  ?>
                  <div class="form-group">
                  <?php foreach ($contact as $key => $value) { ?> 
                    <label class="col-sm-2 control-label" for="input-<?php echo $value; ?>"><?php echo ${'entry_'.$value}; ?></label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if (${'tlgrm_notification_'.$value}) { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" checked="checked" />
                          <?php } else { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" />
                          <?php } ?>
                        </label>
                      </div>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="tab-pane" id="tab-order-status">
                  <div class="form-group">
                    <div class="col-sm-6 pull-right">
                      <table class="table table-bordered table-hover">
                        <tbody>
                          <tr>
                            <td colspan="2" class="text-center"><?php echo $entry_info; ?></td>
                          </tr>
                          <tr>
                            <th width="35%"><?php echo $text_variable; ?></th>
                            <th width="65%"><?php echo $text_description; ?></th>
                          </tr>
                          <?php foreach ($common_info as $key => $value) { ?> 
                          <tr>
                            <td class="copy" id="copy_<?php echo $value; ?>">{<?php echo $value; ?>} <i class="fa fa-copy"></i></td> 
                            <td><?php echo ${'entry_'.$value}; ?></td>
                          </tr>
                          <?php } ?>
                          <tr>
                            <td class="copy" id="copy_status_comment">{status_comment} <i class="fa fa-copy"></i></td> 
                            <td><?php echo $entry_status_comment; ?></td>
                          </tr>
                          <tr>
                            <td colspan="2" class="text-center"><?php echo $entry_shipping; ?></td>
                          </tr>
                          <tr>
                            <th width="35%"><?php echo $text_variable; ?></th>
                            <th width="65%"><?php echo $text_description; ?></th>
                          </tr>
                          <?php foreach ($shipping_info as $key => $value) { ?> 
                          <tr>
                            <td class="copy" id="copy_<?php echo $value; ?>">{<?php echo $value; ?>} <i class="fa fa-copy"></i></td> 
                            <td><?php echo ${'entry_'.$value}; ?></td>
                          </tr>
                          <?php } ?>
                          <tr>
                            <td colspan="2" class="text-center"><?php echo $entry_payment; ?></td>
                          </tr>
                          <tr>
                            <th width="35%"><?php echo $text_variable; ?></th>
                            <th width="65%"><?php echo $text_description; ?></th>
                          </tr>
                          <?php foreach ($payment_info as $key => $value) { ?> 
                          <tr>
                            <td class="copy" id="copy_<?php echo $value; ?>">{<?php echo $value; ?>} <i class="fa fa-copy"></i></td> 
                            <td><?php echo ${'entry_'.$value}; ?></td>
                          </tr>
                          <?php } ?>                         
                        </tbody>
                      </table>
                    </div>
                    <div class="col-sm-6">
                    <?php foreach($order_statuses as $order_status) { ?>
                      <label for="input-<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></label>
                      <textarea class="form-control vresize" cols="80" rows="3" name="tlgrm_notification_template_order_status[<?php echo $order_status['order_status_id'];?>]"><?php echo $tlgrm_notification_template_order_status[$order_status['order_status_id']];?></textarea>
                      <br>
                    <?php } ?>
                    </div>  
                  </div>
                </div>
                <div class="tab-pane" id="tab-return-order">
                  <?php 
                    $return = array(
                      'return_order_id',
                      'return_firstname',
                      'return_lastname',
                      'return_email',
                      'return_telephone',
                      'return_date_ordered',
                      'return_product',
                      'return_model',
                      'return_quantity',
                      'return_reason',
                      'return_opened',
                      'return_comment',
                    );
                  ?>
                  <?php foreach(array_chunk($return, 4) as $temp) {?>
                  <div class="form-group">
                  <?php foreach ($temp as $key => $value) { ?> 
                    <label class="col-sm-2 control-label" for="input-<?php echo $value; ?>"><?php echo ${'entry_'.$value}; ?></label>
                    <div class="col-sm-1">
                      <div class="checkbox">
                        <label>
                          <?php if (${'tlgrm_notification_'.$value}) { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" checked="checked" />
                          <?php } else { ?>
                          <input type="checkbox" name="tlgrm_notification_<?php echo $value ?>" id="input-<?php echo $value; ?>" />
                          <?php } ?>
                        </label>
                      </div>
                    </div>
                  <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-log">
              <div class="form-group">
                <div class="col-sm-4">
                  <a href="<?php echo $downloadLog; ?>" class="btn btn-primary"><i class="fa fa-download"></i> <?php echo $button_download; ?></a>
                  <a href="<?php echo $clearLog; ?>" class="btn btn-danger"><i class="fa fa-eraser"></i> <?php echo $button_clear; ?></a>
                </div>
              </div>
              <textarea wrap="off" rows="15" readonly class="form-control"><?php echo $log; ?></textarea>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<style>
  .order_notification label{
    margin-bottom: 0;
    cursor: pointer;
    display: block;
  }
  .vresize {
    resize: vertical;
  }
  .nav > li > a{
    padding-left: 10px;
    padding-right: 10px;
  }
  .copy {
    white-space: nowrap;
    color: #000;
    font-weight: bold;
    font-size: 11px;
    cursor: pointer;
  }
  .copy .fa{
    float: right;
    margin-top: 1px;
    color: #000;
    font-size: 14px;
  }
</style>
<script>
  $('#test_message').click(function(e) {
    e.preventDefault();
    var token = $('#input-token').val(),
        id = $('#input-id').val();
    $.ajax({
      type: "POST",
      url: "<?php echo $send_test;?>",
      data: 'tk='+token+'&id='+id,
      success: function (data) {
        if (data['ok']) {
          alert('<?php echo $text_goods; ?>');
        } else {
          alert('<?php echo $text_error; ?>' +' '+ data['description']);
        }
      },
      error: function(data){
        alert('<?php echo $text_error; ?>');
      }
    })
  })
  function selectText(elementId) {
    var doc = document,
        text = doc.getElementById(elementId),
        range,
        selection;
    if (doc.body.createTextRange) {
      range = document.body.createTextRange();
      range.moveToElementText(text);
      range.select();
    } else if (window.getSelection) {
      selection = window.getSelection();
      range = document.createRange();
      range.selectNodeContents(text);
      selection.removeAllRanges();
      selection.addRange(range);
    }}

    $(".copy").click(function() {
      selectText(this.id);
      document.execCommand("copy");
    });
</script>
<?php echo $footer; ?>