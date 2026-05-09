<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta name="yandex-verification" content="e46adb8b67e69704" />
<meta charset="UTF-8" />
<meta id="myViewport" name="viewport" content="width=390">
<meta name="apple-mobile-web-app-capacity" content="yes">

<meta name="yandex-verification" content="253c912ab2cef130" />

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<!-- mmr2 2.7.0 oc2.3 -->
<style>
    @font-face{font-display:swap;font-family:'Open Sans';font-style:normal;font-weight:300;src: url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.eot');src: local('Open Sans Light'), local('OpenSans-Light'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.eot?#iefix') format('embedded-opentype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.woff2') format('woff2'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.woff') format('woff'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.ttf') format('truetype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-300.svg#OpenSans') format('svg')}@font-face{font-display:swap;font-family:'Open Sans';font-style:normal;font-weight:400;src: url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.eot');src: local('Open Sans'), local('OpenSans'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.eot?#iefix') format('embedded-opentype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.woff2') format('woff2'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.woff') format('woff'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.ttf') format('truetype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-regular.svg#OpenSans') format('svg')}@font-face{font-display:swap;font-family:'Open Sans';font-style:normal;font-weight:700;src: url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.eot');src: local('Open Sans Bold'), local('OpenSans-Bold'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.eot?#iefix') format('embedded-opentype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.woff2') format('woff2'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.woff') format('woff'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.ttf') format('truetype'),url('catalog/view/theme/moneymaker2/fonts/open-sans-v13-latin-ext_latin_cyrillic-700.svg#OpenSans') format('svg')}@font-face{font-display:swap;font-family:'FontAwesome';font-weight:normal;font-style:normal;src: url('../fonts/fontawesome-webfont.eot?v=4.7.0');src: url('catalog/view/javascript/font-awesome/fonts/fontawesome-webfont.eot?#iefix&v=4.7.0') format('embedded-opentype'),url('catalog/view/javascript/font-awesome/fonts/fontawesome-webfont.woff2?v=4.7.0') format('woff2'),url('catalog/view/javascript/font-awesome/fonts/fontawesome-webfont.woff?v=4.7.0') format('woff'),url('catalog/view/javascript/font-awesome/fonts/fonts/fontawesome-webfont.ttf?v=4.7.0') format('truetype'),url('catalog/view/javascript/font-awesome/fonts/fonts/fontawesome-webfont.svg?v=4.7.0#fontawesomeregular') format('svg')}
    @media screen and (max-width:768px){
  .headerMenu>li{
    display: grid;
    
}

.headerMenu>li>ul{
        padding: 0 10px!important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.3);
        padding-bottom: 10px!important;
}

.headerMenu>li>a{
        padding-bottom: 5px;
    margin-bottom: 5px;
}
.headerMenu>li.active> ul{
     position: revert!important;
}
.headerMenu>li>a{
    pointer-events: none;
}
.headerMenu>li.active a.active{
    pointer-events: all;
}
}

</style>
<?php if ($moneymaker2_common_minify) { ?>
  <?php foreach ($moneymaker2_minify['ext_css'] as $value) { ?>
  <link href="<?php echo $value['href']; ?>" type="text/css" rel="<?php echo $value['rel']; ?>" media="<?php echo $value['media']; ?>" />
  <?php } ?>
  <link href="min/?g=moneymaker2_css<?php echo $moneymaker2_minify['int_css'] ? "&f=".implode(',', $moneymaker2_minify['int_css']) : ''; ?>&v=270" rel="preload" as="style">
  <link href="min/?g=moneymaker2_css<?php echo $moneymaker2_minify['int_css'] ? "&f=".implode(',', $moneymaker2_minify['int_css']) : ''; ?>&v=270" rel="stylesheet">
  <?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
  <?php } ?>
  <?php foreach ($moneymaker2_minify['ext_js'] as $value) { ?>
  <script src="<?php echo $value; ?>"></script>
  <?php } ?>
  <link href="min/?g=moneymaker2_js<?php echo $moneymaker2_minify['int_js'] ? "&f=".implode(',', $moneymaker2_minify['int_js']) : ''; ?>&v=270" rel="preload" as="script">
  <script src="min/?g=moneymaker2_js<?php echo $moneymaker2_minify['int_js'] ? "&f=".implode(',', $moneymaker2_minify['int_js']) : ''; ?>&v=270"></script>
<?php } else { ?>
  <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
  <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
  <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
  <script src="catalog/view/javascript/jquery/moneymaker2/velocity.min.js"></script>
  <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css?v=270" rel="stylesheet" type="text/css" />
  <link href="catalog/view/theme/moneymaker2/stylesheet/fonts.css" rel="stylesheet">
  <script src="catalog/view/javascript/common.moneymaker2.js" type="text/javascript"></script>
  
  <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
  <?php } ?>
  
  <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
  <?php } ?>
  
  <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>"></script>
  <?php } ?>
<?php } ?>

    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
    
    <script src="catalog/view/theme/moneymaker2/js/main.min.js?v=1"></script>
    <link href="catalog/view/theme/moneymaker2/stylesheet/style_new.css" rel="stylesheet">
    <link href="catalog/view/theme/moneymaker2/stylesheet/style_media.css" rel="stylesheet">
</head>
<body class="<?php echo $class; ?>">
    <header>
        <div class="header__inner">
            <div class="header__top">
                <div class="container">
                    <div class="header__top-inner">
                        <div class="header__logo">
                            <?php if ($moneymaker2_header_logo_custom) { ?>
                                <?php if ($home == $moneymaker2_header_url) { ?>
                                  <span class="fa-stack fa-lg"><i class="fa fa-circle fa-inverse fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_header_logo_custom_icon; ?> fa-stack-1x"></i></span>
                                  <span class="text-primary"><?php echo $moneymaker2_header_logo_custom_header; ?></span>
                                  <small><?php echo $moneymaker2_header_logo_custom_caption; ?></small>
                                <?php } else { ?>
                                  <a href="<?php echo $home; ?>">
                                    <span class="fa-stack fa-lg"><i class="fa fa-circle fa-inverse fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_header_logo_custom_icon; ?> fa-stack-1x"></i></span>
                                    <span class="text-primary"><?php echo $moneymaker2_header_logo_custom_header; ?></span>
                                    <small><?php echo $moneymaker2_header_logo_custom_caption; ?></small>
                                  </a>
                                <?php } ?>
                              <?php } else { ?>
                                <?php if ($logo) { ?>
                                  <?php if ($home == $moneymaker2_header_url) { ?>
                                  <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                                  <?php } else { ?>
                                  <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                                  <?php } ?>
                                <?php } else { ?>
                                <h2><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h2>
                                <?php } ?>
                            <?php } ?>
                        </div>
                        <div class="burger"><img src="catalog/view/theme/moneymaker2/image/svg/burger.svg" alt=""></div>
                        <?php if ($moneymaker2_header_menu_links_top_enabled&&$moneymaker2_header_links) { ?>
                            <ul class="header__navbar">
                            <?php foreach ($moneymaker2_header_links as $value) { ?>
                                <?php if (strpos($value['caption'], '::')) { ?>
                                    <?php $subvalue['title'] = substr($value['caption'], 0, strpos($value['caption'], '::')); ?>
                                    <?php $subvalue['caption'] = explode(', ', substr($value['caption'], strpos($value['caption'], '::')+3, strlen($value['caption']))); ?>
                                    <?php $subvalue['link'] = $value['multilink'] ? explode(', ', $value['multilink']) : explode(', ', $value['link']); ?>
                                    
                                    <?php if (count($subvalue['caption'])==count($subvalue['link'])) { ?>
                                        <li class="dropdown">
                                          <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $subvalue['title']; ?> <i class="fa fa-angle-down"></i></a>
                                          <ul class="dropdown-menu">
                                            <?php for ($i = 0; $i < count($subvalue['caption']); $i++) { ?>
                                              <li><a href="<?php echo $subvalue['link'][$i]; ?>"><?php echo $subvalue['caption'][$i]; ?></a></li>
                                            <?php } ?>
                                          </ul>
                                        </li>
                                    <?php } ?>
                                <?php } else { ?>
                                  <li><a href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['caption']; ?></a></li>
                                <?php } ?>
                            <?php } ?>
                            </ul>
                        <?php } ?>
                        <div class="header__contacts">
                            <?php
                            $phone = $moneymaker2_header_contacts_phone ? $moneymaker2_header_contacts_phone : $telephone;

                            // Удаляем всё, кроме цифр (\d) и знака плюс (+)
                            $phoneWithoutSymbols = preg_replace('/[^\d+]/', '', $phone);
                            ?>
                            <div class="header__buttons">
                                <a href="https://t.me/<?php echo $phoneWithoutSymbols; ?>"><img src="catalog/view/theme/moneymaker2/image/svg/telegram.svg" alt=""></a>
                                <a href="https://wa.me/<?php echo $phoneWithoutSymbols; ?> "><img src="catalog/view/theme/moneymaker2/image/svg/whatsapp.svg" alt=""></a>
                                <a href="tel:<?php echo $phoneWithoutSymbols; ?>" class="header-phone-btn-mobile"><img src="catalog/view/theme/moneymaker2/image/svg/phone.svg" alt=""></a>
                            </div>
                            <div id="contacts" class="header__call dropdown">
                                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                                        <?php echo $moneymaker2_header_contacts_phone ? $moneymaker2_header_contacts_phone : $telephone; ?> 
                                        <?php if ($moneymaker2_header_contacts||$moneymaker2_modules_callback_enabled) { ?>
                                            <span class="hidden-sm">
                                            <?php echo $moneymaker2_header_contacts_title; ?> 
                                            </span>
                                        <?php } ?>
                                    <span>Обратный звонок</span>
                                </a>
                                <?php if ($moneymaker2_header_contacts||$moneymaker2_modules_callback_enabled) { ?>
                                    <ul class="dropdown-menu" style="border: 1px #333 solid">
                                      <?php if ($moneymaker2_modules_callback_enabled) { ?>
                                      <li class="dropdown-header keep-open"><?php echo $moneymaker2_modules_callback_header; ?></li>
                                      <li><button type="button" data-toggle="modal" data-target="#orderModal" <?php if ($moneymaker2_modules_callback_image) { ?>data-order-img-src="<?php echo $moneymaker2_modules_callback_image; ?>"<?php } ?> data-order-mode="callback" data-order-title="<?php echo $moneymaker2_modules_callback_header; ?>"><i class="fa fa-lg fa-fw fa-volume-control-phone"></i> <?php echo $moneymaker2_modules_callback_caption; ?></button></li>
                                      <li class="divider"></li>
                                      <?php } ?>
                                      <?php foreach ($moneymaker2_header_contacts as $key => $value) { ?>
                                      <?php if ($value['mode']) { ?>
                                      <?php if ($value['mode']==1) { ?>
                                      <li class="dropdown-header keep-open"><?php echo $value['text']; ?></li>
                                      <?php } else if ($value['mode']==2) { ?>
                                      <?php if ($value['link']||$value['multilink']) { ?>
                                      <li class="keep-open"><a href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><?php if ($value['image']) { ?><span class="fa fa-fw fa-lg"><img src="<?php echo $value['image']; ?>" alt="<?php echo $value['text']; ?>" /></span><?php } ?> <?php echo $value['text']; ?></a></li>
                                      <?php } else { ?>
                                      <li class="keep-open"><span class="text-muted"><?php if ($value['image']) { ?><span class="fa fa-fw fa-lg"><img src="<?php echo $value['image']; ?>" alt="<?php echo $value['text']; ?>" /></span><?php } ?> <?php echo $value['text']; ?></span></li>
                                      <?php } ?>
                                      <?php } else if ($value['mode']==3) { ?>
                                      <?php if ($value['link']||$value['multilink']) { ?>
                                      <li class="keep-open"><a href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><i class="fa fa-lg fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['text']; ?></a></li>
                                      <?php } else { ?>
                                      <li class="keep-open"><span class="text-muted"><i class="fa fa-lg fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['text']; ?></span></li>
                                      <?php } ?>
                                      <?php } else if ($value['mode']==4) { ?>
                                      <li class="divider"></li>
                                      <?php } ?>
                                      <?php } ?>
                                      <?php } ?>
                                    </ul>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="menu">
                <?php if ($moneymaker2_header_menu_links_top_enabled&&$moneymaker2_header_links) { ?>
                    <ul class="header__navbar">
                    <?php foreach ($moneymaker2_header_links as $value) { ?>
                        <?php if (strpos($value['caption'], '::')) { ?>
                            <?php $subvalue['title'] = substr($value['caption'], 0, strpos($value['caption'], '::')); ?>
                            <?php $subvalue['caption'] = explode(', ', substr($value['caption'], strpos($value['caption'], '::')+3, strlen($value['caption']))); ?>
                            <?php $subvalue['link'] = $value['multilink'] ? explode(', ', $value['multilink']) : explode(', ', $value['link']); ?>
                            
                            <?php if (count($subvalue['caption'])==count($subvalue['link'])) { ?>
                                <li class="dropdown">
                                  <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $subvalue['title']; ?> <i class="fa fa-angle-down"></i></a>
                                  <ul class="dropdown-menu">
                                    <?php for ($i = 0; $i < count($subvalue['caption']); $i++) { ?>
                                      <li><a href="<?php echo $subvalue['link'][$i]; ?>"><?php echo $subvalue['caption'][$i]; ?></a></li>
                                    <?php } ?>
                                  </ul>
                                </li>
                            <?php } ?>
                        <?php } else { ?>
                          <li><a href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['caption']; ?></a></li>
                        <?php } ?>
                    <?php } ?>
                    </ul>
                <?php } ?>
                <div class="header__contacts">
                    <div class="header__buttons">
                        <a href="#"><img src="catalog/view/theme/moneymaker2/image/svg/telegram.svg" alt=""></a>
                        <a href="#"><img src="catalog/view/theme/moneymaker2/image/svg/whatsapp.svg" alt=""></a>
                    </div>
                    <div class="header__call">
                        <a href="tel:<?php echo $phoneWithoutSymbols; ?>">
                            <?php $moneymaker2_header_contacts_phone ? $moneymaker2_header_contacts_phone : $telephone ?>
                            <span>Обратный звонок</span>
                        </a>
                    </div>
                </div>
                <div class="header__buttons-bottom">
                    <a href="#"><img src="catalog/view/theme/moneymaker2/image/svg/favorite.svg" alt=""></a>
                    <a href="#"><img src="catalog/view/theme/moneymaker2/image/svg/cart.svg" alt=""></a>
                </div>
            </div>
            <div class="header__bottom-wrap">
            <div class="header__bottom">
                <div class="container">
                    <div class="header__bottom-inner">
                      <div class="header__menu">
                        <div class="header__menu-btn">Каталог</div>
                            <div class="header__menu-inner">
                                <ul class="headerMenu">
                                    <li>
                                        <a href="/vhodnye-dveri/">Входные двери</a>
                                        <ul>
                                            <li><a href="/vhodnye-dveri/dveri-v-dom/">Двери в дом</a></li>
                                            <li><a href="/vhodnye-dveri/dveri-v-kvartiru/">Двери в квартиру</a></li>
                                            <li><a href="/vhodnye-dveri/dvustvorchatye-dveri/">Двустворчатые двери</a></li>
                                            <li><a href="/vhodnye-dveri/dveri-s-umnym-biometricheskim-zamkom/">Двери с умным ( биометрическим) замком</a></li>
                                            <li><a href="/vhodnye-dveri/tehnicheskie-dveri/protivopozharnye-dveri/">Противопожарные, Технические двери</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="/mezhkomnatnye-dveri/">Межкомнатные двери</a>
                                        <ul>
                                            <li><a href="/specialnye-mezhkomnatnye-dveri/">Специальные</a></li>
                                            <li><a href="/dekor-stenovye-paneli/">Декор. Стеновые панели</a></li>
                                            <li><a href="/mezhkomnatnye-peregorodki/">Межкомнатные перегородки</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="/dvernaya-furnitura-v-internet-magazine/">Дверная фурнитура</a>
                                        <ul>
                                            <li><a href="/dvernaya-furnitura-v-internet-magazine/dvernye-ruchki/">Дверные ручки</a></li>
                                            <li><a href="/dvernaya-furnitura-v-internet-magazine/dvernye-zamki/">Дверные замки</a></li>
                                            <li><a href="/dvernaya-furnitura-v-internet-magazine/dvernye-petli/">Дверные петли</a></li>
                                            <li><a href="/dvernaya-furnitura-v-internet-magazine/skobyanye-izdeliya/">Скобляные изделия</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                          </div>
                        <?php if (!$moneymaker2_header_categories_menu_hide) { ?>
                            <div class="header__catalog dropdown<?php if ($moneymaker2_header_categories_menu_mod) { ?> navbar-full-fw<?php } ?> categories-menu">
                                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                                    <?php echo $moneymaker2_header_categories_menu_caption ? $moneymaker2_header_categories_menu_caption : $text_category; ?>
                                </a>
                                <?php if ($categories||$moneymaker2_header_banners) { ?>
                                    <?php if (!$moneymaker2_header_categories_menu_mod) { ?>
                                        <ul class="dropdown-menu keep-open">
                                          <?php foreach ($categories as $key => $category) { ?>
                                          <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                                          <?php if (!$moneymaker2_header_categories_menu_hidechilds) { ?>
                                          <?php if ($category['children']) { ?>
                                          <?php foreach ($category['children'] as $children) { ?>
                                          <li><a href="<?php echo $children['href']; ?>"><small>- <?php echo $children['name']; ?></small></a></li>
                                          <?php } ?>
                                          <?php } ?>
                                          <?php } ?>
                                          <?php if (!$moneymaker2_header_categories_menu_hidechilds) { ?>
                                          <?php if ($key+1 < count($categories)) { ?>
                                          <li role="separator" class="divider"></li>
                                          <?php } ?>
                                          <?php } ?>
                                          <?php } ?>
                                        </ul>
                                    <?php } else { ?>
                                        <ul class="dropdown-menu keep-open">
                                          <li>
                                            <div>
                                              <div class="row">
                                                <?php foreach ($header_categories as $key => $category) { ?>
                                                <ul class="col-sm-<?php echo $moneymaker2_header_categories_menu_columns['sm'][0]; ?> col-md-<?php echo $moneymaker2_header_categories_menu_columns['md'][0]; ?> col-lg-<?php echo $moneymaker2_header_categories_menu_columns['lg'][0]; ?> list-unstyled">
                                                  <?php if ($category['href']) { ?><li class="text-center"><a href="<?php echo $category['href']; ?>"><?php if (!$moneymaker2_header_categories_menu_hidethumbs&&$category['image']) { ?><div class="hidden-xs"><img class="img-thumbnail" src="<?php echo $category['image']; ?>" alt="<?php echo $category['name']; ?>" /></div><?php } ?><div class="btn btn-<?php if(isset($category['style'])&&$category['style']) { ?><?php echo $category['style']; ?><?php } else { ?>default<?php } ?> btn-block"><?php if ($moneymaker2_common_categories_icons_enabled&&$category['icon']&&$moneymaker2_header_categories_menu_icons) { ?><i class="fa fa-fw fa-<?php echo $category['icon']; ?>"></i><?php } ?> <?php echo $category['name']; ?></div></a></li><?php } ?>
                                                  <?php if (!$moneymaker2_header_categories_menu_hidechilds) { ?>
                                                  <?php if ($category['children']) { ?>
                                                  <?php foreach ($category['children'] as $children) { ?>
                                                  <li><a class="text-muted" href="<?php echo $children['href']; ?>"><small>&ndash; <?php echo $children['name']; ?></small></a></li>
                                                  <?php } ?>
                                                  <?php } ?>
                                                  <?php } ?>
                                                  <?php if(isset($category['text'])&&$category['text']) { ?>
                                                  <li><?php echo $category['text']; ?></li>
                                                  <?php } ?>
                                                </ul>
                                                <?php if (($key+1)%$moneymaker2_header_categories_menu_columns['sm'][1]==0) { ?><div class="clearfix visible-sm"></div><?php } ?>
                                                <?php if (($key+1)%$moneymaker2_header_categories_menu_columns['md'][1]==0) { ?><div class="clearfix visible-md"></div><?php } ?>
                                                <?php if (($key+1)%$moneymaker2_header_categories_menu_columns['lg'][1]==0) { ?><div class="clearfix visible-lg"></div><?php } ?>
                                                <?php } ?>
                                              </div>
                                            </div>
                                          </li>
                                        </ul>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <div id="search" class="navbar-form header__search">
                          <div class="form-group">
                            <ul class="keep-open list-unstyled">
                              <li>
                                <div class="input-group collapse">
                                  <input type="text" name="search" value="" placeholder="<?php echo $text_search; ?>" class="form-control">
                                </div>
                              </li>
                            </ul>
                          </div>
                        </div>
                        <div class="header__buttons-bottom">
                            <?php if (!$moneymaker2_common_wishlist_hide) { ?>
                                <a href="<?php echo $wishlist; ?>" rel="nofollow" id="wishlist">
                                    <img src="catalog/view/theme/moneymaker2/image/svg/favorite.svg" alt="">
                                    <span id="wishlist-total">
                                        <?php if ($text_wishlist) { ?>
                                            <span><?php echo $text_wishlist; ?></span>
                                        <?php } ?>
                                    </span>
                                </a>
                              <?php } ?>
                            <!--<a href="#"><img src="catalog/view/theme/moneymaker2/image/svg/cart.svg" alt=""></a>-->
                            <?php if (!$moneymaker2_common_buy_hide) { ?>
                                <?php echo $cart; ?>
                            <?php } ?>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
        
    </header>
   <button id="scrollToTopBtn" title="Go to top">▲</button>
<script>
    $('.headerMenu>li').click(function(){

    setTimeout(() => {
        $('.headerMenu>li a').removeClass('active')
    $(this).find('a').addClass('active');
    }, 100);
})
</script>
    <main>