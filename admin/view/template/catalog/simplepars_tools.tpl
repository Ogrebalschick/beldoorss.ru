<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <!-- ========== HEADER ========== -->
  <div class="page-header">
    <div class="container-fluid">
      <!-- USER TOOLS -->
      <form method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
      <div class="pull-right">
        <button name="update" type="submit" form="form" data-toggle="tooltip" class="btn btn-info"
                data-original-title="Обновить страницу">
          <i class="fa fa-refresh"></i>
        </button>

      </div>
      </form>
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
        <form method="post" enctype="multipart/form-data" id="tools" class="form-horizontal">
        <p class="text-center">
          <span id="resul_act" class="text-success" hidden ></span>
          <span id="not_filter" class="text-danger" hidden ></span>
        </p>
        <div class="tab-content">
          <div class="tab-pane active">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#pfilter" aria-controls="filter" role="tab" data-toggle="tab">Фильтр</a></li>
              <li role="presentation"><a href="#ptoolse" aria-controls="toolse" role="tab" data-toggle="tab">Действие</a></li>
              <li role="presentation"><a href="#pattern" aria-controls="toolse" role="tab" data-toggle="tab">Шаблоны</a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="pfilter">
                <div class="tab-content">
                  <div class="row">
                    <div class="col-sm-2">
                      <label class="control-label">Проект</label>
                      <div class="checkselect">
                        <?php foreach ($dns_select as $proj) {?>
                          <label> 
                            <input type="checkbox" id="checkbox_dns" name="dns_arr[]" value="<?php echo $proj['dn_id']?>" <?php echo ($proj['checked'])?'checked':''?>><?php echo $proj['dn_name']?>
                          </label>
                        <?php }?>
                      </div>
                    </div>                    
                    <div class="col-sm-2">
                      <label class="control-label">Товаров на страницу</label>
                      <select class="form-control" name="page_count">
                        <option value="50" selected>50</option>
                        <option value="100">100</option>
                        <option value="150">150</option>
                        <option value="200">200</option>
                        <option value="250">250</option>
                        <option value="500">500</option>
                        <option value="750">750</option>
                        <option value="1000">1000</option>
                      </select>
                    </div>
                    <div class="col-sm-2">
                      <label class="control-label">Фильтр по языкам</label>
                      <div class="checkselect">
                        <?php foreach ($langs as $lang) {?>
                          <label>
                            <input type="checkbox" id="checkbox_langs" name="langs[]" value="<?php echo $lang['language_id']?>" <?php echo ($lang['checked'])?'checked':''?>><?php echo $lang['name']?>
                          </label>
                        <?php }?>
                      </div>
                    </div>
                    <div class="col-sm-4"></div>
                    <div class="col-sm-2">
                      <label class="control-label">Выберите шаблон</label>
                      <select class="form-control" id="pattern_take">
                        <option value="0">Выберите шаблон</option>
                        <?php foreach($patterns_all as $patt){?>
                          <option value="<?php echo $patt['id']?>" <?php echo ($pt_naw == $patt['id'])?'selected':''?>><?php echo $patt['name']?></option>
                        <?php }?>
                      </select>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-sm-3">
                      <label class="control-label">Фильтр по Категориям</label>
                      <div class="checkselect">
                        <?php foreach ($categorys as $cat_page) {?>
                          <label>
                           <input type="checkbox" id="checkbox_cats" name="cats[]" value="<?php echo $cat_page['id'] ?>" <?php echo ($cat_page['checked'])?'checked':''?>><?php echo $cat_page['name']?>
                          </label>
                        <?php }?>
                      </div>
                    </div>
                    <div class="col-sm-3">
                      <label class="control-label">Фильтр по Производителю</label>
                      <div class="checkselect">
                        <?php foreach ($manufs as $key_m => $manuf) {?>
                          <label>
                            <input type="checkbox" id="checkbox_manufs" name="manufs[]" value="<?php echo $manuf['id']?>" <?php echo ($manuf['checked'])?'checked':''?>><?php echo $manuf['name']?>
                          </label>
                        <?php }?>
                      </div>
                    </div>
                  </div>
                  <div id='mark'>
                    <!--Спавн фильтров-->
                    <?php if(!empty($pattern['filters'])){?>
                    <?php foreach($pattern['filters'] as $key_f => $filter){?>
                    <div class="row" id="select_id_<?php echo $key_f;?>">
                      <br>
                      <div class="col-sm-2">
                        <select class="form-control" name="filters[<?php echo $key_f?>][take_filtr]">
                          <option value="0" <?php echo ($filter['take_filtr'] == 0)?'selected':''?>>Доступные фильтры</option>
                          <option value="product_id" <?php echo ($filter['take_filtr'] == 'product_id')?'selected':''?>>id товара</option>
                          <option value="model" <?php echo ($filter['take_filtr'] == 'model')?'selected':''?>>Код товара [model]</option>
                          <option value="sku" <?php echo ($filter['take_filtr'] == 'sku')?'selected':''?>>Артикул [sku]</option>
                          <option value="name" <?php echo ($filter['take_filtr'] == 'name')?'selected':''?>>Название товара</option>
                          <option value="description" <?php echo ($filter['take_filtr'] == 'description')?'selected':''?>>Описание товара</option>
                          <option value="price" <?php echo ($filter['take_filtr'] == 'price')?'selected':''?>>Цена</option>
                          <option value="quantity" <?php echo ($filter['take_filtr'] == 'quantity')?'selected':''?>>Кол-во</option>
                          <option value="status" <?php echo ($filter['take_filtr'] == 'status')?'selected':''?>>Статус товара</option>
                          <option value="date_added" <?php echo ($filter['take_filtr'] == 'date_added')?'selected':''?>>Дата добавления</option>
                          <option value="date_modified" <?php echo ($filter['take_filtr'] == 'date_modified')?'selected':''?>>Дата последнего обновление</option>
                          <option value="upc" <?php echo ($filter['take_filtr'] == 'upc')?'selected':''?>>Фильтр по полю UPC</option>
                          <option value="ean" <?php echo ($filter['take_filtr'] == 'ean')?'selected':''?>>Фильтр по полю EAN</option>
                          <option value="jan" <?php echo ($filter['take_filtr'] == 'jan')?'selected':''?>>Фильтр по полю JAN</option>
                          <option value="isbn" <?php echo ($filter['take_filtr'] == 'isbn')?'selected':''?>>Фильтр по полю ISBN</option>
                          <option value="mpn" <?php echo ($filter['take_filtr'] == 'mpn')?'selected':''?>>Фильтр по полю MPN</option>
                          <option value="location" <?php echo ($filter['take_filtr'] == 'location')?'selected':''?>>Фильтр по полю Location</option>
                        </select>
                      </div>
                      <div class="col-sm-1">
                        <select class="form-control" name="filters[<?php echo $key_f?>][style]">
                          <option value="0" <?php echo ($filter['style'] == '0')?'selected':''?>></option>
                          <option value="1" <?php echo ($filter['style'] == '1')?'selected':''?>>Отрицание (не равно)</option>
                        </select>
                      </div>
                    
                      <div class="col-sm-1">
                        <select class="form-control" name="filters[<?php echo $key_f?>][position]">
                          <option value="={data}" <?php echo ($filter['position'] == "={data}")?'selected':''?>>=</option>
                          <option value=">={data}" <?php echo ($filter['position'] == ">={data}")?'selected':''?>>>=[числу]</option>
                          <option value="<={data}" <?php echo ($filter['position'] == "<={data}")?'selected':''?>><=[числу]</option>
                          <option value="%{data}%" <?php echo ($filter['position'] == "%{data}%")?'selected':''?>>%[значение]%</option>
                          <option value="{data}%" <?php echo ($filter['position'] == "{data}%")?'selected':''?>>[значение]%</option>
                          <option value="%{data}" <?php echo ($filter['position'] == "%{data}")?'selected':''?>>%[значение]</option>
                        </select>
                      </div>

                      <div class="col-sm-5">
                        <input class="form-control" name="filters[<?php echo $key_f?>][value]" type="text" value="<?php echo $filter['value']?>">
                      </div>
                      <div class="col-sm-1">
                        <button type="button" onclick="$('#select_id_<?php echo $key_f?>').remove()" class="btn btn-danger" title="Удалить фильтр"><i class="fa fa-trash-o"></i></button>
                      </div>
                    </div>
                    <!--Спавн фильтров-->
                    <?php }?>
                    <?php }?>
                  </div>
                  <br>
                  <button type="button" onclick="addRecurring()" class="btn btn-primary btn-sm">
                        <i class="fa fa-plus-circle"></i> Добавить фильтр
                  </button>
                </div>
                <div class="tab-content">
                  <br>
                  <div class="col-sm-4"></div>
                  <div class="col-sm-4">
                    <button id="get_filter" name="get_filter" type="button" class="btn btn-primary" data-original-title="Фильтровать">
                      <i class="fa fa-filter" aria-hidden="true"></i> Фильтровать
                    </button>
                    <button id="clear" type="submit" class="btn btn-warning" data-original-title="Сброс настроек фильтра">
                      <i class="fa fa-eraser" aria-hidden="true"></i> Сброс
                    </button>
                    <!--button name="get_filter" type="submit" class="btn btn-primary" data-original-title="Фильтровать">
                      <i class="fa fa-filter" aria-hidden="true"></i> Фильтровать
                    </button-->
                  </div>
                  <div class="col-sm-4"></div>
                </div>
              </div>
              <!--
              //////////////////////////////
              //Блок отвечающий за действие
              //////////////////////////////
              -->
              <div role="tabpanel" class="tab-pane" id="ptoolse">
                <div class="tab-content">
                  <div class="row">
                    <div class="col-sm-2">
                      <label class="control-label">Выберите действие</label>
                      <select id="do_tools" name="do_tools" class="form-control">
                        <option value="0">Выберите действие</option>
                        <option value="change_price" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_price')?'selected':''?>>Изменить цену товара</option>
                        <option value="change_quant" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_quant')?'selected':''?>>Изменить кол-во товара</option>
                        <option value="change_status" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_status')?'selected':''?>>Статус товар</option>
                        <option value="change_stock_status" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_stock_status')?'selected':''?>>Отсутствие на складе</option>
                        <option value="change_cats_add" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_cats_add')?'selected':''?>>Добавить Категории в товар</option>
                        <option value="change_cats_ch" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_cats_ch')?'selected':''?>>Изменить Категории в товаре</option>
                        <?php if($setting['vers_op']){?>
                        <option value="change_main_cat" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_main_cat')?'selected':''?>>Указать главную категорию в товаре</option>
                        <?php }?>
                        <option value="show_to_parent_cat" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'show_to_parent_cat')?'selected':''?>>Присвоить/Отвязать родительские категории</option>
                        <option value="change_manuf" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_manuf')?'selected':''?>>Изменить производителя</option>
                        <option value="change_spec_price" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_spec_price')?'selected':''?>>Изменить акционную цену</option>
                        <option value="change_dn" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_dn')?'selected':''?>>Изменить проект в товарах</option>
                        <option value="replace" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'replace')?'selected':''?>>Поиск замена</option>
                        <option value="change_meta" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_meta')?'selected':''?>>Обновить метаданные</option>
                        <option value="change_url" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'change_url')?'selected':''?>>Обновить SEO_URL</option>
                        <option value="del_product" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_product')?'selected':''?>>Удалить товары</option>
                        <option value="del_product_img" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_product_img')?'selected':''?>>Удаление изображений товара</option>
                        <option value="del_price_spec" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_price_spec')?'selected':''?>>Удалить акцеонные цены</option>
                        <option value="del_attr_product" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_attr_product')?'selected':''?>>Удалить атрибуты в товаре</option>
                        <option value="del_opt_product" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_opt_product')?'selected':''?>>Удалить опции в товаре</option>
                        <option value="reset_opt_quan" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'reset_opt_quan')?'selected':''?>>Обнулить остатки в опциях</option>
                        <option value="del_manuf_is_null" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_manuf_is_null')?'selected':''?>>Удаление производителей не привязанных к товару</option>
                        <option value="del_attr_is_null" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_attr_is_null')?'selected':''?>>Удаление атрибутов которые не привязаны к товарам</option>
                        
                        <option value="count_with_opt" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'count_with_opt')?'selected':''?>>Пересчитать кол-во товара по количеству опций</option>
                        <option value="add_product_to_hpm" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'add_product_to_hpm')?'selected':''?><?php echo ($permit_hpm)?'':' disabled=""'?>>Объединить товары в группу HPM</option>
                        <option value="del_product_to_hpm" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'del_product_to_hpm')?'selected':''?><?php echo ($permit_hpm)?'':' disabled=""'?>>Удалить отфильтрованные товары из групп HPM</option>
                        <option value="webp_convert" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'webp_convert')?'selected':''?>>Конвертировать изображения товара с webp в jpg/png</option>
                        <option value="-" disabled="">----------</option>
                        <option value="tech_del_logs" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'tech_del_logs')?'selected':''?>>Очистить логи проекта</option>
                        <option value="tech_del_cache" <?php echo (!empty($pattern['do_tools']) && $pattern['do_tools'] == 'tech_del_cache')?'selected':''?>>Удалить кэш ссылок проекта</option>
                      </select>
                    </div>
                  </div>
                  <div class="row" id="form_tools">
                    <?php if(!empty($pattern['do_tools'])){?>
                    
                    <?php if($pattern['do_tools'] == 'change_price' || $pattern['do_tools'] == 'change_quant'){?>
                    <br>
                    <div class="col-sm-1">
                      <select class="form-control" name="operator">
                        <option value="=" <?php echo ($pattern['operator'] == '=')?'selected':''?>>=</option>
                        <option value="+" <?php echo ($pattern['operator'] == '+')?'selected':''?>>+</option>
                        <option value="-" <?php echo ($pattern['operator'] == '-')?'selected':''?>>-</option>
                        <option value="*" <?php echo ($pattern['operator'] == '*')?'selected':''?>>*</option>
                        <option value="/" <?php echo ($pattern['operator'] == '/')?'selected':''?>>/</option>
                      </select>
                    </div>
                    <div class="col-sm-5">
                      <input class="form-control" name="value" type="text" value="<?php echo @$pattern['value']?>">
                    </div>
                   
                    <?php } elseif($pattern['do_tools'] == 'change_status') {?>

                      <br>
                      <div class="col-sm-1">
                       <select class="form-control" name="value">
                          <option value="0" <?php echo ($pattern['value'] == '0')?'selected':''?>>Отключить</option>
                          <option value="1" <?php echo ($pattern['value'] == '1')?'selected':''?>>Включить</option>
                       </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_stock_status') {?>

                      <br>
                      <div class="col-sm-3">
                       <select class="form-control" name="value">
                        <option value="0">Выберите статус который будет у товаров с нулевым остатком</option>
                        <?php foreach($stock_status as $stock){?>
                          <option value="<?php echo $stock['stock_status_id']?>" <?php echo ($pattern['value'] == $stock['stock_status_id'])?'selected':''?>><?php echo $stock['name']?></option>
                        <?php }?>
                       </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_cats_add') {?>

                      <br>
                      <div class="col-sm-10">
                        <label class="control-label">Показывать в категориях</label>
                        <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">
                          <table class="table table-striped">
                          <?php foreach ($categorys_do as $category_do) { ?>
                          <tr>
                            <td class="checkbox">
                              <label>
                                <input type="checkbox" id="new_cats" name="new_cats[]" value="<?php echo $category_do['id']; ?>" <?php echo ($category_do['checked'])?'checked':''?>> <?php echo $category_do['name']; ?>
                              </label>
                            </td>
                          </tr>
                          <?php } ?>
                          </table>
                        </div>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_cats_ch') {?>

                      <br>
                      <?php if($setting['vers_op']){?>
                      <div class="col-sm-2">
                        <label class="control-label">Выберите Главную категорию</label>
                        <select class="form-control" name="main_cat">
                          <option value="0">Выберите главную категорию</option>
                          <?php foreach ($categorys_do as $cat_m) { ?>
                          <option value="<?php echo $cat_m['id']?>" <?php echo (!empty($pattern['main_cat']) && $pattern['main_cat'] == $cat_m['id'])?'selected':''?>><?php echo $cat_m['name']; ?></option>
                          <?php } ?>
                        </select>
                      </div>
                      <?php }?>
                       <div class="col-sm-10">
                        <label class="control-label">Показывать в категориях</label>
                        <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">
                          <table class="table table-striped">
                          <?php foreach ($categorys_do as $category_do) { ?>
                          <tr>
                            <td class="checkbox">
                              <label>
                                <input type="checkbox" id="new_cats" name="new_cats[]" value="<?php echo $category_do['id']; ?>" <?php echo ($category_do['checked'])?'checked':''?>> <?php echo $category_do['name']; ?>
                              </label>
                            </td>
                          </tr>
                          <?php } ?>
                          </table>
                        </div>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_main_cat') {?>

                      <br>
                      <div class="col-sm-2">
                        <label class="control-label">Выберите Главную категорию</label>
                        <select class="form-control" name="main_cat">
                          <option value="0">Выберите главную категорию</option>
                          <?php foreach ($categorys as $category) { ?>
                          <option value="<?php echo $category['id']?>" <?php echo ($category['id'] == $pattern['main_cat'])?'selected':''?>><?php echo $category['name'];?></option>
                          <?php } ?>
                        </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'show_to_parent_cat') {?>

                      <br>
                      <div class="col-sm-3">
                        <select class="form-control" name="operator">
                          <option value="0" <?php echo ($pattern['operator'] == '0')?'selected':''?>>Выберите где выводить товар</option>
                          <option value="1" <?php echo ($pattern['operator'] == '1')?'selected':''?>>Выводить товар во всех родительских категориях</option>
                          <option value="2" <?php echo ($pattern['operator'] == '2')?'selected':''?>>Выводить товар только в одной целевой категории</option>
                        </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_cat_main') {?>

                      <br>
                      <div class="col-sm-2">
                        <label class="control-label">Выберите Главную категорию</label>
                        <select class="form-control" name="main_cat">
                          <option value="0">Выберите главную категорию</option>
                          <?php foreach ($categorys_do as $cat_m) { ?>
                          <option value="<?php echo $cat_m['id']?>" <?php echo (!empty($pattern['main_cat']) && $pattern['main_cat'] == $cat_m['id'])?'selected':''?>><?php echo $cat_m['name']; ?></option>
                          <?php } ?>
                        </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_manuf') {?>

                      <br>
                      <div class="col-sm-2">
                        <label class="control-label">Выберите Производителя</label>
                        <select class="form-control" name="new_manuf">
                          <option value="0">Выберите Производителя</option>
                          <?php foreach ($manufs_do as $manuf_d) { ?>
                          <option value="<?php echo $manuf_d['id']?>" <?php echo ($pattern['new_manuf'] == $manuf_d['id'])?'selected':''?>><?php echo $manuf_d['name']; ?></option>
                          <?php } ?>
                        </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_spec_price') {?>

                      <br>
                      <div class="col-sm-1">
                       <select class="form-control" name="cast_group">
                        <option value="0">Выберите группу покупателей</option>
                        <?php foreach($cast_groups as $key_g => $group_name){?>
                          <option value="<?php echo $key_g?>" <?php echo ($pattern['cast_group'] == $key_g)?'selected':''?>><?php echo $group_name?></option>
                        <?php }?>
                       </select>
                      </div>
                      <div class="col-sm-1">
                       <select class="form-control" name="operator">
                        <option value="=" <?php echo ($pattern['operator'] == '=')?'selected':''?>>=</option>
                        <option value="+" <?php echo ($pattern['operator'] == '+')?'selected':''?>>+</option>
                        <option value="-" <?php echo ($pattern['operator'] == '-')?'selected':''?>>-</option>
                        <option value="*" <?php echo ($pattern['operator'] == '*')?'selected':''?>>*</option>
                        <option value="/" <?php echo ($pattern['operator'] == '/')?'selected':''?>>/</option>
                       </select>
                      </div>
                      <div class="col-sm-5">
                       <input class="form-control" name="value" type="text" value="<?php echo @$pattern['value']?>">
                      </div>


                    <?php } elseif($pattern['do_tools'] == 'change_dn'){?>

                      <br>
                      <div class="col-sm-3">
                       <select class="form-control" name="value">
                         <option value="0">Выберите проект</option>
                          <?php foreach($dns_id as $dn){?>
                           <option value="<?php echo $dn['dn_id']?>" <?php echo ($pattern['value'] == $dn['dn_id'])?'selected':''?>><?php echo "[id=".$dn['dn_id']."]".$dn['dn_name']?></option>
                          <?php }?>
                       </select>
                      </div-->

                    <?php }elseif($pattern['do_tools'] == 'replace'){?>

                      <br>
                      <div class="col-sm-2">
                        <select class="form-control" name="operator">
                          <option value="0">Выберите поле</option>
                          <option value="product_name" <?php echo ($pattern['operator'] == 'product_name')?'selected':''?>>Название товара</option>
                          <option value="product_desc" <?php echo ($pattern['operator'] == 'product_desc')?'selected':''?>>Описание товара</option>
                          <option value="product_h1" <?php echo ($pattern['operator'] == 'product_h1')?'selected':''?>>HTML-тег H1 (только ocStore)</option>
                          <option value="product_title" <?php echo ($pattern['operator'] == 'product_title')?'selected':''?>>Мета-тег title</option>
                          <option value="product_meta_desc" <?php echo ($pattern['operator'] == 'product_meta_desc')?'selected':''?>>Мета-тег description</option>
                          <option value="product_keyword" <?php echo ($pattern['operator'] == 'product_keyword')?'selected':''?>>Мета-тег keywords</option>
                          <option value="product_model" <?php echo ($pattern['operator'] == 'product_model')?'selected':''?>>Код товара [model]</option>
                          <option value="product_sku" <?php echo ($pattern['operator'] == 'product_sku')?'selected':''?>>Артикул [sku]</option>
                          <option value="product_upc" <?php echo ($pattern['operator'] == 'product_upc')?'selected':''?>>Универсальный код [upc]</option>
                          <option value="product_ean" <?php echo ($pattern['operator'] == 'product_ean')?'selected':''?>>Европейский номер товара [ean]</option>
                          <option value="product_jan" <?php echo ($pattern['operator'] == 'product_jan')?'selected':''?>>Японский штрихкод [jan]</option>
                          <option value="product_isbn" <?php echo ($pattern['operator'] == 'product_isbn')?'selected':''?>>Номер книжного издания [isbn]</option>
                          <option value="product_mpn" <?php echo ($pattern['operator'] == 'product_mpn')?'selected':''?>>Номер партии [mpn]</option>
                          <option value="product_location" <?php echo ($pattern['operator'] == 'product_location')?'selected':''?>>Поле расположение [location]</option>
                        </select>
                      </div>
                      <div class="col-sm-5">
                       <textarea rows="5" name="rules" class="form-control"><?php echo @$pattern['rules']?></textarea>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_meta'){?>

                      <br>
                      <div class="col-sm-2">
                        <select class="form-control" name="operator">
                          <option value="0">Выберите где заполнить</option>
                          <option value="product" <?php echo ($pattern['operator'] == 'product')?'selected':''?>>Товары</option>
                          <option value="category" <?php echo ($pattern['operator'] == 'category')?'selected':''?>>Категории</option>
                          <option value="manuf" <?php echo ($pattern['operator'] == 'manuf')?'selected':''?>>Производители</option>
                        </select>
                      </div>
                      <div class="col-sm-5">
                        <input class="form-control" value="Заполняет мета данные по SEO_Шаблону. При заполнении границы парсинга не участвуют !!!!" type="text" readonly>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'change_url'){?>

                      <br>
                      <div class="col-sm-2">
                       <select class="form-control" name="operator">
                         <option value="0">Выберите где заполнить</option>
                         <option value="product" <?php echo ($pattern['operator'] == 'product')?'selected':''?>>Товары</option>
                         <option value="category" <?php echo ($pattern['operator'] == 'category')?'selected':''?>>Категории</option>
                         <option value="manuf" <?php echo ($pattern['operator'] == 'manuf')?'selected':''?>>Производители</option>
                       </select>
                      </div>
                      <div class="col-sm-5">
                       <input class="form-control" value="SEO_URL формируется из названия, транс литом на латиницу !!!" type="text" readonly>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'del_product'){?>

                      <br>
                      <div class="col-sm-2">
                       <select class="form-control" name="operator">
                         <option value="1" <?php echo ($pattern['operator'] == '1')?'selected':''?>>Удалить только товары</option>
                         <option value="2" <?php echo ($pattern['operator'] == '2')?'selected':''?>>Удалить товары вместе с фото</option>
                       </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'del_product_img'){?>

                      <br>
                      <div class="col-sm-2">
                       <select class="form-control" name="operator">
                         <option value="1" <?php echo ($pattern['operator'] == '1')?'selected':''?>>Удалить все изображения</option>
                         <option value="2" <?php echo ($pattern['operator'] == '2')?'selected':''?>>Удалить только дополнительные изображения</option>
                       </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'add_product_to_hpm'){?>

                      <br>
                      <div class="col-sm-4">
                       <select class="form-control" name="operator">
                        <option value="0">По какому признаку объединять товары ?</option>
                        <option value="model" <?php echo ($pattern['operator'] == 'model')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле Model</option>
                        <option value="sku" <?php echo ($pattern['operator'] == 'sku')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле SKU</option>
                        <option value="upc" <?php echo ($pattern['operator'] == 'upc')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле UPC</option>
                        <option value="ean" <?php echo ($pattern['operator'] == 'ean')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле EAN</option>
                        <option value="jan" <?php echo ($pattern['operator'] == 'jan')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле JAN</option>
                        <option value="isbn" <?php echo ($pattern['operator'] == 'isbn')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле ISBN</option>
                        <option value="mpn" <?php echo ($pattern['operator'] == 'mpn')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле MPN</option>
                        <option value="location" <?php echo ($pattern['operator'] == 'location')?'selected':''?>>Объединить все товары с одинаковыми значениями в поле Location</option>
                        <option value="0" disabled="">-----</option>
                        <option value="filtered_products" <?php echo ($pattern['operator'] == 'filtered_products')?'selected':''?>>Объединить все отфильтрованные товары в одну группу!!!</option>
                        </select>
                      </div>

                    <?php } elseif($pattern['do_tools'] == 'webp_convert'){?>

                      <br>
                      <div class="col-sm-2">
                       <select class="form-control" name="operator">
                         <option value="0" <?php echo ($pattern['operator'] == '1')?'selected':''?>>Нет</option>
                         <option value="1" <?php echo ($pattern['operator'] == '2')?'selected':''?>>Конвертировать в JPG</option>
                         <option value="2" <?php echo ($pattern['operator'] == '2')?'selected':''?>>Конвертировать в PNG</option>
                       </select>
                      </div>

                    <?php }?>
                    <?php }?>


                  </div>
                </div>
                <div class="tab-content">
                  <br>
                  <div class="col-sm-4"></div>
                  <div class="col-sm-4">
                    <button id="apply_action" name="apply_action" type="button" class="btn btn-danger">
                      <i class="fa fa-gavel" aria-hidden="true"></i> Выполнить действие
                    </button>
                    <!--button id="apply_action" name="apply_action" type="submit" class="btn btn-primary" data-original-title="Фильтровать">
                      <i class="fa fa-gavel" aria-hidden="true"></i> Выполнить действие
                    </button-->
                  </div>
                  <div class="col-sm-4"></div>
                </div>
              </div>

              <div role="tabpanel" class="tab-pane" id="pattern">
                <div class="tab-content">
                  <div class="row">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-6">
                      <button name="pattern_add" type="submit" class="btn btn-primary">
                        <i class="fa fa-plus" aria-hidden="true"></i> Добавить шаблон
                      </button>
                      <button name="pattern_update" type="submit" class="btn btn-warning">
                        <i class="fa fa-save" aria-hidden="true"></i> Обновить шаблон
                      </button>
                      <button name="patern_del" type="submit" class="btn btn-danger">
                        <i class="fa fa-trash-o" aria-hidden="true"></i> Удалить шаблон
                      </button>
                    </div>
                    <div class="col-sm-2"></div>
                  </div>
                  <div class="row">
                    <div class="col-sm-2">
                      <label class="control-label">Выберите шаблон</label>
                      <select class="form-control" id="pattern_take2" name="pattern_take">
                        <option value="0">Выберите шаблон</option>
                        <?php foreach($patterns_all as $patt){?>
                          <option value="<?php echo $patt['id']?>" <?php echo ($pt_naw == $patt['id'])?'selected':''?>><?php echo $patt['name']?></option>
                        <?php }?>
                      </select>
                    </div>
                    <div class="col-sm-2">
                      <label class="control-label">Название</label>
                      <input class="form-control" name="pattern_name" placeholder="Введите название шаблона" type="text" value="<?php echo @$pattern['pattern_name']?>">
                    </div>
                  </div>
                </div>
                <br>
              </div>
            </div>
          </div>
          <!-- /simpleparspage stop-->
        </div>        
        <div class="tab-content">

        <div class="col-md-6" id="page-1">
          <!--Сюда я отрисую пагинацию-->            
        </div>
        <div class="col-md-6" id="products_total">
          <!--Здесь кол-во товаров-->
        </div>

          <table class="table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Код [model]</th>
                <th>Артикул[SKU]</th>
                <th>Фото</th>
                <th>Название</th>
                <!--th>Описание</th-->
                <th>Цена</th>
                <th>Кол-во</th>
                <th>Статус</th>
                <th>Дата доб.</th>
                <th>Дата обн.</th>
                <th>Проект id</th>
                <th>Переходы</th>
              </tr>
            </thead>
            <tbody id="products_body">

              <!--tr>
                <td>[]</td>
                <td>666</td>
                <td>666-2</td>
                <td>rass-1</td>
                <td>{}</td>
                <td>Товар загружен SimplePars</td>
                <td>1.56</td>
                <td>101</td>
                <td>2020-02-15 20:44:21</td>
                <td>2020-03-12 13:40:21</td>
                <td>1</td>
                <td><a href="" class="btn btn-default" target="_blank"><i class="fa fa-cog"></i></a> <a href="" class="btn btn-success" target="_blank"><i class="fa fa-reply"></i></a></td>
              </tr-->

            </tbody>
          </table>

        </div>
        </form>
      </div>
    </div>
  </div>

</div><!-- /content -->

<script type="text/javascript">
  //запуск фильтра при заходе на страницу
  controlFilter(1);

  $("#get_filter").bind("click", function () {
    controlFilter(1);
  });

  $("#apply_action").bind("click", function () {
    controlAction();
  });

  //выбор шаблона
  $("#pattern_take").bind("change", function () {
    var pt_id = $("#pattern_take").val();
    patternTake(pt_id);
  });

  $("#pattern_take2").bind("change", function () {
    var pt_id = $("#pattern_take2").val();
    patternTake(pt_id);
  });

  //выбор шаблона
  function patternTake(pt_id){
    var url_pt_id = "<?php echo $url_pt?>";
    url_pt_id = url_pt_id.replace(/&amp;/g,'&') + pt_id;
    //console.log(url_pt_id);
    window.location.href = url_pt_id;
  }

  function controlFilter($page=1){
    //console.log($page);
    var data = getForm();
    data.page = $page;
    //console.log(data);
    get_products(data);
  }

  function controlAction(){
    //console.log($page);
    var data = getForm();
    do_action(data);

  }
  //конец

  function getForm(){
    var $data_form = {};
    $('#tools').find ('select, textarea, input').each(function() {
      $data_form[this.name] = $(this).val();
      delete $data_form['dns_arr[]'];
      delete $data_form['langs[]'];
      delete $data_form['cats[]'];
      delete $data_form['new_cats[]'];
      delete $data_form['manufs[]'];

      //получаем выбор проектов.
      $('input#checkbox_dns').each(function(){
        if($(this).prop("checked")){
          $data_form['dns_arr['+$(this).val()+']'] = $(this).val();
        }
      })
      //получаем выбор языков.
      $('input#checkbox_langs').each(function(){
        if($(this).prop("checked")){
          $data_form['langs['+$(this).val()+']'] = $(this).val();
        }
      })
      //получаем выбор категорий
      $('input#checkbox_cats').each(function(){
        if($(this).prop("checked")){
          $data_form['cats['+$(this).val()+']'] = $(this).val();
        }
      })
      //получаем выбор новых
      $('input#new_cats').each(function(){
        if($(this).prop("checked")){
          $data_form['new_cats['+$(this).val()+']'] = $(this).val();
        }
      })
      //получаем выбор производителей
      $('input#checkbox_manufs').each(function(){
        if($(this).prop("checked")){
          $data_form['manufs['+$(this).val()+']'] = $(this).val();
        }
      })

    });
    console.log($data_form);
    return $data_form;
  }

  function get_products(data){
    //console.log(data);
    $.ajax({
      url: 'index.php?route=catalog/simplepars/ajax&<?php echo $adap['token']?>&who=tools&do=filter&dn_id=<?php echo $dn_id?>',
      type: "POST",
      data: data,
      dataType: "html",
      success: function (data) {
        answ = $.parseJSON(data);
        if(answ.products.length == 0){
          $('#products_body').empty();
          $('#products_total').empty();
          $('#products_total').append('<span class="pull-right"><h4>Отфильтровано <span class="text-danger">0</span> товаров</span></h4>');
          $("#not_filter").text('Нет товара по указанным фильтрам');
          $("#not_filter").show();
          setTimeout(() => { $("#not_filter").hide() }, 2000);

        }else{
          render_products_table(answ);
        }
      }
    });
  }

  function do_action(data){
    //console.log(data);
    $.ajax({
      url: 'index.php?route=catalog/simplepars/ajax&<?php echo $adap['token']?>&who=tools&do=action&dn_id=<?php echo $dn_id?>',
      type: "POST",
      data: data,
      dataType: "html",
      success: function (data) {
        answ = $.parseJSON(data);
        console.log(answ);
        $("#resul_act").text(answ);
        $("#resul_act").show();
        setTimeout(() => { $("#resul_act").hide() }, 3000);

      }
    });
  }

  //фунция рендеринга таблицы товаров.
  function render_products_table(answ){
    $('#del_ul').remove();
    $('#products_body').empty();
    $('#products_total').empty();

    html ='';
    for (key in answ.products) {
      //console.log(answ.products[key]);
      html += '<tr>';
      //html += '<td>[]</td>';
      html += '<td>'+answ.products[key].product_id+'</td>';
      html += '<td>'+answ.products[key].model+'</td>';
      html += '<td>'+answ.products[key].sku+'</td>';
      html += '<td><img src="'+answ.products[key].image+'" alt="'+answ.products[key].name+'" class="img-thumbnail" /></td>';
      html += '<td>'+answ.products[key].name+'</td>';
      //html += '<td>'+answ.products[key].description+'</td>';
      html += '<td>'+answ.products[key].price+'</td>';
      html += '<td>'+answ.products[key].quantity+'</td>';
      html += '<td>'+answ.products[key].status+'</td>';
      html += '<td>'+answ.products[key].date_added+'</td>';
      html += '<td>'+answ.products[key].date_modified+'</td>';
      html += '<td>'+answ.products[key].dn_id+'</td>';
      html += '<td><a href="'+answ.products[key].url_in+'" class="btn btn-default" title="Перейти к редактированию товара." target="_blank"><i class="fa fa-cog"></i></a> <a href="'+answ.products[key].url_out+'" class="btn btn-success" title="Перейти к просмотру товара на вашем сайте." target="_blank"><i class="fa fa-eye"></i></a></td>';
      html += '</tr>';
    }

    html_total = '<span class="pull-right"><h4>Отфильтровано <span class="text-danger">'+answ.totla+'</span> товаров</span></h4>'

    $('#products_body').append(html);
    $('#page-1').append(answ.pagination);
    $('#products_total').append(html_total);

    //console.log(answ.pagination);
  }

  
</script>

<script type="text/javascript">
  var i = <?php echo $pattern['key_f_last']+1 ?>;
  function addRecurring() {

    html = '<div class="row" id="select_id_'+i+'">';
    html += '<br>';
    html += '  <div class="col-sm-2">';
    html += '   <select class="form-control" name="filters['+i+'][take_filtr]">';
    html += '     <option value="0">Доступные фильтры</option>';
    html += '     <option value="product_id">id товара</option>';
    html += '     <option value="model">Код товара [model] </option>';
    html += '     <option value="sku">Артикул [sku]</option>';
    html += '     <option value="name">Название товара</option>';
    html += '     <option value="description">Описание товара</option>';
    html += '     <option value="price">Цена</option>';
    html += '     <option value="quantity">Кол-во</option>';
    html += '     <option value="status">Статус товара</option>';
    html += '     <option value="date_added">Дата добавления</option>';
    html += '     <option value="date_modified">Дата последнего обновление</option>';
    html += '     <option value="upc">Фильтр по полю UPC</option>';
    html += '     <option value="ean">Фильтр по полю EAN</option>';
    html += '     <option value="jan">Фильтр по полю JAN</option>';
    html += '     <option value="isbn">Фильтр по полю ISBN</option>';
    html += '     <option value="mpn">Фильтр по полю MPN</option>';
    html += '     <option value="location">Фильтр по полю Location</option>';
    html += '   </select>';
    html += '  </div>';
    html += '  <div class="col-sm-1">';
    html += '   <select class="form-control" name="filters['+i+'][style]">';
    html += '     <option value="0"></option>';
    html += '     <option value="1">Отрицание (не равно)</option>';
    html += '   </select>';
    html += '  </div>';

    html += '  <div class="col-sm-1">';
    html += '   <select class="form-control" name="filters['+i+'][position]">';
    html += '     <option value="={data}">=</option>';
    html += '     <option value=">={data}">>=[числу]</option>';
    html += '     <option value="<={data}"><=[числу]</option>';
    html += '     <option value="%{data}%">%[значение]%</option>';
    html += '     <option value="{data}%">[значение]%</option>';
    html += '     <option value="%{data}">%[значение]</option>';
    html += '   </select>';
    html += '  </div>';

    html += '  <div class="col-sm-5">';
    html += '    <input class="form-control" name="filters['+i+'][value]" placeholder="Введите искомое значение, или несколько через разделитель |" type="text" value="">';
    html += '  </div>';
    html += '  <div class="col-sm-1">';
    html += '    <button type="button" onclick="$(\'#select_id_'+i+'\').remove()" class="btn btn-danger" title="Удалить фильтр"><i class="fa fa-trash-o"></i></button>';
    html += '  </div>';
    html += ' </div>';
    html += '</div>';

    $('#mark').append(html);
    i++;
  }
</script>
<script type="text/javascript">
  $("#do_tools").bind("change", function () {
    var do_tools = $("#do_tools").val();
    $('#form_tools').empty();
    console.log(do_tools);

    if(do_tools == 'change_price') {

      html = '<br>';
      html += '<div class="col-sm-1">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="=">=</option>';
      html += '   <option value="+">+</option>';
      html += '   <option value="-">-</option>';
      html += '   <option value="*">*</option>';
      html += '   <option value="/">/</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <input class="form-control" name="value" type="text">';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_quant'){
     
      html = '<br>';
      html += '<div class="col-sm-1">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="=">=</option>';
      html += '   <option value="+">+</option>';
      html += '   <option value="-">-</option>';
      html += '   <option value="*">*</option>';
      html += '   <option value="/">/</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <input class="form-control" name="value" type="text">';
      html += '</div>';

      $('#form_tools').append(html);
    
    }else if(do_tools == 'change_status'){
    
      html = '<br>';
      html += '<div class="col-sm-1">';
      html += ' <select class="form-control" name="value">';
      html += '   <option value="0">Отключить</option>';
      html += '   <option value="1">Включить</option>';
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html); 

    }else if(do_tools == 'change_stock_status'){
    
      html = '<br>';
      html += '<div class="col-sm-3">';
      html += ' <select class="form-control" name="value">';
      html += '   <option value="0">Выберите статус который будет у товаров с нулевым остатком</option>';
      <?php foreach($stock_status as $stock){?>
        html += '   <option value="<?php echo $stock['stock_status_id']?>"><?php echo $stock['name']?></option>';
      <?php }?>
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html); 

    }else if(do_tools == 'change_cats_add'){

      html = '<br>';
      html += ' <div class="col-sm-10">';
      html += '  <label class="control-label">Показывать в категориях</label>';
      html += '  <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">';
      html += '    <table class="table table-striped">';
                  <?php foreach ($categorys_do as $category) { ?>
      html += '    <tr>';
      html += '      <td class="checkbox">';
      html += '        <label>';
      html += "          <input type='checkbox' id='new_cats' name='new_cats[]' value='<?php echo $category['id']; ?>' /> <?php echo $category['name']; ?>";
      html += '        </label>';
      html += '      </td>';
      html += '    </tr>';
                  <?php } ?>
      html += '    </table>';
      html += '  </div>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_cats_ch'){

      html = '<br>';
              <?php if($setting['vers_op']){?>
      html += '<div class="col-sm-2">';
      html += '  <label class="control-label">Выберите Главную категорию</label>';
      html += '  <select class="form-control" name="main_cat">';
      html += '    <option value="0">Выберите главную категорию</option>';
                  <?php foreach ($categorys_do as $category) { ?>
      html += "    <option value='<?php echo $category['id']?>'><?php echo $category['name']; ?></option>";
                  <?php } ?>
      html += '  </select>';
      html += '</div>';
              <?php }?>
      html += ' <div class="col-sm-10">';
      html += '  <label class="control-label">Показывать в категориях</label>';
      html += '  <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">';
      html += '    <table class="table table-striped">';
                  <?php foreach ($categorys_do as $category) { ?>
      html += '    <tr>';
      html += '      <td class="checkbox">';
      html += '        <label>';
      html += "          <input type='checkbox' id='new_cats' name='new_cats[]' value='<?php echo $category['id']; ?>' /> <?php echo $category['name']; ?>";
      html += '        </label>';
      html += '      </td>';
      html += '    </tr>';
                  <?php } ?>
      html += '    </table>';
      html += '  </div>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_main_cat'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += '  <label class="control-label">Выберите Главную категорию</label>';
      html += '  <select class="form-control" name="main_cat">';
      html += '    <option value="0">Выберите главную категорию</option>';
                  <?php foreach ($categorys as $category) { ?>
      html += "    <option value='<?php echo $category['id']?>'><?php echo $category['name']; ?></option>";
                  <?php } ?>
      html += '  </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'show_to_parent_cat'){

      html = '<br>';
      html += '<div class="col-sm-3">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="0">Выберите где выводить товар</option>';
      html += '   <option value="1">Выводить товар во всех родительских категориях</option>';
      html += '   <option value="2">Выводить товар только в одной целевой категории</option>';
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_manuf'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += '  <label class="control-label">Выберите Производителя</label>';
      html += '  <select class="form-control" name="new_manuf">';
      html += '    <option value="0">Выберите Производителя</option>';
              <?php foreach ($manufs_do as $manuf_d) { ?>
      html += '<option value="<?php echo $manuf_d['id']?>"><?php echo "[".$manuf_d['id']."] ".$manuf_d['name']; ?></option>';
              <?php } ?>
      html += '  </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_spec_price') {

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="cast_group">';
      html += '   <option value="0">Выберите группу покупателей</option>';
      <?php foreach($cast_groups as $key_g => $group_name){?>
        html += '   <option value="<?php echo $key_g?>"><?php echo $group_name?></option>';
      <?php }?>
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-1">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="=">=</option>';
      html += '   <option value="+">+</option>';
      html += '   <option value="-">-</option>';
      html += '   <option value="*">*</option>';
      html += '   <option value="/">/</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <input class="form-control" name="value" type="text">';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_dn'){
    
      html = '<br>';
      html += '<div class="col-sm-3">';
      html += ' <select class="form-control" name="value">';
      html += '   <option value="0">Выберите проект</option>';
      <?php foreach($dns_id as $dn){?>
        html += '   <option value="<?php echo $dn['dn_id']?>"><?php echo $dn['dn_name']?></option>';
      <?php }?>
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html); 

    }else if(do_tools == 'change_meta'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="0">Выберите где заполнить</option>';
      html += '   <option value="product">Товары</option>';
      html += '   <option value="category">Категории</option>';
      html += '   <option value="manuf">Производители</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <input class="form-control" value="Заполняет мета данные по SEO_Шаблону. При заполнении границы парсинга не участвуют !!!!" type="text" readonly>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'change_url'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="0">Выберите где заполнить</option>';
      html += '   <option value="product">Товары</option>';
      html += '   <option value="category">Категории</option>';
      html += '   <option value="manuf">Производители</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <input class="form-control" value="SEO_URL формируется из названия, транс литом на латиницу !!!" type="text" readonly>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'del_product'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="1">Удалить только товары</option>';
      html += '   <option value="2">Удалить товары вместе с фото</option>';
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'del_product_img'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="1">Удалить все изображения</option>';
      html += '   <option value="2">Удалить только дополнительные изображения</option>';
      html += ' </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'replace'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += ' <select class="form-control" name="operator">';
      html += '   <option value="0" disabled="">Выберите поле</option>';
      html += '   <option value="product_name">Название товара</option>';
      html += '   <option value="product_desc">Описание товара</option>';
      html += '   <option value="product_h1">HTML-тег H1 (только ocStore)</option>';
      html += '   <option value="product_title">Мета-тег title</option>';
      html += '   <option value="product_meta_desc">Мета-тег description</option>';
      html += '   <option value="product_keyword">Мета-тег keywords</option>';
      html += '   <option value="product_model">Код товара [model]</option>';
      html += '   <option value="product_sku">Артикул [sku]</option>';
      html += '   <option value="product_upc">Универсальный код [upc]</option>';
      html += '   <option value="product_ean">Европейский номер товара [ean]</option>';
      html += '   <option value="product_jan">Японский штрихкод [jan]</option>';
      html += '   <option value="product_isbn">Номер книжного издания [isbn]</option>';
      html += '   <option value="product_mpn">Номер партии [mpn]</option>';
      html += '   <option value="product_location">Поле расположение [location]</option>';
      html += ' </select>';
      html += '</div>';
      html += '<div class="col-sm-5">';
      html += ' <textarea rows="5" name="rules" class="form-control" placeholder="В данном поле вы можете прописать правила поиск замены. Каждое правило записывается с новой строки. "></textarea>';
      html += '</div>';

      $('#form_tools').append(html);

    }else if(do_tools == 'add_product_to_hpm'){

      html = '<br>'
      html += '<div class="col-sm-4">'
      html += ' <select class="form-control" name="operator">'
      html += '  <option value="0">По какому признаку объединять товары ?</option>'
      html += '  <option value="model">Объединить все товары с одинаковыми значениями в поле Model</option>'
      html += '  <option value="sku">Объединить все товары с одинаковыми значениями в поле SKU</option>'
      html += '  <option value="upc">Объединить все товары с одинаковыми значениями в поле UPC</option>'
      html += '  <option value="ean">Объединить все товары с одинаковыми значениями в поле EAN</option>'
      html += '  <option value="jan">Объединить все товары с одинаковыми значениями в поле JAN</option>'
      html += '  <option value="isbn">Объединить все товары с одинаковыми значениями в поле ISBN</option>'
      html += '  <option value="mpn">Объединить все товары с одинаковыми значениями в поле MPN</option>'
      html += '  <option value="location">Объединить все товары с одинаковыми значениями в поле Location</option>'
      html += '  <option value="0" disabled="">-----</option>'
      html += '  <option value="filtered_products">Объединить все отфильтрованные товары в одну группу!!!</option>'
      html += ' </select>'
      html += '</div>'

      $('#form_tools').append(html);

    }else if(do_tools == 'webp_convert'){

      html = '<br>';
      html += '<div class="col-sm-2">';
      html += '  <select class="form-control" name="operator">';
      html += '    <option value="0">Нет</option>';
      html += '    <option value="1">Конвертировать webp в JPG</option>';
      html += '    <option value="2">Конвертировать webp в PNG</option>';
      html += '  </select>';
      html += '</div>';

      $('#form_tools').append(html);

    }


  });
</script>
<script>
  (function($) {  function setChecked(target) {   var checked = $(target).find("input[type='checkbox']:checked").length;    if (checked) {      $(target).find('select option:first').html('Выбрано: ' + checked);    } else {      $(target).find('select option:first').html('Выберите из списка');   } }   $.fn.checkselect = function() {   this.wrapInner('<div class="checkselect-popup"></div>');    this.prepend(     '<div class="checkselect-control">' +       '<select class="form-control"><option></option></select>' +       '<div class="checkselect-over"></div>' +      '</div>'    );      this.each(function(){     setChecked(this);   });       this.find('input[type="checkbox"]').click(function(){     setChecked($(this).parents('.checkselect'));    });     this.parent().find('.checkselect-control').on('click', function(){      $popup = $(this).next();      $('.checkselect-popup').not($popup).css('display', 'none');     if ($popup.is(':hidden')) {       $popup.css('display', 'block');       $(this).find('select').focus();     } else {        $popup.css('display', 'none');      }   });     $('html, body').on('click', function(e){      if ($(e.target).closest('.checkselect').length == 0){       $('.checkselect-popup').css('display', 'none');     }   }); };})(jQuery);  $('.checkselect').checkselect();
</script>
<style>

  .checkselect {
    position: relative;
    
    text-align: left;
  }

  .checkselect-control {
    position: relative;
    padding: 0 !important;
  }

  .checkselect-control select {
	display: block;
	width: 100%;
	height: 35px;
	padding: 8px 13px;
	font-size: 12px;
	line-height: 1.42857;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 3px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
	-o-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
	transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
  }

  .form-control {

}

  .checkselect-over {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    cursor: pointer;
  }

  .checkselect-popup {
    display: none;
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    width: 100%;
    height: auto;
    max-height: 500px;
    position: absolute;
    top: 100%;
    left: 0px;
    border: 1px solid #dadada;
    border-top: none;
    background: #fff;
    z-index: 9999;
    overflow: auto;
    user-select: none;
  }

  .checkselect label {
    position: relative;
    display: block;
    margin: 0;
    padding: 4px 6px 4px 25px;
    font-weight: normal;
    font-size: 1em;
    line-height: 1.1;
    cursor: pointer;
  }

  .checkselect-popup input {
    position: absolute;
    top: 5px;
    left: 8px;
    margin: 0 !important;
    padding: 0;
  }

  .checkselect-popup label:hover {
    background: #03a2ff;
    color: #fff;
  }

  .checkselect-popup fieldset {
    display: block;
    margin: 0;
    padding: 0;
    border: none;
  }

  .checkselect-popup fieldset input {
    left: 15px;
  }

  .checkselect-popup fieldset label {
    padding-left: 32px;
  }

  .checkselect-popup legend {
    display: block;
    margin: 0;
    padding: 5px 8px;
    font-weight: 700;
    font-size: 1em;
    line-height: 1.1;
  }

  label>span:after {
    font-family: FontAwesome;
    color: #1E91CF;
    content: "\f059";
    margin-left: 4px;
  }
  
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

  .float-right {
    float: right !important;
  }

  label > span:after {
    font-family: FontAwesome;
    color: #1E91CF;
    content: "\f059";
    margin-left: 4px;
  }
</style>
<?php echo $footer; ?>