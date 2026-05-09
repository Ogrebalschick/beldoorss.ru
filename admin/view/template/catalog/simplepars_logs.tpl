<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER ========== -->
  <div class="page-header">
    <div class="container-fluid">
      <!-- USER TOOLS -->
      <div class="pull-right">
        <form class="form-horizontal" id="form_preview" method="POST">
          <div class="pull-right">
            <button name="update_logs" type="submit" data-toggle="tooltip" class="btn btn-default"
                    data-original-title="Обновить страницу"><i class="fa fa-refresh"></i>
            </button>
            <button type="submit" class="btn btn-primary" name="save_logs_setting" value="1" title="Сохранить настрйки">
              <i class="fa fa-save" aria-hidden="true"></i> Сохранить настройки
            </button>
            <button type="submit" class="btn btn-warning" name="dw_lods" value="1" title="Скачать логи">
              <i class="fa fa-download"></i>
            </button>
            <button type="submit" class="btn btn-danger" name="dl_lods" value="1" title="Очистить логи">
              <i class="fa fa-eraser"></i>
            </button>
          </div>

      </div>
      <h1>SimplePars</h1>
      <!-- BREADCRUMBS -->
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $bread){ ?>
        <li>
          <a href="<?php echo $bread['href']?>"><?php echo $bread['text']?></a>
        </li>
        <?php }?>
      </ul>
    </div>
  </div><!-- /header -->
  <!-- ========== CONTENT ========== -->
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Редактирование проекта <?php echo '<b>['.$setting['dn_name'].']</b>'?></h3>
      </div>
      <div class="panel-body">

        <!-- NAVIGATION -->
        <ul class="nav nav-tabs">
          <?php foreach($mpage as $page){ ?>
          <li role="presentation" class="<?php echo $page['active']?>">
            <a href="<?php echo $page['href']?>" id="home-tab" role="tab" aria-controls="home" aria-expanded="true">
              <?php echo $page['title']?>
            </a>
          </li>
          <?php }?>
        </ul>
        <div class="tab-content">
          <div class="form-group">
            <div class="col-sm-2">
              <label>Порядок вывода логов<span data-toggle="tooltip" data-original-title="Определяет какие логи будут выводится сверху. Прямой это запись логов от старых к новым. Обратный это от новых к старым. Обратите внимание что этот переключатель определяет только порядок вывода логов, а не записи. Для применения не нужно сохранять. "></span></label>
              <select id="logs_reverse" name="logs_reverse" class="form-control">
                <option value="0" <?php echo ($setting['logs_reverse']==0)?'selected':''?>>Прямой</option>
                <option value="1" <?php echo ($setting['logs_reverse']==1)?'selected':''?>>Обратный</option>
              </select>

            </div>
            <div class="col-sm-2">
              <label>Размер выводимого лога<span data-toggle="tooltip" data-original-title="Эта настройка отвечает за максимальный размер выводимого лога в браузер. Для применения необходимо нажать сохранить. Обратите внимание что эта настройка не влияет на размер логов а только ограничивает вывод больших лог файлов в браузер. "></span></label>
              <select id="logs_mb" name="logs_mb" class="form-control">
                <option value="10" <?php echo ($setting['logs_mb']==10)?'selected':''?>>10mb</option>
                <option value="15" <?php echo ($setting['logs_mb']==15)?'selected':''?>>15mb</option>
                <option value="20" <?php echo ($setting['logs_mb']==20)?'selected':''?>>20mb</option>
                <option value="25" <?php echo ($setting['logs_mb']==25)?'selected':''?>>25mb</option>
              </select>
            </div>
            <div class="col-sm-2">
              <label>Частота авто обновления <span data-toggle="tooltip" data-original-title="Отвечает за периодичность с которой будет обновляется лог файл после того как вы нажмете на кнопку Старт / Cтоп Авто обновление. Обратите внимание что при авто обновлении логи стачиваются полностьюы, а значит что если лог файл большой то эта задача будет создавать большую нагрузку на ваш хостинг, так же замедлять процесс парсинга. Поэтому использовать авто обновления рекомендуется только в процессе настройки и отладки парсинга. Обязательно отключайте авто обновления"></span></label>
              <select id="pause" name="pause" class="form-control">
                <option value="5000">5сек</option>
                <option value="10000" selected>10сек</option>
                <option value="15000">15сек</option>
                <option value="20000">20сек</option>
                <option value="25000">25сек</option>
                <option value="30000">30сек</option>
                <option value="60000">1мин</option>
              </select>
            </div>

            <div class="col-sm-2">
              <button type="button" class="btn btn-default" id="auto_update" value="0" title="Старт авто обновление лога" style="margin-top: 20px">
                <i class="fa fa-refresh" aria-hidden="true"></i> Старт / Стоп | Авто обновления логов
              </button>
            </div>
          </div>
          <br><br>
          <div class="form-group">
            <div class="tab-pane active">
              <!-- simpleparspage start -->
              <textarea wrap="off" style="height: 65vh;" id="logs" readonly class="form-control"><?php echo $logs?></textarea>
              <!-- /simpleparspage stop-->
            </div>
          </div>
        </div>
        </form>
      </div>
    </div>
  </div><!-- /content -->
</div>
<style>
  label>span:after {
    font-family: FontAwesome;
    color: #1E91CF;
    content: "\f059";
    margin-left: 4px;
  }
</style>
<script>
  $(document).ready(function() {
    var text = $("#logs").val();
    //var time;


    if ($("#logs_reverse").val() == 1) {
      log_reverse();
    }

    $("#logs_reverse").bind("change", function() {
      log_reverse();
    });

    $("#auto_update").bind("click", function() {

      var i = Number($("#auto_update").val()) + 1;
      $("#auto_update").val(i);
      if (i % 2) {
        $("#auto_update").attr('class', 'btn btn-danger');
        check_up();
      } else {
        $("#auto_update").attr('class', 'btn btn-default');
      }
    });

    function log_reverse() {
      var logs_reverse = $("#logs_reverse").val();
      if (logs_reverse == 1) {

        new_text = text.split('\n\n');
        new_text = new_text.reverse();
        new_text = new_text.join('\n\n');
        $("#logs").val(new_text);

      } else {
        $("#logs").val(text);
      }
    }

    function start_up() {
      text = ajaxGet();
      $("#logs").val(text);
      log_reverse();
      check_up();
    }

    function check_up() {
      var pause = $("#pause").val();
      var pass = $("#auto_update").val();

      if (pass % 2) {
        console.log(pause);
        setTimeout(function() {
          start_up();
        }, pause);
      }
    }



    function ajaxGet() {
      var retVar;
      $.ajax({
        url: 'index.php?route=catalog/simplepars/ajax&who=logs&do=get_logs&<?php echo $adap['token']?>&dn_id=<?php echo $dn_id?>',
        type: "POST",
        data: "",
        async: false,
        dataType: "html",
        success: function(data) {
          retVar = data;
        }
      });
      return retVar;
    };

  });
</script>
<?php echo $footer; ?>