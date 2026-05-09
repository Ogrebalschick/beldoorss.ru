<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER ========== -->
  <div class="page-header">
    <div class="container-fluid">
      <!-- USER TOOLS -->
      <div class="pull-right">
        <button name="save_replace" type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-primary"
                data-original-title="Сохранить настройки">
          <i class="fa fa-save"></i>
        </button>
        <button name="refresh" type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-default"
                data-original-title="Обновить страницу">
          <i class="fa fa-refresh"></i>
        </button>
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
      <i class="fa fa-info-circle"></i><?php echo @$error?>
    </div>
    <?php }elseif(@$success){ ?>
    <div class="alert alert alert-success">
      <i class="fa fa-info-circle"></i><?php echo @$success?>
    </div>
    <?php }?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Редактирование проекта <?php echo '<b>['.$setting['dn_name'].']</b>'?></h3>
      </div>
      <div class="panel-body">
        <!-- NAVIGATION -->
        <ul class="nav nav-tabs">
          <?php foreach($mpage as $page){ ?>
          <li role="presentation" class="<?php echo $page['active']?>">
            <a href="<?php echo $page['href']?>" id="home-tab" role="tab" aria-controls="home"
               aria-expanded="true"><?php echo $page['title']?></a>
          </li>
          <?php }?>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active">
            <!-- simpleparspage start -->
            <style>
            select{
              height: auto !important;
            }
            </style>
            <div class="col-sm-5 col-md-4 col-lg-3">
              <div class="panel panel-default">
                <div class="panel-heading">Выберите границу парсинга</div>
                <div class="panel-body">
                  <form class="form-horizontal" name="myForm" method="POST">
                    <select class="form-control" id="" size="18" multiple onchange="window.location.href=this.options[this.selectedIndex].value">
                      <optgroup label="Простые">
                        <?php foreach($params as $param){ ?>
                        <?php if($param['type'] == 1){ ?>
                        <option id="<?php echo $param['id']?>" value="<?php echo $get_param_href.$param['id']?>"
                                class="<?php echo $param['class']?>">
                                <?php echo $param['name'].' | {gran_'.$param['id'].'}'?></option>
                        <?php }?>
                        <?php }?>
                      </optgroup>

                    </select>
                    <hr>
                    <select class="form-control" size="18" multiple onchange="window.location.href=this.options[this.selectedIndex].value">
                      <optgroup label="Повторяющиеся">
                        <?php foreach($params as $param){ ?>
                        <?php if($param['type'] == 2){ ?>
                        <option value="<?php echo $get_param_href.$param['id']?>" class="<?php echo ($param_id == $param['id'])?'btn btn-success btn-sm btn-block':'btn btn-default btn-sm btn-block'?>"><?php echo '@ '.$param['name'].' | {gran_'.$param['id'].'}'?></option>
                        <?php }?>
                        <?php }?>
                      </optgroup>
                    </select>
                  </form>
                </div>
              </div>
            </div>
            <div class="col-sm-7 col-md-8 col-lg-9">
              <div class="panel panel-default">
                <div class="panel-heading">Настройка границ парсинга 
                  <samp class="text-danger"><b><?php echo '['.$param_name.']'?></b></samp>
                  <samp class="text-info"><b><?php echo ($param_id != 0)?'{gran_'.$param_id.'}':''?></b></samp>
                </div>
                <div class="panel-body">
                  <form class="form-horizontal" id="form" method="post">
                    <div class="form-group required">
                      <div class="col-sm-3">
                        <label for="replance_start">Добавить в начало</label>
                        <input class="form-control" name="text_start" type="text"
                               value="<?php echo @$replace['text_start']?>" id="text_start">
                      </div>
                      <div class="col-sm-3">
                        <label for="replance_stop">Добавить в конец</label>
                        <input class="form-control" name="text_stop" type="text" value="<?php echo @$replace['text_stop']?>"
                               id="text_stop">
                      </div>
                      <div class="col-sm-3">
                        <label for="replance_stop">Наценка</label>
                        <input class="form-control" name="arithm" type="text" value="<?php echo @$replace['arithm']?>"
                               id="arithm">
                      </div>
                      <div class="col-sm-3">
                        <label for="replance_search">Захешировать значение (MD5)</label>
                        <select class="form-control" name="hash">
                          <option value="0"
                          <?php echo @($replace['hash']==0)?'selected':''?>>Не хешировать</option>
                          <option value="4" style="color: #a94442;"
                          <?php echo @($replace['hash']==4)?'selected':''?>>Хешировать 4 символа (не рекомендую)</option>
                          <option value="8"
                          <?php echo @($replace['hash']==8)?'selected':''?>>Хешировать 8 символов</option>
                          <option value="9"
                          <?php echo @($replace['hash']==9)?'selected':''?>>Хешировать 9 символов</option>
                          <option value="10"
                          <?php echo @($replace['hash']==10)?'selected':''?>>Хешировать 10 символов</option>
                          <option value="11"
                          <?php echo @($replace['hash']==11)?'selected':''?>>Хешировать 11 символов</option>
                          <option value="12"
                          <?php echo @($replace['hash']==12)?'selected':''?>>Хешировать 12 символов</option>
                          <option value="13"
                          <?php echo @($replace['hash']==13)?'selected':''?>>Хешировать 13 символов</option>
                          <option value="14"
                          <?php echo @($replace['hash']==14)?'selected':''?>>Хешировать 14 символов</option>
                          <option value="15"
                          <?php echo @($replace['hash']==15)?'selected':''?>>Хешировать 15 символов</option>
                          <option value="16"
                          <?php echo @($replace['hash']==16)?'selected':''?>>Хешировать 16 символов</option>
                          <option value="17"
                          <?php echo @($replace['hash']==17)?'selected':''?>>Хешировать 17 символов</option>
                          <option value="18"
                          <?php echo @($replace['hash']==18)?'selected':''?>>Хешировать 18 символов</option>
                          <option value="19"
                          <?php echo @($replace['hash']==19)?'selected':''?>>Хешировать 19 символов</option>
                          <option value="20"
                          <?php echo @($replace['hash']==20)?'selected':''?>>Хешировать 20 символов</option>
                          <option value="21"
                          <?php echo @($replace['hash']==21)?'selected':''?>>Хешировать 21 символов</option>
                          <option value="22"
                          <?php echo @($replace['hash']==22)?'selected':''?>>Хешировать 22 символов</option>
                          <option value="23"
                          <?php echo @($replace['hash']==23)?'selected':''?>>Хешировать 23 символов</option>
                          <option value="24"
                          <?php echo @($replace['hash']==24)?'selected':''?>>Хешировать 24 символов</option>
                          <option value="25"
                          <?php echo @($replace['hash']==25)?'selected':''?>>Хешировать 25 символов</option>
                          <option value="26"
                          <?php echo @($replace['hash']==26)?'selected':''?>>Хешировать 26 символов</option>
                          <option value="27"
                          <?php echo @($replace['hash']==27)?'selected':''?>>Хешировать 27 символов</option>
                          <option value="28"
                          <?php echo @($replace['hash']==28)?'selected':''?>>Хешировать 28 символов</option>
                          <option value="29"
                          <?php echo @($replace['hash']==29)?'selected':''?>>Хешировать 29 символов</option>
                          <option value="30"
                          <?php echo @($replace['hash']==30)?'selected':''?>>Хешировать 30 символов</option>
                          <option value="31"
                          <?php echo @($replace['hash']==31)?'selected':''?>>Хешировать 31 символов</option>
                          <option value="32"
                          <?php echo @($replace['hash']==32)?'selected':''?>>Хешировать 32 символов</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-12">
                        <label for="replance_search">Правила поиск замены</label>
                        <textarea name="rules" rows="10" class="col-sm-12 form-control"><?php echo @$replace['rules']?></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-md-12">
                        <label for="replance_intxt">Исходный текст</label>
                        <textarea name="text_give" rows="10" class="col-sm-12 form-control" <?php echo (!empty($param_type) && $param_type == 2)?'readonly':''?>><?php echo @$show['text_give']?></textarea>
                      </div>                      
                    </div>
                    <div class="form-group">
                      <div class="col-md-12">
                        <label for="replance_fortxt">Текст после обработки</label>
                        <textarea name="text_get" rows="10" class="col-sm-12 form-control"><?php echo @$show['text_get']?></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-2">
                        <button name="check_text" type="submit" form="form" class="btn btn-primary">Преобразовать</button>
                      </div>
                      <!--div class="col-sm-2">
                        <button name="download_param" type="submit" class="btn btn-default">Спарсить границу</button>
                      </div-->
                      <div class="col-sm-3">
                        <div class="btn-group" role="group" aria-label="...">
                          <button type="submit" name="download_param_and_check" class="btn btn-warning">Сп+Преоб.</button>
                          <button type="submit" name="download_param" class="btn btn-default">Спарсить границу</button>
                        </div>
                      </div>
                      <div class="col-sm-3">
                        <select name="download_link" class="form-control">
                          <option value="0">Выберите ссылку</option>
                          <?php foreach($replace_links as $link){ ?>
                          <option value="<?php echo $link['link']?>"><?php echo $link['link']?></option>
                          <?php }?>
                        </select>
                      </div>
                      <div class="col-sm-4">
                          <input type="text" name="view_href" class="form-control" value="<?php echo $view_href?>" placeholder="Вставьте ссылку на страницу сайта, что бы получить код">
                      </div>
                    </div>
                  </form>
                </div>
              </div>


            </div>
            <!-- /simpleparspage stop-->
          </div>
        </div>
      </div>
    </div>
  </div><!-- /content -->
</div>
<?php echo $footer; ?>
