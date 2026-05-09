<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1>SimplePars</h1>
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $bread){ ?>
        <li><a href="<?php echo $bread['href']?>"><?php echo $bread['text']?></a></li>
        <?php }?>
      </ul>
      <div class="pull-right">
        <a href="<?php echo $dn_add_link?>" data-toggle="tooltip" title="" class="btn btn-primary"
           data-original-title="Добавить">
          <i class="fa fa-plus"></i>
        </a>
        <a href="<?php echo $act_link?>" class="btn btn-default"><i class="fa fa-key"></i></a>
        <button name="dn_del" type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-danger"
                data-original-title="Удалить">
          <i class="fa fa-trash-o" aria-hidden="true"></i>
        </button>
      </div>
      <div id="extension">
        <?php if(@$success){ ?>
          <div class="alert alert-success">
            <i class="fa fa-info-circle"></i><?php echo $success?>
          </div>
          <?php }elseif(@$error){ ?>
          <div class="alert alert alert-danger">
            <i class="fa fa-info-circle"></i><?php echo $error?>
          </div>
        <?php }?>
        </div>
      </div>
    </div>
    <form class="form-horizontal" id="form" method="POST">
    <div class="container-fluid">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-calendar"></i> Менеджер заданий (CRON)</h3>
        </div>
        
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
            <tbody>
            <tr>
              <td style="width: 1px;" class="text-center">
                <a href="<?php echo $cron_link?>" data-toggle="tooltip" class="btn btn-primary" data-original-title="Редактировать">
                  <i class="fa fa-pencil" aria-hidden="true"></i> Открыть настройки CRON</a>
              </td>
              <td class="text-center"><?php echo $cron_text?></td>

              <td style="width: 1px;" class="text-right">
                <button type="submit" name="cron_permit" value="<?php echo $cron_permit?>" class="<?php echo $cron_button['class']?>">
                  <i class="fa fa-power-off" aria-hidden="true"></i> <?php echo $cron_button['text']?>
                </button>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-list"></i> Список проектов</h3>
        </div>
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <td style="width: 1px;" class="text-center">id</td>
                <td style="width: 1px;" class="text-center"></td>
                <td class="">Название проекта</td>
                <td class="text-right">Действие</td>
              </tr>
              </thead>
              <tbody>
              <?php if (!empty($pars_setting)){?>
              <?php foreach($pars_setting as $dn){ ?>
              <tr>
                <td class="text-center"><?php echo $dn['dn_id']?></td>
                <td class="text-center"><input type="checkbox" name="dn_id[]"
                                               value="<?php echo $dn['dn_id']?>">
                </td>
                <td class="left"><?php echo $dn['dn_name']?></td>

                <td class="text-right">
                  <a href="<?php echo $link_dn.$dn['dn_id']?>" data-toggle="tooltip" class="btn btn-primary" data-original-title="Редактировать">
                    <i class="fa fa-pencil" aria-hidden="true"></i></a>
                </td>
              </tr>
              <?php }?>
              <?php }?>
              </tbody>
            </table>
          </div>
        </div>
    </div>
    </form>
  </div>
<?php echo $footer; ?>
</div>