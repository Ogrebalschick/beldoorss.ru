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
    

</style>
<?php if ($moneymaker2_common_minify) { ?>
  <?php foreach ($moneymaker2_minify['ext_css'] as $value) { ?>
  <link href="<?php echo $value['href']; ?>" type="text/css" rel="<?php echo $value['rel']; ?>" media="<?php echo $value['media']; ?>" />
  <?php } ?>
  <link href="min/?g=moneymaker2_css<?php echo $moneymaker2_minify['int_css'] ? "&f=".implode(',', $moneymaker2_minify['int_css']) : ''; ?>&v=271" rel="preload" as="style">
  <link href="min/?g=moneymaker2_css<?php echo $moneymaker2_minify['int_css'] ? "&f=".implode(',', $moneymaker2_minify['int_css']) : ''; ?>&v=271" rel="stylesheet">
  <?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
  <?php } ?>
  <?php foreach ($moneymaker2_minify['ext_js'] as $value) { ?>
  <script src="<?php echo $value; ?>"></script>
  <?php } ?>
  <link href="min/?g=moneymaker2_js<?php echo $moneymaker2_minify['int_js'] ? "&f=".implode(',', $moneymaker2_minify['int_js']) : ''; ?>&v=271" rel="preload" as="script">
  <script src="min/?g=moneymaker2_js<?php echo $moneymaker2_minify['int_js'] ? "&f=".implode(',', $moneymaker2_minify['int_js']) : ''; ?>&v=271"></script>
<?php } else { ?>
  <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
  <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css?v=2" rel="stylesheet" media="screen" />
  <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
  <script src="catalog/view/javascript/jquery/moneymaker2/velocity.min.js"></script>
  <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css?v=270" rel="stylesheet" type="text/css" />
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
    <link href="catalog/view/theme/moneymaker2/stylesheet/general.css" rel="stylesheet">
    <link href="catalog/view/theme/moneymaker2/stylesheet/style_new.css" rel="stylesheet">
    <link href="catalog/view/theme/moneymaker2/stylesheet/style_media.css" rel="stylesheet">

    <?php if (isset($class)) { ?>
      <?php if (strpos($class, 'common-home') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/home.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'product-category') !== false || strpos($class, 'product-manufacturer') !== false || strpos($class, 'product-search') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/catalog.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'product-category') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/category.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'product-manufacturer') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/manufacturer.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'product-search') !== false) { ?>

        <?php } ?>
      <?php if (strpos($class, 'product-compare') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/compare.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'product-product') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/product.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'checkout-') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/checkout.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'account-') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/accounting.css" rel="stylesheet">
      <?php } ?>
      <?php if (strpos($class, 'information-') !== false) { ?>
        <link href="catalog/view/theme/moneymaker2/stylesheet/pages/information.css" rel="stylesheet">
      <?php } ?>
    <?php } ?>
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
                          <?php if (!$moneymaker2_header_categories_menu_hide) { ?>
<div class="header__catalog dropdown<?php if ($moneymaker2_header_categories_menu_mod) { ?> navbar-full-fw<?php } ?> categories-menu">
    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
        <?php echo $moneymaker2_header_categories_menu_caption ? $moneymaker2_header_categories_menu_caption : $text_category; ?>
    </a>
    <?php if ($categories || $moneymaker2_header_banners) { ?>
        <?php if (!$moneymaker2_header_categories_menu_mod) { ?>
            <!-- Обычный режим (не мега-меню) -->
            <ul class="dropdown-menu keep-open">
                <?php foreach ($categories as $key => $category) { ?>
                    <li>
                        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                        <?php if (!$moneymaker2_header_categories_menu_hidechilds) { ?>
                            <?php if ($category['children']) { ?>
                                <ul class="dropdown-submenu">
                                    <?php foreach ($category['children'] as $children) { ?>
                                        <li><a href="<?php echo $children['href']; ?>"><small>- <?php echo $children['name']; ?></small></a></li>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                            <!-- Вывод SEO-страниц для этой категории -->
                            <?php if (isset($seo_by_category[$category['category_id']]) && !empty($seo_by_category[$category['category_id']])) { ?>
                                <?php foreach ($seo_by_category[$category['category_id']] as $seo) { ?>
                                    <li><a href="<?php echo $seo['href']; ?>"><small>- <?php echo $seo['title']; ?></small></a></li>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </li>
                    <?php if (!$moneymaker2_header_categories_menu_hidechilds && $key+1 < count($categories)) { ?>
                        <li role="separator" class="divider"></li>
                    <?php } ?>
                <?php } ?>
            </ul>
        <?php } else { ?>
            <!-- Мега-меню (режим с колонками) -->
            <ul class="dropdown-menu keep-open">
                <li>
                    <div>
                        <div class="row">

                        <?php 
                        $header_categories_by_name = array();
                        foreach ($header_categories as $cat) {
                            $header_categories_by_name[$cat['name']] = $cat['href'];
                        }
                         ?>
                            <?php foreach ($header_categories as $key => $category) { 
                                // Получаем ID категории по href
                                $cat_id = isset($category_id_by_href[$category['href']]) ? $category_id_by_href[$category['href']] : 0;
                            ?>
                                <ul class="col-sm-<?php echo $moneymaker2_header_categories_menu_columns['sm'][0]; ?> col-md-<?php echo $moneymaker2_header_categories_menu_columns['md'][0]; ?> col-lg-<?php echo $moneymaker2_header_categories_menu_columns['lg'][0]; ?> list-unstyled">
                                    <?php if ($category['href']) { ?>
                                        <li class="text-center">
                                            <a href="<?php echo $category['href']; ?>">
                                                <?php if (!$moneymaker2_header_categories_menu_hidethumbs && $category['image']) { ?>
                                                    <div class="hidden-xs"><img class="img-thumbnail" src="<?php echo $category['image']; ?>" alt="<?php echo $category['name']; ?>" /></div>
                                                <?php } ?>
                                                <div class="btn btn-<?php echo (isset($category['style']) && $category['style']) ? $category['style'] : 'default'; ?> btn-block">
                                                    <?php if ($moneymaker2_common_categories_icons_enabled && $category['icon'] && $moneymaker2_header_categories_menu_icons) { ?>
                                                        <i class="fa fa-fw fa-<?php echo $category['icon']; ?>"></i>
                                                    <?php } ?>
                                                    <?php echo $category['name']; ?>
                                                    
                                                </div>
                                            </a>
                                        </li>
                                    <?php } ?>
                                    <?php if (!$moneymaker2_header_categories_menu_hidechilds) { ?>
                                      <?php if ($category['children']) { ?>
    <?php foreach ($category['children'] as $child) { ?>
        <li><a class="text-muted" href="<?php echo $child['href']; ?>"><small>&ndash; <?php echo $child['name']; ?></small></a></li>
        <?php
        // Получаем ID подкатегории по последнему сегменту её SEO-пути
        $child_href = $child['href'];
        $parsed_url = parse_url($child_href);
        $child_path = isset($parsed_url['path']) ? trim($parsed_url['path'], '/') : '';
        $child_seo_key = end(explode('/', $child_path));
        $child_id = isset($category_seo_urls[$child_seo_key]) ? $category_seo_urls[$child_seo_key] : 0;
        
        // Если есть SEO-страницы для этой подкатегории – выводим их
        if ($child_id > 0 && isset($seo_keywords_by_category[$child_id]) && !empty($seo_keywords_by_category[$child_id])) {
            foreach ($seo_keywords_by_category[$child_id] as $seo) {
                $seo_url = rtrim($child['href'], '/') . '/' . $seo['keyword'];
        ?>
            <li><a class="text-muted" href="<?php echo $seo_url; ?>" style="padding-left: 20px;"><small>&ndash; <?php echo $seo['title']; ?></small></a></li>
        <?php
            }
        }
        ?>
    <?php } ?>
<?php } ?>
                                    <?php } ?>

                                    <!-- SEO-страницы для родительской категории (если есть) -->
                                    <?php
                                    $parent_href = $category['href'];
                                    $parsed_url = parse_url($parent_href);
                                    $parent_path = isset($parsed_url['path']) ? trim($parsed_url['path'], '/') : '';
                                    $parent_seo_key = explode('/', $parent_path)[0];
                                    $parent_cat_id = isset($category_seo_urls[$parent_seo_key]) ? $category_seo_urls[$parent_seo_key] : 0;
                                    if ($parent_cat_id > 0 && isset($seo_keywords_by_category[$parent_cat_id]) && !empty($seo_keywords_by_category[$parent_cat_id])) {
                                        foreach ($seo_keywords_by_category[$parent_cat_id] as $seo) {
                                            $seo_url = rtrim($category['href'], '/') . '/' . $seo['keyword'];
                                    ?>
                                        <li><a class="text-muted" href="<?php echo $seo_url; ?>"><small>&ndash; <?php echo $seo['title']; ?></small></a></li>
                                    <?php
                                        }
                                    }
                                    ?>

                                    <?php if (isset($category['text']) && $category['text']) { ?>
                                        <li><?php echo $category['text']; ?></li>
                                    <?php } ?>
                                </ul>
                                <?php if (($key+1) % $moneymaker2_header_categories_menu_columns['sm'][1] == 0) { ?><div class="clearfix visible-sm"></div><?php } ?>
                                <?php if (($key+1) % $moneymaker2_header_categories_menu_columns['md'][1] == 0) { ?><div class="clearfix visible-md"></div><?php } ?>
                                <?php if (($key+1) % $moneymaker2_header_categories_menu_columns['lg'][1] == 0) { ?><div class="clearfix visible-lg"></div><?php } ?>
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
    <main>
