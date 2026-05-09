<?php echo $header; ?>

<main id="content">
    <section class="maingroup">
        <div class="container">
            <div class="maingroup__inner">
                <?php echo $content_top; ?>
                <!--<div class="maingroup__slider">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="/catalog/view/theme/moneymaker2/image/slider/1.png" alt="">
                        </div class="swiper-slide">
                        <div>
                            <img src="/catalog/view/theme/moneymaker2/image/slider/1.png" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="/catalog/view/theme/moneymaker2/image/slider/1.png" alt="">
                        </div>
                    </div>
                    
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>-->
                <!--<div class="maingroup__stocks">
                    <div class="maingroup__stocks-item">
                        <h2>Акции<br>
                            и спецпредложения</h2>
                        <div><img src="/catalog/view/theme/moneymaker2/image/stocks/1.png" alt=""></div>
                        <h3>Название</h3>
                        <p>Описание</p>
                    </div>
                </div>-->
            </div>
        </div>
    </section>
    <section class="maincategories" itemscope itemtype="https://schema.org/ItemList">
    <meta itemprop="name" content="Категории дверей">
    <div class="container">
        <div class="maincategories__inner">
            <div class="maincategories__item maincategories__inside-doors" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                <meta itemprop="position" content="1">
                <a href="/vhodnye-dveri/" itemprop="url">
                    <div class="maincategories__img">
                        <img src="/catalog/view/theme/moneymaker2/image/maincategories/1.png" alt="Входные двери" itemprop="image">
                    </div>
                    <p itemprop="name">Входные двери</p>
                </a>
            </div>
            <div class="maincategories__item maincategories__mejrooms-doors" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                <meta itemprop="position" content="2">
                <a href="/mezhkomnatnye-dveri/" itemprop="url">
                    <div class="maincategories__img">
                        <img src="/catalog/view/theme/moneymaker2/image/maincategories/2.jpg" alt="Межкомнатные двери" itemprop="image">
                    </div>
                    <p itemprop="name">Межкомнатные двери</p>
                </a>
            </div>
            <div class="maincategories__item maincategories__furniture-doors" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                <meta itemprop="position" content="3">
                <a href="/dvernaya-furnitura/" itemprop="url">
                    <div class="maincategories__img">
                        <img src="/catalog/view/theme/moneymaker2/image/maincategories/3.png" alt="Дверная фурнитура" itemprop="image" style="height:100%">
                    </div>
                    <p itemprop="name">Дверная фурнитура</p>
                </a>
            </div>
            <div class="maincategories__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                <meta itemprop="position" content="4">
                <a href="/dostavka" itemprop="url">
                    <div class="maincategories__img">
                        <img src="/catalog/view/theme/moneymaker2/image/maincategories/4.png" alt="Доставка/Установка/Оплата" itemprop="image">
                    </div>
                    <p itemprop="name">Доставка/Установка/Оплата</p>
                </a>
            </div>
        </div>

        <div class="maincategories__opened">
            <div class="maincategories__opened-item inside-doors__opened">
                <a href="/vhodnye-dveri/dveri-v-dom/" class="category-item category-item__withtext" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <meta itemprop="position" content="1">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Двери в дом</span></h2>
                        <p>(уличные двери, коттедж)</p>
                    </div>
                    <div class="category-item__img">
                        <img src="https://beldoorss.ru/image/category/entrance-doors/street-doors.jpg" alt="Уличные двери" itemscope itemprop="image">
                    </div>
                </a>
                <a href="/vhodnye-dveri/vhodnye-dveri-v-kvartiru/" class="category-item category-item__withtext" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <meta itemprop="position" content="2">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Двери в квартиру</span></h2>
                    </div>
                    <div class="category-item__img">
                        <img src="https://beldoorss.ru/image/category/entrance-doors/apartment-doors.jpg" alt="Двери в квартиру" itemscope itemprop="image">
                    </div>
                </a>
                <a href="/dvustvorchatye-dveri/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="3">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Двухстворчатые</span> двери</h2>
                        <p>нестандартные</p>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/entrance-doors/bivalve.jpg" alt="Двухстворчатые двери нестандартные" itemscope itemprop="image"></div>
                </a>
                <a href="/vhodnye-dveri/vhodnye-dveri-s-umnym-zamkom/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="4">
                    <div class="category-item__text">
                        <h2>Двери с <span>биометрическим</span> замком</h2>
                        <p>(умным, электронным)</p>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/entrance-doors/electric-doors.png" alt="Двери с биометрическим замком(умным, электронным)" itemscope itemprop="image">
                    </div>
                </a>
                <a href="/vhodnye-dveri/tehnicheskie-dveri/protivopozharnye-dveri/"
                    class="category-item category-item__withtext">
                    <meta itemprop="position" content="5">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Противопожарные,</span><br>Технические двери</h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/entrance-doors/fire-doors.jpg" alt="Противопожарные, Технические двери" itemscope itemprop="image"></div>
                </a>
            </div>
            <div class="maincategories__opened-item mejrooms-doors__opened">
                <a href="/specialnye-mezhkomnatnye-dveri" class="category-item category-item__withtext">
                    <meta itemprop="position" content="6">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Специальные</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/interior-doors/special-doors.jpg" alt="Специальные" itemscope itemprop="image"></div>
                </a>
                <a href="/dekor-stenovye-paneli/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="7">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Декор. <br>Стеновые панели</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/interior-doors/decor-wall-panels.jpg" alt="Декор. Стеновые панели" itemscope itemprop="image">
                    </div>
                </a>
                <a href="/mezhkomnatnye-peregorodki/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="8">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Межкомнатные <br>перегородки</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/interior-doors/interior-partitions.jpg" alt="Межкомнатные перегородки" itemscope itemprop="image">
                    </div>
                </a>
            </div>

            <div class="maincategories__opened-item furneturs-doors__opened">
                <a href="/dvernye-ruchki/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="9">
                    <div class="category-item__text">
                        <h2>Дверные <span>ручки</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/fittings/door-handles.png" alt="Дверные ручки" itemscope itemprop="image"></div>
                </a>
                <a href="/dvernye-zamki/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="10">
                    <div class="category-item__text">
                        <h2>Дверные <span>замки</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/fittings/locks-and-latches.png" alt="Дверные замки" itemscope itemprop="image"></div>
                </a>
                <a href="/dvernye-petli/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="11">
                    <div class="category-item__text">
                        <h2>Дверные <span>петли</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/fittings/door-hinges.png" alt="Дверные петли" itemscope itemprop="image"></div>
                </a>
                <a href="/fiksatory-i-nakladki/" class="category-item category-item__withtext">
                    <meta itemprop="position" content="12">
                    <div class="category-item__text">
                        <h2><span itemprop="name">Скобляные изделия</span></h2>
                    </div>
                    <div class="category-item__img"><img
                            src="https://beldoorss.ru/image/category/fittings/hardware.png" alt="Скобляные изделия" itemscope itemprop="image"></div>
                </a>
            </div>
        </div>
</section>
    <section class="brends" itemscope itemtype="https://schema.org/Brand">
        <div class="container">
            <div class="brends__inner">
                <div class="brends__list__wrapper">
                    <ul class="brends__list">
                        <li itemprop="name"><a href="/vhodnye-dveri/p_beldoorss/">Beldoorss</a></li>
                        <li itemprop="name"><a href="/vhodnye-dveri/viral-doors/">Viral</a></li>
                        <li itemprop="name"><a href="/vhodnye-dveri/metaluks/">МетаЛюкс</a></li>
                        <li itemprop="name"><a href="/mezhkomnatnye-dveri/porte_vista/">PorteVista</a></li>
                        <li itemprop="name"><a href="/vhodnye-dveri/labirint-doors/">Лабиринт</a></li>
                        <li itemprop="name"><a href="/dvernaya-furnitura/">Morelli</a></li>
                        <li itemprop="name"><a href="/mezhkomnatnye-dveri/manufacturer-mejkomnatnie/dveri-oka/">Oka</a></li>
                        <li itemprop="name"><a href="/mezhkomnatnye-dveri/manufacturer-mejkomnatnie/regidoors/">Regidoors</a></li>
                        <li itemprop="name"><a href="/mezhkomnatnye-dveri/manufacturer-mejkomnatnie/uberture/">Uberture</a></li>
                        <li itemprop="name"><a href="/mezhkomnatnye-dveri/p_belwooddoors/">Belwooddoors</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
</main>
<?php /*
{{!--<div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <?php if ($moneymaker2_catalog_home_advantages_enabled) { ?>
        <?php if ($moneymaker2_catalog_home_advantages_header) { ?>
          <h1 class="h2 text-center content-title"><?php echo $moneymaker2_catalog_home_advantages_header; ?></h1>
        <?php } ?>
        <?php if ($moneymaker2_catalog_home_advantages_icon) { ?>
          <div class="row catalog-thumb">
            <div class="col-sm-12 text-center">
              <?php if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_l) { ?><div class="catalog-advantage text-right <?php echo $moneymaker2_categories_advantages_l['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_l['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_l['link']; ?>"><span class="text-right"><?php echo $moneymaker2_categories_advantages_l['name']; ?></span><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_l['icon']; ?> fa-stack-1x fa-inverse"></i></span></div><?php } ?><span class="fa-stack fa-2x img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_catalog_home_advantages_icon; ?> fa-stack-1x fa-inverse"></i></span><?php if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_r) { ?><div class="catalog-advantage text-left <?php echo $moneymaker2_categories_advantages_r['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_r['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_r['link']; ?>"><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_r['icon']; ?> fa-stack-1x fa-inverse"></i></span><span class="text-left"><?php echo $moneymaker2_categories_advantages_r['name']; ?></span></div>
              <?php } else if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_l&&!$moneymaker2_categories_advantages_r) { ?>
              <div class="catalog-advantage"></div>
              <?php } ?>
            </div>
          </div>
        <?php } ?>
        <?php if ($moneymaker2_catalog_home_advantages_text) { ?>
        <div class="row catalog-descr">
          <div class="col-sm-12 col-xlg-10 col-xlg-offset-1">
            <div><?php echo $moneymaker2_catalog_home_advantages_text; ?></div>
          </div>
        </div>
        <?php } ?>
        <?php if ($moneymaker2_categories_advantageslinks) { ?>
        <div class="row catalog-sub">
          <div class="col-sm-12">
            <div class="text-center">
              <?php foreach ($moneymaker2_categories_advantageslinks as $value) { ?><a class="btn btn-link" href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['caption']; ?></a><?php } ?>
            </div>
          </div>
        </div>
        <?php } ?>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>--}}
*/ ?>

<div class="container">
<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <?php if ($moneymaker2_catalog_home_advantages_enabled) { ?>
        <?php if ($moneymaker2_catalog_home_advantages_header) { ?>
          <h1 class="h2 text-center content-title"><?php echo $moneymaker2_catalog_home_advantages_header; ?></h1>
        <?php } ?>
        <?php if ($moneymaker2_catalog_home_advantages_icon) { ?>
          <div class="row catalog-thumb">
            <div class="col-sm-12 text-center">
              <?php if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_l) { ?><div class="catalog-advantage text-right <?php echo $moneymaker2_categories_advantages_l['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_l['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_l['link']; ?>"><span class="text-right"><?php echo $moneymaker2_categories_advantages_l['name']; ?></span><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_l['icon']; ?> fa-stack-1x fa-inverse"></i></span></div><?php } ?><span class="fa-stack fa-2x img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_catalog_home_advantages_icon; ?> fa-stack-1x fa-inverse"></i></span><?php if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_r) { ?><div class="catalog-advantage text-left <?php echo $moneymaker2_categories_advantages_r['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_r['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_r['link']; ?>"><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_r['icon']; ?> fa-stack-1x fa-inverse"></i></span><span class="text-left"><?php echo $moneymaker2_categories_advantages_r['name']; ?></span></div>
              <?php } else if ($moneymaker2_catalog_home_advantages_enabled&&$moneymaker2_categories_advantages_l&&!$moneymaker2_categories_advantages_r) { ?>
              <div class="catalog-advantage"></div>
              <?php } ?>
            </div>
          </div>
        <?php } ?>
        <?php if ($moneymaker2_catalog_home_advantages_text) { ?>
        <div class="row catalog-descr">
          <div class="col-sm-12 col-xlg-10 col-xlg-offset-1">
            <div><?php echo $moneymaker2_catalog_home_advantages_text; ?></div>
          </div>
        </div>
        <?php } ?>
        <?php if ($moneymaker2_categories_advantageslinks) { ?>
        <div class="row catalog-sub">
          <div class="col-sm-12">
            <div class="text-center">
              <?php foreach ($moneymaker2_categories_advantageslinks as $value) { ?><a class="btn btn-link" href="<?php echo $value['multilink'] ? $value['multilink'] : $value['link']; ?>"><i class="fa fa-fw fa-<?php echo $value['icon']; ?>"></i> <?php echo $value['caption']; ?></a><?php } ?>
            </div>
          </div>
        </div>
        <?php } ?>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
</div>
<?php echo $footer; ?>