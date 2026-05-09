<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER. ========== -->
  <div class="page-header">
    <div class="container-fluid"><h1>SimplePars</h1>
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $bread){?>
          <li><a href="<?php echo $bread['href']?>"><?php echo $bread['text']?></a></li>
        <?php }?>            
        </ul>
      <div class="pull-right">
        <button name="dn_add" value="1" type="submit" form="form" data-toggle="tooltip" class="btn btn-success"
                data-original-title="Сохранить"><i class="fa fa-save" aria-hidden="true"></i>
        </button>
      </div>
    </div>
  </div>
  <div class="container-fluid">        
    <?php if(@$error){ ?>
    <div class="alert alert-danger">
      <i class="fa fa-info-circle"></i><?php echo $error?>
    </div>
    <?php }elseif(@$success){ ?>
    <div class="alert alert alert-success">
      <i class="fa fa-info-circle"></i><?php echo $success?>
    </div>
    <?php }?>
    <form class="form-horizontal" id="form" method="POST">
      <div class="panel panel-default">
        <div class="panel-heading"><h3 class="panel-title"><i class="fa fa-pencil"></i> SimplePars</h3></div>
        <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label">Имя проекта</label>
            <div class="col-sm-4">
              <input class="form-control" name="dn_name" type="text" value="<?php echo @$setting['dn_name']?>">
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</div><?php echo $footer; ?>
