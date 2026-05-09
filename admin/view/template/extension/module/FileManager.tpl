<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-FileManagerElfinder" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-FileManagerElfinder" class="form-horizontal">
          <ul class="nav nav-tabs main_tabs">
            <li class="active"><a href="#tab_setting" data-toggle="tab"><i class="fa fa-cogs" aria-hidden="true"></i><?php echo $tab_setting; ?></a></li>
            <li><a href="#tab_support" data-toggle="tab"><i class="fa fa-life-ring" aria-hidden="true"></i><?php echo $tab_support; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab_setting">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-8">
                    <select name="FileManagerElfinder_setting[status]" id="input-status" class="form-control">
                      <?php if ($FileManagerElfinder_setting['status']) { ?>
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
            <div class="tab-pane" id="tab_support">
              <div class="form-group">
                <div class="col-sm-8">
                  <h4><?php echo $info_support; ?></h4></div>
              </div>
              <div class="form-group">
                <div class="col-sm-3"><span data-toggle="tooltip" style="font-size: 13px;" title="" data-original-title="<?php echo $info_support_tooltip; ?>"><b><?php echo $info_contacts; ?></b></span></div>
                <div class="col-sm-9">
                  <span style="font-weight: 600;">Website </span><a href="https://freeopencart.ru" style="font-size: 13px;" target="_blank">freeopencart.ru</a><br>
                  <span style="font-weight: 600;"><?php echo $info_mail; ?> </span> <a href="mailto:help@freeopencart.ru" style="font-size: 13px;">help@freeopencart.ru</a><br>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-8"><span style="font-size: 14px;"><?php echo $info_host; ?> <b><a target="_blank" href="https://billing.sherlockhost.co.uk/aff.php?aff=349">Sherlockhost</a></b></span></div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
<style>
ul.nav.nav-tabs.main_tabs li {
    font-size: 14px;
}
.main_tabs i.fa {
    font-size: 16px;
    margin-right: 6px;
}
.main_tabs li.active i.fa {
    color: #f38733;
}
</style>
<style>
.block_signature {
    text-align: center;
    margin: 0 auto;
    cursor: pointer;
}
.subtitle {
    background-color: black;
    display: inline-block;
    padding: 3px 10px;
    border-radius: 3px;
    color: #f9f9f9;
}
.signature {
    font: 800 12px/1 "Oswald", sans-serif;
    background: url(view/image/animated-text-fill.png) repeat-y;
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: aitf 80s linear infinite;
    -webkit-transform: translate3d(0,0,0);
    -webkit-backface-visibility: hidden;
    text-transform: uppercase;
}
@-webkit-keyframes aitf {
  0% { background-position: 0% 50%; }
  100% { background-position: 100% 50%; }
}
</style>