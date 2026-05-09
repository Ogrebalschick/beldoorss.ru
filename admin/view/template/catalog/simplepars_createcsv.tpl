<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER ========== -->
  <div class="page-header">
    <div class="container-fluid">
      <!-- USER TOOLS -->
      <div class="pull-right">
        <button id="pars_data_start" type="button" form="form" data-toggle="tooltip" class="btn btn-success" data-original-title="Старт парсинга">
          <i class="fa fa-play" aria-hidden="true"></i>
        </button>
        <button id="stop_grab" type="submit" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="Стоп/Пауза парсинга">
          <i class="fa fa-stop" aria-hidden="true"></i>
        </button>
        <button name="save_form_csv" type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Сохранить настройки">
          <i class="fa fa-save"></i>
        </button>
        <button name="update_grab" type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-info" data-original-title="Обновить страницу">
          <i class="fa fa-refresh"></i>
        </button>

      </div>
      <h1>SimplePars</h1>
      <!-- BREADCRUMBS -->
      
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $bread){ ?>
        <li><a href="<?php echo $bread['href']?>"><?php echo $bread['text']?></a></li>
        <?php }?>
      </ul>
    </div>
  </div><!-- /header -->
  <form class="form-horizontal" id="form_show" method="POST"></form>
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
    <div class="alert alert alert-success" hidden id="msg">
      <i class="fa fa-info-circle"></i><?php echo @$text_grab_link_and?>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Редактирование проекта <?php echo '<b>['.$setting['dn_name'].']</b>'?></h3>
      </div>
      <div class="panel-body">
          <!-- NAVIGATION -->
          <ul class="nav nav-tabs">
            <?php foreach($mpage as $page){ ?>
            <li role="presentation" class="<?php echo $page['active']?>">
              <a href="<?php echo $page['href']?>" id="home-tab" role="tab" aria-controls="home" aria-expanded="true"><?php echo $page['title']?></a>
            </li>
            <?php }?>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active">
              <!-- simpleparspage start -->
              <form class="form-horizontal" id="form" method="POST">
              <div class="row">
                <div class="col-sm-12">
                  <div id="progress" hidden>
                    <div class="col-sm-12">
                      <div class="progress">
                        <div id="pross" class="progress-bar progress-bar-warning progress-bar-striped active"
                             style="width: 0%;">
                          <span id="info_count" class="show"></span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="form-group required">
                <div class="col-sm-1"></div>
                <div class="col-sm-5">              
                  <p class="text-center" style="margin: 25px">
                    <span id="link_scan_count" class="text-danger"></span> | <span id="link_count" class="text-success"></span> | <span id="link_full"></span>
                  </p>
                </div>
                <div class="col-sm-2">
                  <label for="">Выбор списка ссылок</label>
                  <select name="link_list" id="link_list" class="form-control input-sm">
                    <option value="">Все ссылки</option>
                    <?php foreach($link_lists as $link_list){?>
                    <option value="<?php echo $link_list['id']?>" <?php echo ($setting['link_list'] == $link_list['id'])?'selected':''?>><?php echo $link_list['name']?></option>
                    <?php }?>
                  </select>
                </div>
                <div class="col-sm-2">
                  <label for="">Ссылки с ошибками</label>
                  <select name="link_error" id="link_error" class="form-control input-sm">
                    <option value="">Все ссылки</option>
                    <?php foreach($link_errors as $link_error){?>
                    <option value="<?php echo $link_error?>" <?php echo ($setting['link_error'] == $link_error)?'selected':''?>><?php echo $link_error?></option>
                    <?php }?>
                  </select>
                </div>
                <div class="col-sm-2">
                    <button type="button" id="links_restart" class="btn btn-warning btn-sm" style="margin-top: 20px"><i class="fa fa-refresh"></i> Перезагрузить ссылки
                    </button>
                  </div>
              </div>
              <div class="well">
                <div class="form-group required">
                  <div class="col-sm-1 col-lg-1">
                    <label for="">Название CSV</label>
                    <input class="form-control" name="csv_name" type="text" id="csv_name" value="<?php echo $setting['csv_name']?>">
                  </div>
                  <div class="col-sm-1">
                    <label for="input-pause">Потоки<span data-toggle="tooltip" data-original-title="Кол-во потоков это количество ссылок которое модуль будет парсить за один запрос, чем выше количество потоков тем быстрее модуль спасрить все ссылки. Но тем выше риск ПОЛУЧИТЬ БАН за аномальную активность на сайте доноре."></span></label>
                    <select class="form-control" name="thread">
                      <option value="1" <?php echo @($setting['thread']==1)?'selected':''?>>1 поток</option>
                      <option value="2" <?php echo @($setting['thread']==2)?'selected':''?>>2 потока</option>
                      <option value="3" <?php echo @($setting['thread']==3)?'selected':''?>>3 потока</option>
                      <option value="4" <?php echo @($setting['thread']==4)?'selected':''?>>4 потока</option>
                      <option value="5" <?php echo @($setting['thread']==5)?'selected':''?>>5 потоков</option>
                    </select>
                  </div>
                  <div class="col-sm-2 col-lg-1">
                    <label for="">Пауза</label>
                    <input class="form-control" name="pars_pause" type="text" value="<?php echo $setting['pars_pause']?>">
                  </div>
                  <div class="col-sm-2 col-lg-1">
                    <label for="">Разделитель</label>
                    <input class="form-control" name="csv_delim" type="text"
                           value="<?php echo (!$setting['csv_delim'])?';':$setting['csv_delim']?>"
                           maxlength="1">
                  </div>
                  <!--div class="col-sm-2 col-lg-1">
                    <label for="">Экранирование</label>
                    <input class="form-control" name="csv_escape" type="text"
                           value="<?php echo (!$setting['csv_escape'])?'&quot;':$setting['csv_escape']?>" maxlength="1">
                  </div-->
                  <div class="col-sm-2 col-lg-2">
                    <label for="">Кодировка прайса</label>
                    <select class="form-control" name="csv_charset">
                      <option value="1" <?php echo ($setting['csv_charset'] == 1)?'selected':''?>>Windows-1251</option>
                      <option value="2" <?php echo ($setting['csv_charset'] == 2)?'selected':''?>>UTF-8</option>
                    </select>
                  </div>
                  <div class="col-sm-2">
                    <!--label for="">&nbsp;</label> <br>
                    <button type="submit" name="links_restart" class="btn btn-default">Перезагрузить ссылки</button-->
                  </div>
                  <div class="col-sm-2">
                    <label for="">Кэш</label>
                    <select name="cache_page" class="form-control">
                      <option value="0" <?php echo ($browser['cache_page']==0)?'selected':''?>>Не использовать кэш</option>
                      <option value="1" <?php echo ($browser['cache_page']==1)?'selected':''?>>Создавать/Использовать кэш если есть</option>
                      <option value="2" <?php echo ($browser['cache_page']==2)?'selected':''?>>Парсить и обновлять кэш</option>
                    </select>
                  </div>
                  <div class="col-sm-2 col-lg-2">
                    <label for="">&nbsp;</label> <br>
                    <button name="download_csv" value="1" type="submit" form="form" data-toggle="tooltip" class="btn btn-default" data-original-title="Скачать прайс" <?php echo ($csv_exists)?'':'disabled'?>>
                      <i class="fa fa-download"></i> Скачать прайс
                    </button>
                    <button name="del_csv" type="submit" value="1" form="form" data-toggle="tooltip" class="btn btn-danger" data-original-title="Удалть прайс" <?php echo ($csv_exists)?'':'disabled'?>>
                      <i class="fa fa-trash-o"></i>
                    </button>
                  </div>

                </div>
              </div>
              <hr>
              <div class="row">
                <div class="col-md-2">
                  <input form="form_show" class="btn btn-success" type="submit" name="go_show" value="Пред просмотр">
                </div>
                <div class="col-md-6">
                  <select class="form-control" name="view_href" form="form_show">
                    <option value="0">Выберите ссылку</option>
                    <?php foreach($links_select as $link_count => $link){?>
                      <option value="<?php echo $link['link']?>"><?php echo "[".$link_count."] ".$link['link']?></option>
                    <?php }?>
                    </select>
                  </div>
                  <div class="col-sm-4">
                    <input type="text" name="view_href2" form="form_show" class="form-control" value="<?php echo $view_href?>" placeholder="Вставьте ссылку что бы произвести пред просмотр парсинга.">
                  </div>
              </div>
              <br>
              <?php if(!empty($show)){ ?>
              <div class="row">
                <div class="col-md-12">
                  <div class="table-responsive">
                    <table class="table table-bordered">
                      <thead>
                        <tr>
                        <?php foreach($show['title'] as $title){ ?>
                          <th><?php echo $title?></th>
                        <?php }?>
                        </tr>
                        </thead>
                        <?php foreach($show['value'] as $table){ ?>
                          <tr>
                          <?php foreach($table as $value){ ?>
                            <td style="vertical-align: text-top"><pre style="border:0; background-color: #fff;"><?php echo $value?></pre></td>
                          <?php }?>
                          </tr>
                        <?php }?>
                    </table>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <?php if(!empty($show['permit_grans_text'])){?>
                  <h2 class="text-danger"><?php echo $show['permit_grans_text']?></h2>
                  <?php }?>
                </div>
              </div>
              <?php }?>
              <hr>
              <div class="tab-pane active" id="tab-recurring">
                <div class="table-responsive">
                  <style>
                    textarea[data-description] {
                      resize: none;
                      height: 26px;
                      padding: 4px 9px;
                      transition: ease-in-out, width .35s ease-in-out;
                      overflow:  hidden;
                    }
                    textarea[data-description]:focus {
                      height: 102px;
                      transition: 0.5s linear;
                      overflow: scroll;
                    }
                  </style>
                  <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                      <th class="text-left col-sm-2">Название колонки в прайс листе CSV</th>
                      <td class="text-left">Значение</td>
                      <td class="text-left col-sm-1">Резервация колонок</td>
                      <td class="text-left col-sm-2">Выбор параметра парсинга</td>
                      <td class="text-left col-sm-1"></td>
                    </tr>
                    </thead>
                    <tbody >
                    <?php foreach($formcsv as $keyc => $form){ ?>
                    <tr id="recurring-row-<?php echo $keyc?>">
                      <td class="left">
                        <input type="text" name="csv[<?php echo $keyc?>][name]" class="form-control input-sm" value="<?php echo @$form['name']?>">
                      </td>
                      <td class="left">
                        <textarea id="<?php echo $keyc?>" name="csv[<?php echo $keyc?>][value]" class="form-control" data-description="comments"><?php echo @$form['value']?></textarea>
                      </td>
                      <td class="left">
                        <input type="number" name="csv[<?php echo $keyc?>][csv_column]" class="form-control input-sm" value="<?php echo @$form['csv_column']?>">
                      </td>
                      <td class="left">
                        <select id="selectBox" class="form-control input-sm" id="value-border-1" 
                          onchange="document.getElementById(<?php echo $keyc?>).value+=value+''">
                          <option value="">Выберите границу парсинга</option>
                          <?php foreach($params as $param){ ?>
                          <option value="{gran_<?php echo $param['id']?>}">
                            <?php echo ($param['type'] == 2) ? '@ '.$param['name'] : $param['name']?>
                            <?php echo '| {gran_'.$param['id'].'}'?>
                          </option>
                          <?php }?>
                        </select>
                      </td>

                      <td class="text-left">
                        <button type="button" onclick="$('#recurring-row-<?php echo $keyc?>').remove()" data-toggle="tooltip"
                                title="" class="btn btn-danger btn-sm" data-original-title="Удалить"><i
                                  class="fa fa-minus-circle"></i>
                        </button>
                      </td>
                    </tr>
                    <?php }?>
                    </tbody>
                    <tfoot>
                    <tr>
                      <td colspan="4"></td>
                      <td class="text-left">
                        <button type="button" onclick="addRecurring()" data-toggle="tooltip" title=""
                                class="btn btn-primary btn-sm" data-original-title="Добавить повторно"><i
                                  class="fa fa-plus-circle"></i></button>
                      </td>
                    </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
        <!-- /simpleparspage stop-->
      </div>
    </div>
  </div>
</div>
<div class="panel panel-default">
  <div class="panel-heading">Настройки допуска к обработке страницы</div>
  <div class="panel-body">
    <div class="row">
    <div class="col-sm-2">
    <label class="control-label">Использовать проверку границ?</label>
      <select name="grans_permit" class="form-control">
        <option value="1" <?php echo ($setting['grans_permit']==1)?'selected':''?>>Да</option>
        <option value="0" <?php echo ($setting['grans_permit']==0)?'selected':''?>>Нет</option>
      </select>
    </div>
    </div>
    <br>

    <div id="grans_permit_list">
      <?php if(!empty($setup['grans_permit_list'])){?>
      <?php foreach($setup['grans_permit_list'] as $gl_key => $gran_list){?>
      <div class="row" id="gran_row-<?php echo $gl_key?>">
        <div class="col-sm-1">
          <label class="control-label">Вкл/Выкл <span data-toggle="tooltip" data-original-title="Включает и выключает выполнение этого правила."></label>
          <select name="grans_permit_list[<?php echo $gl_key?>][switch]" class="form-control" form="form">
            <option value="1" <?php echo ($gran_list['switch']==1)?'selected':''?>>Вкл</option>
            <option value="0" <?php echo ($gran_list['switch']==0)?'selected':''?>>Выкл</option>
          </select>
        </div>
        <div class="col-sm-2">
          <label class="control-label">Название <span data-toggle="tooltip" data-original-title="Названия правила, будет отображается в логах модуля."></label>
          <input name="grans_permit_list[<?php echo $gl_key?>][name]" type="text" value="<?php echo @$gran_list['name']?>" class="form-control" form="form">
        </div>
        <div class="col-sm-2">
          <label class="control-label">Граница <span data-toggle="tooltip" data-original-title="Здесь вы можете указать границу парсинга которую будет проверяться. Обратите внимание что можно указывать не одну границу а несколько, в таком случаи данные из гарниц объединятся и правило будет применено к этим данным."></label>
          <input name="grans_permit_list[<?php echo $gl_key?>][gran]" id="gran_spot-<?php echo $gl_key?>" type="text" value="<?php echo @$gran_list['gran']?>" class="form-control" form="form">
        </div>
        <div class="col-sm-1">
          <label class="control-label">Загрузить если <span data-toggle="tooltip" data-original-title="Выбираете как вы хотите проверить границу парсинга. Если граница проходит проверку тогда эта ссылка будет допущена к обработке."></label>
          <select name="grans_permit_list[<?php echo $gl_key?>][operator]" class="form-control" form="form">
            <option value="1" <?php echo ($gran_list['operator']==1)?'selected':''?>>Не пустая</option>
            <option value="2" <?php echo ($gran_list['operator']==2)?'selected':''?>>Пустая</option>
            <option value="3" <?php echo ($gran_list['operator']==3)?'selected':''?>>Равна = </option>
            <option value="4" <?php echo ($gran_list['operator']==4)?'selected':''?>>Не равна != </option>
            <option value="8" <?php echo ($gran_list['operator']==8)?'selected':''?>>Больше/Равно >= </option>
            <option value="9" <?php echo ($gran_list['operator']==9)?'selected':''?>>Меньше/Равно <= </option>
            <option value="5" <?php echo ($gran_list['operator']==5)?'selected':''?>>Содержит %значение%</option>
            <option value="6" <?php echo ($gran_list['operator']==6)?'selected':''?>>Не содержит %значение%</option>
            <option value="7" <?php echo ($gran_list['operator']==7)?'selected':''?>>Регулярное выражение</option>
          </select>
        </div>
        <div class="col-sm-2">
          <label class="control-label">С чем сравнивать <span data-toggle="tooltip" data-original-title="В этом поле вы указываете текст с которым хотите сравнить границу парсинга и определить грузить данные по этой ссылке или нет."></label>
          <input name="grans_permit_list[<?php echo $gl_key?>][value]" type="text" value="<?php echo @$gran_list['value']?>" class="form-control" form="form">
        </div>
        <div class="col-sm-2">
          <label class="control-label">Когда проверять <span data-toggle="tooltip" data-original-title="Выбор при каких условиях проверять границу парсинга. Добавление товара, Обновления товара или в обоих случаях."></label>
          <select name="grans_permit_list[<?php echo $gl_key?>][when_check]" class="form-control" form="form">
            <option value="1" <?php echo ($gran_list['when_check']==1)?'selected':''?>>Добавление</option>
            <option value="2" <?php echo ($gran_list['when_check']==2)?'selected':''?>>Обновление</option>
            <option value="3" <?php echo ($gran_list['when_check']==3)?'selected':''?>>Добавление и Обновление</option>
            <option value="4" <?php echo ($gran_list['when_check']==4)?'selected':''?>>Парсинг в csv</option>
          </select>
        </div>
        <div class="col-sm-1">
          <label class="control-label">Границы <span data-toggle="tooltip" data-original-title="Выбор границы парсинга."></label>
          <select class="form-control" onchange="document.getElementById('gran_spot-<?php echo $gl_key?>').value+=value+''">
            <option value="">Выберите границу парсинга</option>
            <?php foreach($params as $param){ ?>
              <option value="{gran_<?php echo $param['id']?>}"> <?php echo $param['name']. '| {gran_'.$param['id'].'}'?></option>
            <?php }?>
          </select>
        </div>
        <div class="col-sm-1">
          <button type="button" onclick="$('#gran_row-<?php echo $gl_key?>').remove()" class="btn btn-danger" style="margin-top: 20px" title="Удалить"><i class="fa fa-trash-o"></i></button>
        </div>
      </div>
      <?php }?>
      <?php }?>
    </div>
    <br>
    <button type="button" onclick="addParamPermit()" class="btn btn-primary btn-sm"><i class="fa fa-plus-circle"></i> Добавить проверочное поле</button>


  </div>
  </form>
</div>
</div><!-- /content -->

</div>

<script type="text/javascript"><!--
  var recurring_row =<?php echo  ($key_finish) ? ($key_finish + 1) : '1' ?>;

  function addRecurring() {
        html = '<tr id="recurring-row-' + recurring_row + '">';
        html += '  <td class="left">';
        html += '    <input type="text" name="csv[' + recurring_row + '][name]" class="form-control" value="">';
        html += '    </select>';
        html += '  </td>';
        html += '<td class="left">';
        html += '<textarea id="' + recurring_row + '" name="csv[' + recurring_row + '][value]" class="form-control"></textarea>';
        html += '</td>';
        html += '<td class="left">'
        html +=   '<input type="number" name="csv[' + recurring_row + '][csv_column]" class="form-control input-sm" value="">'
        html += '</td>'

        html += '  <td class="left">';
        html += '    <select class="form-control" id="value-border-1" onchange="document.getElementById('+ recurring_row +').value+=value">';
        html += '      <option value="0">Выберите параметр парсинга</option>';
        <?php foreach($params as $param){
          if($param['type']==1){
            echo 'html += \'      <option value="{gran_'.$param['id'].'}">'.$param['name'].' | {gran_'.$param['id'].'}</option>\';'.PHP_EOL;
          }elseif($param['type']==2){
            echo 'html += \'      <option value="{gran_'.$param['id'].'}">'.'@ '.$param['name'].' | {gran_'.$param['id'].'}</option>\';'.PHP_EOL;
          }
        }?>
        html += '    <select>';
        html += '  </td>';
        html += '  <td class="left">';
        html += '    <a onclick="$(\'#recurring-row-' + recurring_row + '\').remove()" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a>';
        html += '  </td>';
        html += '</tr>';

        $('#tab-recurring table tbody').append(html);

        recurring_row++;
  }
  
  var key_grans = <?php echo $grans_permit_key_max?>;
  var grans_row = key_grans+1;
  function addParamPermit(){
    
    html =' <div class="row" id="gran_row-'+grans_row+'">';
    html +='  <div class="col-sm-1">';
    html +='    <label class="control-label">Вкл/Выкл</label>';
    html +='    <select name="grans_permit_list['+grans_row+'][switch]" class="form-control" form="form">';
    html +='      <option value="1">Вкл</option>';
    html +='      <option value="0">Выкл</option>';
    html +='    </select>';
    html +='  </div>';
    html +='  <div class="col-sm-2">';
    html +='    <label class="control-label">Название</label>';
    html +='    <input name="grans_permit_list['+grans_row+'][name]" type="text" class="form-control" form="form">';
    html +='  </div>';
    html +='  <div class="col-sm-2">';
    html +='    <label class="control-label">Граница</label>';
    html +='      <input name="grans_permit_list['+grans_row+'][gran]" type="text" id="gran_spot-'+grans_row+'" class="form-control" form="form">';
    html +='  </div>';
    html +='  <div class="col-sm-1">';
    html +='    <label class="control-label">Загрузить если</label>';
    html +='    <select name="grans_permit_list['+grans_row+'][operator]" class="form-control" form="form">';
    html +='       <option value="1">Не пустая</option>';
    html +='       <option value="2">Пустая</option>';
    html +='       <option value="3">Равна = </option>';
    html +='       <option value="4">Не равна != </option>';
    html +='       <option value="8">Больше/Равно >= </option>';
    html +='       <option value="9">Меньше/Равно <= </option>';
    html +='       <option value="5">Содержит %значение%</option>';
    html +='       <option value="6">Не содержит %значение%</option>';
    html +='       <option value="7">Регулярное выражение</option>';
    html +='    </select>';
    html +='  </div>';
    html +='  <div class="col-sm-2">';
    html +='    <label class="control-label">С чем сравнивать</label>';
    html +='      <input name="grans_permit_list['+grans_row+'][value]" type="text" class="form-control" form="form">';
    html +='  </div>';
    html +='  <div class="col-sm-2">';
    html +='    <label class="control-label">Когда проверять</label>';
    html +='    <select  name="grans_permit_list['+grans_row+'][when_check]" class="form-control" form="form">';
    html +='      <option value="4">Парсинг в csv</option>';
    html +='      <option value="3">Добавление и Обновление</option>';
    html +='      <option value="1">Добавление</option>';
    html +='      <option value="2">Обновление</option>';
    html +='    </select>';
    html +='  </div>';
    html +='  <div class="col-sm-1">';
    html +='    <label class="control-label">Границы</label>';
    html +='    <select class="form-control" onchange="document.getElementById(\'gran_spot-'+grans_row+'\').value+=value+\'\'">';
    html +='      <option value="">Выберите границу парсинга</option>';
    <?php foreach($params as $param){ ?>
      html +='    <option value="{gran_<?php echo $param['id']?>}"> <?php echo $param['name']. '| {gran_'.$param['id'].'}'?></option>';
    <?php }?>
    html +='    </select>';
    html +='  </div>';
    html +='  <div class="col-sm-1">';
    html +='    <button type="button" onclick="$(\'#gran_row-'+grans_row+'\').remove()" class="btn btn-danger" style="margin-top: 20px" title="Удалить"><i class="fa fa-trash-o"></i></button>';
    html +='  </div>';
    html +='</div>';

    $('#grans_permit_list').append(html);
    grans_row ++;
  }
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#pars_data_start").bind("click", function () {
            var iter = 0;
            var time1 = new Date().getTime();//Работа с временем. Получаем время начала парсинга.
            $("#info_count").text("Спарсено: 0 | В очереди: 0 | Осталось ~ 0сек");
            $("#progress").show();
            job = 1;
            ajaxpars(time1, iter);
        });

        function ajaxpars(time1, iter) {
          iter++;
          $.ajax({
            url: 'index.php?route=catalog/simplepars/parsajax&<?php echo $adap['token']?>&who=pr_csv&dn_id=<?php echo $dn_id?>',
            type: "POST",
            data: 'pars_data_start=1',
            dataType: "html",
            success: function (data) {
              answ = $.parseJSON(data);
              console.log(answ);
              //работа с временем
              var time2 = new Date().getTime();//Получаем время окончания парсинга одной ссылки.
              var time = secondsToHms(time1, time2, answ.other.clink.link_count, iter);
              //Конец
              if (answ.status == 'finish') {
                $("#msg").text(answ.msg);
                $("#msg").show();
                $("#pross").css("width", answ.other.progress + "%");
                $("#link_scan_count").text("Обработано ссылок: " + answ.other.clink.link_scan_count);
                $("#link_count").text("Ссылок в очереди: " + answ.other.clink.link_count);
                $("#progress").hide();
              } else if (answ.status == 'go') {
                $("#pross").css("width", answ.other.progress + "%");
                $("#info_count").text("Спарсено: " + answ.other.clink.link_scan_count + " | В очереди: " + answ.other.clink.link_count + " | Осталось ~ " + time);
                $("#link_scan_count").text("Обработано ссылок: " + answ.other.clink.link_scan_count);
                $("#link_count").text("Ссылок в очереди: " + answ.other.clink.link_count);
                agenpars(time1, iter);
              }
            }
          });
        };

        function agenpars(time1, iter) {
            $("#stop_grab").bind("click", function () {
                $("#progress").hide();
                job = 0;
            });
            if (job == 1) {
                ajaxpars(time1, iter);
            }
            ;
        };
        //Фунция преобразования времени в Ч:М:C
        function secondsToHms(time1, time2, slink, flink) {
          //получаем количество потоков
          var thread = <?php echo $setting['thread']?>;
          flink = flink * thread;
          var link = slink/flink;
          time = Math.round((link*((time2 - time1)/1000)));
          time = Number(time);
          var h = Math.floor(time / 3600);
          var m = Math.floor(time % 3600 / 60);
          var s = Math.floor(time % 3600 % 60);

          return ('0' + h).slice(-2) + ":" + ('0' + m).slice(-2) + ":" + ('0' + s).slice(-2);
        }

    });

    //отсекаем вод русских букв в имени csv файла.
    document.getElementById('csv_name').onkeyup = function () {
      var reg = /[а-яА-ЯёЁ+\\/~^\&\$\#\@\.\*;:\"\'\]\[\>\<\{\}]/g;
      if (this.value.search(reg) !=  -1) {
          this.value  =  this.value.replace(reg, '');
      }
    }
</script>

<script type="text/javascript">
  $(document).ready(function () {
    get_url_stats();
  });
  //если был изменен выбор ссписка
  $("#link_list").bind("change", function () {
    get_url_stats();
  });
  $("#link_error").bind("change", function () {
    get_url_stats();
  });

  //Нажали рестарт, получаем данные о списках и отправляем запрос.
  $("#links_restart").bind("click", function () {
    var data = getSettingUrl();
    data['links_restart'] = 1;
    result = url_ajax(data);
    get_url_stats();
    $("#pross").css("width","0%");
    $("#info_count").text("");
    console.log(result);
  });

  function get_url_stats(){
    data = getSettingUrl();
    urls = url_ajax(data);
    showUrlsStats(urls);
    console.log(urls);
  };

  function url_ajax(data){
    // /var answ;
    $.ajax({
      url: 'index.php?route=catalog/simplepars/ajax&<?php echo $adap['token']?>&who=get_urls&dn_id=<?php echo $dn_id?>',
      type: "POST",
      data: data,
      async: false,
      dataType: "html",
      success: function (data) {
        answ = data;
        answ = $.parseJSON(data);
      }
    });
    //console.log(answ);
    return answ;
  };

  function getSettingUrl(){
    var data_form = {};
    data_form['link_list'] = $("#link_list").val();
    data_form['link_error'] = $("#link_error").val();

    console.log(data_form);
    return data_form;
  }

  function showUrlsStats(urls){
    link_scan = urls['total']-urls['queue'];
    $("#link_scan_count").text("Обработано ссылок: " + link_scan);
    $("#link_count").text("Ссылок в очереди: " + urls['queue']);
    $("#link_full").text("[Ссылок в проекте: " + urls['full'] +"]");
  }
</script>

<style>
  .progress {
    position: relative;
    margin-top: 9px;
  }

  .progress span {
    position: absolute;
    display: block;
    width: 100%;
    color: black;
  }
</style>
<?php echo $footer; ?>
