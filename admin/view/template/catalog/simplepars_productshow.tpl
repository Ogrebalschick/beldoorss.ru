<?php echo $header; ?><?php echo $column_left; ?>
<div id="content" xmlns="http://www.w3.org/1999/html">
  <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/styles/default.min.css">
  <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/highlight.min.js"></script>
  <style>
    .thumbnails {
      margin-left: -20px;
    }

    .thumbnails {
      overflow: auto;
      clear: both;
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .thumbnails .image-additional {
      float: left;
      margin-left: 20px;
    }

    .thumbnails > li {
      margin-left: 20px;

    }

    .thumbnails img {
      width: 400px;

    }

    .image-additional {
      max-width: 78px;
    }

    .image-additional img {
      width: 66px;
      height: 66px;
    }
  </style>
  <div class="page-header">
    <div class="container-fluid">
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $bread){ ?>
        <li><a href="<?php echo $bread['href']?>"><?php echo $bread['text']?></a></li>
        <?php }?>
      </ul>
      <div class="pull-right">
        <a href="<?php echo $back_url?>" class="btn btn-success"><i class="fa fa-reply"></i></a>
      </div>
    </div>
  </div>
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
    <div class="alert alert alert-success" hidden id="msg"><i class="fa fa-info-circle"></i></div>
    <form class="form-horizontal" id="form" method="POST">
      <div class="panel panel-default">
        <div class="panel-heading">
          <div class="row">
            <div class="col-md-12">
              <h3 class="panel-title">Результат проверки товара <?php echo '<b>['.$setting['dn_name'].']</b>'?></h3>
            </div>
          </div>
        </div>
        <div class="panel-body">
          <div class="bs-example bs-example-tabs" data-example-id="togglable-tabs">
            <ul class="nav nav-tabs" id="myTabs" role="tablist">
              <?php foreach($mpage as $page){ ?>
              <li role="presentation" class="<?php echo $page['active']?>">
                <a href="<?php echo $page['href']?>" id="home-tab" role="tab" aria-controls="home" aria-expanded="true"><?php echo $page['title']?></a>
              </li>
              <?php }?>
            </ul>
          </div>
          <div class="panel panel-default">
            <div class="panel-body">
              <form class="form-horizontal" method="POST">
                <div class="row">
                  <div class="col-sm-2">
                    <input class="btn btn-success" type="submit" name="go_show" value="Пред просмотр">
                  </div>
                  <div class="col-sm-4">
                    <select class="form-control" name="view_href">
                      <option value="0">Выберите ссылку</option>
                      <?php foreach($links as $link){ ?>
                      <option value="<?php echo $link['link']?>"><?php echo $link['link']?></option>
                      <?php }?>
                    </select>
                  </div>
                  <div class="col-sm-5">
                    <input type="text" name="view_href2" class="form-control" value="<?php echo $view_href?>" placeholder="Вставьте ссылку что бы увидеть результат парсинга.">
                  </div>
                  <div class="col-sm-1">
                    <?php if ($view_href) {?>
                    <a href="<?php echo $view_href?>" target="_blank" class="btn btn-default"><i class="fa fa-link"></i></a>
                    <?php }?>
                  </div>
                </div>
              </form>
            </div>
          </div>
          <div class="panel panel-default">
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-12">
                  <ol class="breadcrumb">
                    <?php if(!empty($product['cat'])){ ?>
                    <?php foreach($product['cat'] as $cat){ ?>
                    <li><a><?php echo $cat?></a></li>
                    <?php }?>
                    <?php }else{ ?>
                    <li><a>Каталог</a></li>
                    <?php }?>
                  </ol>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12">
                  <div class="row">
                    <div class="col-sm-8">
                      <ul class="thumbnails">
                        <?php if(!empty($product['img'])){ ?>
                        <?php foreach($product['img'] as $key => $img){ ?>
                        <li class="<?php echo ($key == 0)?'thumbnail':'image-additional'?>">
                          <img src="<?php echo $img?>" <?php echo ($key == 0)?'':
                        'class="thumbnail"'?>>
                        </li>
                        <?php }?>
                        <?php }else{ ?>
                        <li class="image-additiona">
                          <img src="<?php echo $http_catalog.'image/no_image.png'?>">
                        </li>
                        <?php }?>
                      </ul>
                      <ul class="nav nav-tabs">
                        <li class="active">
                          <a aria-expanded="true" data-toggle="tab"
                             href="#tab-description" style="">
                            Описание
                          </a>
                        </li>
                        <li class="">
                          <a aria-expanded="false" data-toggle="tab"
                             href="#tab-specification" style="">
                            Характеристики
                          </a>
                        </li>
                        <li class="">
                          <a aria-expanded="false" data-toggle="tab"
                             href="#tab-options" style="">
                            Опции
                          </a>
                        </li>
                      </ul>
                      <div class="tab-content">
                        <div class="tab-pane active" id="tab-description">
                          <div>
                            <pre style="border:0; background-color: #fff;"><?php echo @$product['des']?></pre>
                          </div>
                        </div>
                        <div class="tab-pane" id="tab-specification">
                          <table class="table table-striped">
                            <tbody>
                            <?php if(!empty($product['attr'])){?>
                            <?php foreach($product['attr'] as $attr){ ?>
                            <tr>
                              <td><?php echo $attr[0]?></td>
                              <td><?php echo $attr[1]?></td>
                            </tr>
                            <?php }?>
                            <?php }?>
                            </tbody>
                          </table>
                        </div>
                        <div class="tab-pane" id="tab-options">
                          <table class="table table-striped">
                            <tbody>
                            <?php if (!empty($product['opts'])) {?>
                            <?php foreach ($product['opts'] as $opt) {?>
                            <tr>
                              <td>
                                <?php echo ($opt['name']) ? $opt['name'] : 'ID опции по умолчанию = <font color="grean">'.$opt['opt_id'].'</font>'?><?php echo ($opt['required'])?'<font color="red">*</font>':''?>
                              </td>
                              <td>
                                <select class="form-control">
                                  <?php foreach ($opt['value'] as $opt_key => $value) {?>
                                    <option>
                                      <?php echo $value['value'].' | Цена '.$value['price_prefix'].$value['price'].' | Кол-во ('.$value['quant'].')'?>
                                    </option>
                                  <?php }?>
                                </select>
                              </td>
                            </tr>
                            <?php }?>
                            <?php }?>
                          </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                    <div class="col-sm-4">
                      <?php if(!empty($product['name'])){ ?>
                      <h1><?php echo $product['name']?></h1>
                      <?php }else{ ?>
                      <h1 class="text-danger">Название</h1>
                      <?php }?>
                      <ul class="list-unstyled">
                        <?php if(!empty($product['manufac'])){ ?>
                        <li>Производитель: <a><?php echo $product['manufac']?></a></li>
                        <?php }else{ ?>
                        <li>Производитель: <a class="text-danger">Не указан</a></li>
                        <?php }?>
                        <li>Код товара [model]: <?php echo @$product['model']?></li>
                        <li>Артикул [sku]: <?php echo @$product['sku']?></li>
                        <?php if(!empty($product['quant'])){ ?>
                        <li>Количество: <?php echo $product['quant']?></li>
                        <?php }else{ ?>
                        <li>Количество: <span class="text-danger">0</span></li>
                        <?php }?>
                      </ul>
                      <ul class="list-unstyled">
                        <li>
                          <?php if(!empty($product['price'])){ ?>
                          <h2>Цена: <?php echo $product['price'].'р.'?></h2>
                          <?php }else{ ?>
                          <h2 class="text-danger">Цена: 0 р.</h2>
                          <?php }?>
                        </li>
                        <li>
                          <?php if(!empty($product['price_spec'])){ ?>
                          <h4 class="text-warning">Акционная цена: <?php echo $product['price_spec'].'р.'?></h2>
                          <?php }?>
                        </li>
                      </ul>
                      <?php if(!empty($product['file'])){ ?>
                        <h4>Файлы (Будут скачано к вам на сервер)</h4>
                        <?php foreach($product['file'] as $file){ ?>
                          <a href="<?php echo $file[0] ?>"><?php echo $file[1] ?></a></br>
                        <?php } ?>
                      <?php } ?>
                      <?php if(!empty($product['permit_grans_text'])){?>
                        <h2 class="text-danger"><?php echo $product['permit_grans_text']?></h2>
                      <?php }?>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <h3>Отладочная информация</h3>
          <div>

            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#product" aria-controls="home" role="tab" data-toggle="tab">Товар</a></li>
              <li role="presentation"><a href="#seo" aria-controls="profile" role="tab" data-toggle="tab">SEO Шаблон</a></li>

            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="product">
                <div class="panel panel-default">
                <?php if(!empty($product['debug_text']['pr'])){?>
                  <?php foreach($product['debug_text']['pr'] as $dbpr){?>
                    <b><?php echo @$dbpr['name']?></b>
                    <textarea wrap="off" rows="<?php echo $dbpr['row']?>" readonly class="form-control"><?php echo @$dbpr['text']?></textarea>
                    <br>
                  <?php }?>
                <?php }?>
                </div>
              </div>
              <div role="tabpanel" class="tab-pane" id="seo">
                <div class="panel panel-default">
                <?php if(!empty($product['debug_text']['seo'])){?>
                  <?php foreach($product['debug_text']['seo'] as $dbpr){?>
                    <b><?php echo @$dbpr['name']?></b>
                    <textarea wrap="off" rows="<?php echo $dbpr['row']?>" readonly class="form-control"><?php echo @$dbpr['text']?></textarea>
                    <br>
                  <?php }?>
                <?php }?>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  </div>
  <?php echo $footer; ?>
