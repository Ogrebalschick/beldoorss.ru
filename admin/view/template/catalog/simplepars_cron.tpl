<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER ========== -->
  <div class="page-header">
    <div class="container-fluid">
      <!-- USER TOOLS -->
      <div class="pull-right">
        <form method="post" enctype="multipart/form-data" id="task_add" class="form-horizontal"></form>
        <form class="form-horizontal" id="form_preview" method="POST">
          <div class="pull-right">
            <button type="submit" name="cron_permit" value="<?php echo $cron_permit?>" class="<?php echo $cron_button['class']?>">
                <i class="fa fa-power-off" aria-hidden="true"></i> <?php echo $cron_button['text']?>
            </button>
            <button type="submit" class="btn btn-primary" name="save" value="1" title="Сохранить настрйки">
              <i class="fa fa-save" aria-hidden="true"></i> Сохранить настройки
            </button>
            <button type="submit" class="btn btn-default" title="Обновить">
              <i class="fa fa-refresh"></i>
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
    <?php if(@$error){ ?>
    <div class="alert alert-danger">
      <i class="fa fa-info-circle"></i><?php echo $error?>
    </div>
    <?php }elseif(@$success){ ?>
    <div class="alert alert alert-success">
      <i class="fa fa-info-circle"></i><?php echo $success?>
    </div>
    <?php }?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Менеджер заданий (CRON)</h3>
      </div>
      <div class="panel-body">
        <!-- NAVIGATION -->
        <div class="tab-content">
          <div class="well">
            <h4>График выполнения заданий</h4>
            <table class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th class="text-left col-sm-2">Проэкт</th>
                  <td class="text-left col-sm-1">Задание</td>
                  <td class="text-left col-sm-1">Готово/Очередь|Всего</td>
                  <td class="text-left col-sm-3">Время выполнения</td>
                  <td class="text-left col-sm-1">Состояние</td>
                  <td class="text-left col-sm-2">Информация</td>
                  <td class="text-left col-sm-1">Таймаут до</td>
                </tr>
              </thead>
              <tbody>
                <?php foreach($crons as $key_list => $cron){ ?>
                <tr>
                  <td class="left"><?php echo '['.$cron['dn_id'].'] <a href="'.$href_dn.$cron['dn_id'].'" target="_blank">'.$dn_list[$cron['dn_id']].'</a>'?></td>
                  <td class="left"><?php echo $cron['task_name']?></td>
                  <td class="left"><?php echo $cron['table_link_stat']?></td>
                  <td class="left"><?php echo $cron['table_time_srt']?></td>
                  <td class="left"><?php echo $cron['table_on']?></td>
                  <td class="left"><?php echo $cron['table_info']?></td>
                  <td class="left"><?php echo $cron['table_timeout']?></td>
                </tr>
                <?php }?>
              </tbody>
            </table>
          </div>
          <div class="well">
            <div class="row">
              <div class="col-sm-9">
                <div class="col-sm-2">
                  <button type="submit" class="btn btn-success" name="cron_add" value="1" form="task_add"><i class="fa fa-plus" aria-hidden="true"></i> Добавить задание</button>
                </div>
                <div class="col-sm-2">
                  <select name="cron_add_dn" form="task_add" class="form-control">
                    <option value="0">Выберите проект</option>
                    <?php foreach($dn_list as $dn_key => $dn){?>
                    <option value="<?php echo $dn_key?>"><?php echo '['.$dn_key.'] '.$dn?></option>
                    <?php }?>
                  </select>
                </div>
                <div class="col-sm-2">
                  <select name="cron_add_task" id="cron_add_task" form="task_add" class="form-control">
                    <option value="0">Выберите задание</option>
                    <option value="1">Сбор ссылок</option>
                    <option value="3">Парсинг в ИМ</option>
                    <option value="2">Парсинг в CSV</option>
                    <option value="5">Обработчик XML/YML</option>
                    <option value="4">Парсинг в кэш</option>
                  </select>
                </div>
                <div class="col-sm-2" id="pr_grab" hidden>
                  <select name="cron_add_action_1" form="task_add" class="form-control">
                    <option value="0">Не очишать Ссылки на товары</option>
                    <option value="1">Удалить Ссылки на товары перед началом сбора</option>
                    <option value="2">Удалить Cсылки очереди сканирования перед началом сбора</option>
                    <option value="3">Удалить Cсылки на товары и очередь сканирования перед началом сбора</option>
                  </select>
                </div>
                <div class="col-sm-2" id="pr_csv" hidden>
                  <select name="cron_add_action_2" form="task_add" class="form-control">
                    <option value="0">Не удалять прайс лист</option>
                    <option value="1">Удалить прайс лист в начала работы крона</option>
                  </select>
                </div>
                <div class="col-sm-2" id="pr_im" hidden>
                  <select name="cron_add_action_3" form="task_add" class="form-control">
                    <option value="1" style="color: #3c763d;">Добавлять</option>
                    <option value="2" style="color: #a94442;">Обновлять</option>
                    <option value="3">Добавлять и обновлять</option>
                  </select>
                </div>
              </div>
              <div class="col-sm-1">
                <select name="timezone" class="form-control">
                  <?php foreach($user_times as $t_value => $user_time){?>
                  <option value="<?php echo $t_value?>" <?php echo ($t_value == $select_time)?'selected':''?>><?php echo $user_time?></option>
                  <?php }?>
                </select>
              </div>
              <div class="col-sm-2">
                <b>Время на сайте: <?php echo $time_machin?></b>
              </div>
            </div>
          </div>
          <div class="form-group">
            <?php foreach($crons as $key_list => $cron){ ?>
            <div class="panel panel-default">
              <div class="panel-body">
              <legend>Настройка задания</legend>
              <div class="row">
                <div class="col-sm-9">
                  <div class="col-sm-3">
                   <input name="cron_list[<?php echo $key_list?>][id]" value="<?php echo $cron['id']?>" type="hidden">
                    <label for="link_round">Проект<span data-toggle="tooltip" data-original-title="ID проекта и его название"></span></label>
                    <input type="text" value="<?php echo '['.$cron['dn_id'].'] '.$dn_list[$cron['dn_id']]?>" class="form-control" readonly>
                  </div>
                  <div class="col-sm-2">
                    <label for="input-pause">Задание<span data-toggle="tooltip" data-original-title="Задание которое будет выполнять крон"></span></label>
                    <input type="text" value="<?php echo $cron['task_name']?>" class="form-control" readonly>
                  </div>
                  <?php if(!empty($cron['action_name'])){?>
                  <div class="col-sm-2">
                    <label for="input-pause">Действие<span data-toggle="tooltip" data-original-title="Дополнительные параметры настройки задания. "></span></label>
                    <input type="text" value="<?php echo $cron['action_name']?>" class="form-control" readonly> 
                  </div>
                  <?php }?>
                  <div class="col-sm-2">
                    <label for="input-pause">Порядок выполнения<span data-toggle="tooltip" data-original-title="Если вы запланировали два задания на одно и тоже время, то модуль начнет выполнять то задание у которого порядок выполнения меньше."></span></label>
                    <input name="cron_list[<?php echo $key_list?>][sort]" type="number" min="0" value="<?php echo @$cron['sort']?>" class="form-control">
                  </div>
                  <div class="col-sm-1">
                    <label for="input-pause">Таймаут<span data-toggle="tooltip" data-original-title="Таймаут отвечает за время в течении которого модуль не будет повторно вызывать задание после его выполнения. Время указывается в часах."></span></label>
                    <input name="cron_list[<?php echo $key_list?>][timeout]" type="text" value="<?php echo @$cron['timeout']?>" class="form-control">
                  </div>
                  <div class="col-sm-1">
                    <label for="input-pause"><text class="text-<?php echo ($cron['on'] != 1) ? '':'success'?>">Состояние</text><span data-toggle="tooltip" data-original-title="Данная настройка отвечает за включение и отключения регулярного выполнения этого задания."></span></label>
                    <select name="cron_list[<?php echo $key_list?>][on]" class="form-control">
                      <option value="0" <?php echo ($cron['on']==0)?'selected':''?>>Выкл</option>
                      <option value="1" <?php echo ($cron['on']==1)?'selected':''?>>Вкл</option>
                    </select>
                  </div>
                </div>

                <div class="col-sm-3">

                  <div class="col-sm-3">
                    <label for="input-pause">Часы<span data-toggle="tooltip" data-original-title="Здесь вы можете указать в котором часу выполнять задание. Вы можете указать конкретно час в котором разрешено выполнять задание к примеру '3' . Либо указать период '3-5' . Время указывается в 24х часовом формате."></span></label>
                    <input name="cron_list[<?php echo $key_list?>][time_hour]" type="text" value="<?php echo @$cron['time_hour']?>" class="form-control">
                  </div>
                  <div class="col-sm-3">
                    <label for="input-pause">Дни/мес.<span data-toggle="tooltip" data-original-title="В данном поле вы можете выбрать день месяца в который модуль будет запускать выполнение задания. Либо период к примеру с первого дня до двадцатый день месяца '1-20'"></span></label>
                    <input name="cron_list[<?php echo $key_list?>][time_day]" type="text" value="<?php echo @$cron['time_day']?>" class="form-control">
                  </div>
                  <div class="col-sm-3">
                    <label for="input-pause">Дни/нед.<span data-toggle="tooltip" data-original-title="В данном поле вы можете выбрать в какой день недели выполнять задание, либо с какого дня по какой. 1 = понедельнику, 2 = вторнику ..... 7 = воскресение. Что бы запускать в любой день недели укажите '*'"></span></label>
                    <input name="cron_list[<?php echo $key_list?>][time_week]" type="text" value="<?php echo @$cron['time_week']?>" class="form-control">
                  </div>
                  <div class="col-sm-3">
                    <label for="">&nbsp;</label>
                    <button type="submit" class="btn btn-danger" name="task_del" value="<?php echo $cron['id']?>"><i class="fa fa-minus-circle" aria-hidden="true"></i> Удалить</button>
                  </div>
                  <br>
                </div>
              </div>
              <br>
              <legend>Настройки параметров парсинга в кроне</legend>
              <div class="row">
                <div class="col-sm-9">
                  <div class="col-sm-2">
                    <label for="input-pause">Кол-во потоков<span data-toggle="tooltip" data-original-title="Кол-во потоков это количество ссылок которое модуль будет парсить за один запрос, чем выше количество потоков тем быстрее модуль спасрить все ссылки. Но тем выше риск ПОЛУЧИТЬ БАН за аномальную активность на сайте доноре."></span></label>
                    <select class="form-control" name="cron_list[<?php echo $key_list?>][thread]">
                      <option value="1" <?php echo ($cron['thread']==1)?'selected':''?>>1 поток</option>
                      <option value="2" <?php echo ($cron['thread']==2)?'selected':''?>>2 потока</option>
                      <option value="3" <?php echo ($cron['thread']==3)?'selected':''?>>3 потока</option>
                      <option value="4" <?php echo ($cron['thread']==4)?'selected':''?>>4 потока</option>
                      <option value="5" <?php echo ($cron['thread']==5)?'selected':''?>>5 потоков</option>
                    </select>
                  </div>
                  <div class="col-sm-2">
                    <label for="input-pause">Пауза парсинга<span data-toggle="tooltip" data-original-title="Пауза между запросами к сайту донору. Указывается в секундах. Так же возможно указывать диапазон. К примеру 0-5 в этом случаи будет разная пауза между запросами, рандомно в диапазоне от нуля до пяти секунд."></span></label>
                    <input name="cron_list[<?php echo $key_list?>][pause]" type="text" min="0" value="<?php echo @$cron['pause']?>" class="form-control">
                  </div>
                  <div class="col-sm-3">
                    <label for="input-pause">Кэш<span data-toggle="tooltip" data-original-title="Данная настройка отвечает за то откуда модуль будет брать код сайта, из кэша модуля или делать запрос на сайт донор. Так же отвечает за создание новый страниц кэша. Не рекомендуется создавать кэш в момент сбора ссылок."></span></label>
                    <select name="cron_list[<?php echo $key_list?>][cache_page]" class="form-control">
                      <option value="0" <?php echo ($cron['cache_page']==0)?'selected':''?>>Не использовать кэш</option>
                      <option value="1" <?php echo ($cron['cache_page']==1)?'selected':''?>>Создавать/Использовать кэш если есть</option>
                      <option value="2" <?php echo ($cron['cache_page']==2)?'selected':''?>>Парсить и обновлять кэш</option>
                    </select>
                  </div>
                </div>
                <div class="col-sm-3">
                  <div class="pull-right">
                    <label for="">&nbsp;</label>
                    <button type="submit" class="btn btn-warning" name="rest_task" value="<?php echo $cron['id']?>"><i class="fa fa-refresh" aria-hidden="true"></i> Рестарт задания</button>
                  </div>
                </div>
              </div>
              <br>
              <legend>Дополнительные действия. [Редактор товаров]</legend>
              <div id="tools_tab-<?php echo $cron['id']?>">
                <?php if(!empty($cron['tools'])){?>
                  <?php foreach($cron['tools'] as $key_tools => $tools){?>
                    <div class="row" id="select-<?php echo $key_list?>-<?php echo $key_tools?>">
                      <?php if($key_tools > 0){ echo '<br>';}?>
                      <div class="col-sm-2">
                        <select class="form-control" form="form_preview" name="cron_list[<?php echo $key_list?>][ptts][<?php echo $key_tools?>][pt_id]">
                          <option value="0">Выберите шаблон редактора товаров</option>

                          <?php foreach($patterns as $pattern){?>
                            <?php if($pattern['dn_id'] == $cron['dn_id']){?>
                              <option value="<?php echo $pattern['id']?>" <?php echo ($pattern['id'] == $tools['pt_id'])?'selected':''?>><?php echo $pattern['name']?></option>
                            <?php }?>
                          <?php }?>

                        </select>
                      </div>
                      <div class="col-sm-2">
                        <select class="form-control" form="form_preview" name="cron_list[<?php echo $key_list?>][ptts][<?php echo $key_tools?>][when_do]">
                          <option value="0">Когда выполнять ?</option>
                          <option value="1" <?php echo ($tools['when_do'] == '1')?'selected':''?>>Перед началом выполенения задания</option>
                          <option value="2" <?php echo ($tools['when_do'] == '2')?'selected':''?>>После завершения выполнения задания</option>
                        </select>
                      </div>
                      <div class="col-sm-1">
                        <button type="button" onclick="$('#select-<?php echo $key_list?>-<?php echo $key_tools?>').remove()" class="btn btn-danger" title="Удалить действие"><i class="fa fa-trash-o"></i></button>
                      </div>
                    </div>
                  <?php }?>
                <?php }?>
              </div>
              <br>
              <button type="button" onclick="addNewToolsToProject(<?php echo $key_list?>,<?php echo $cron['id']?>,<?php echo $cron['dn_id']?>)" class="btn btn-primary btn-sm">
                <i class="fa fa-plus-circle"></i> Добавить действия
              </button>
            </div>
            </div>
            <?php }?>
        </div>
        </form>
      </div>
    </div>
  </div><!-- /content -->
</div>
<script>
  $("#cron_add_task").bind("change", function () {
    var type_tisk = $("#cron_add_task").val();
    $("#pr_grab").hide();
    $("#pr_csv").hide();
    $("#pr_im").hide();
    
    if(type_tisk == 1) {
      $("#pr_grab").show();
    }
    if(type_tisk == 2) {
      $("#pr_csv").show();
    }
    if(type_tisk == 3){
      $("#pr_im").show();
    }

    console.log(type_tisk);
  });

  var tools_key = <?php echo $tools_last_key?>;

  function addNewToolsToProject(key_list, task_id, dn_id){
    tools_key[task_id]++;
    var i = tools_key[task_id];
    //Работаем с доб заданиями.
    var  patterns = <?php echo $patterns_json?>;
    //patterns = $.parseJSON(patterns);
    //console.log( task_id );
    //console.log( patterns );
    var html = '';
    html += '<div class="row" id="select-'+key_list+'-'+i+'">';
    if(i >= 1){
      html += '<br>';
    }
    html +=   '<div class="col-sm-2">';
    html +=     '<select class="form-control" form="form_preview" name="cron_list['+key_list+'][ptts]['+i+'][pt_id]">';
    html +=       '<option value="0">Выберите шаблон редактора товаров</option>';
    patterns.forEach(function(pattern, i, patterns) {
      if(pattern.dn_id == dn_id){
        console.log(pattern);
        html +=       '<option value="'+pattern.id+'">'+pattern.name+'</option>';
      }
    });
    html +=     '</select>';
    html +=   '</div>';
    html +=   '<div class="col-sm-2">';
    html +=     '<select class="form-control" form="form_preview" name="cron_list['+key_list+'][ptts]['+i+'][when_do]">';
    html +=       '<option value="0">Когда выполнять ?</option>';
    html +=       '<option value="1">Перед началом выполенения задания</option>';
    html +=       '<option value="2">По окончанию выполнения задания</option>';
    html +=     '</select>';
    html +=   '</div>';
    html += '  <div class="col-sm-1">';
    html += '    <button type="button" onclick="$(\'#select-'+key_list+'-'+i+'\').remove()" class="btn btn-danger" title="Удалить действие"><i class="fa fa-trash-o"></i></button>';
    html += '  </div>';
    html += '</div>';
    

    $('#tools_tab-'+task_id).append(html);
  }

</script>
<style>
  .progress span {
    position: absolute;
    display: block;
    width: 100%;
    color: black;
  }

  label > span:after {
    font-family: FontAwesome;
    color: #1E91CF;
    content: "\f059";
    margin-left: 4px;
  }
</style>
<?php echo $footer; ?>