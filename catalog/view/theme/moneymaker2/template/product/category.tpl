<div class="category-wrap">
  <?php echo $header; ?>
  <div class="container">
    <div class="row">

      <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
        <?php foreach ($breadcrumbs as $i => $breadcrumb) { ?>
          <?php if ($i + 1 < count($breadcrumbs)) { ?>
            <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a itemprop="item" href="<?php echo $breadcrumb['href']; ?>"><span itemprop="name"><?php echo $breadcrumb['text']; ?></span></a>
              <meta itemprop="position" content="<?php echo $i + 1; ?>" />
            </li><?php } else { ?><li class="active"><?php echo $breadcrumb['text']; ?></li><?php } ?>
        <?php } ?>
      </ul>


      <?php echo $column_left; ?>

      <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
      <?php } ?>

      <div id="content" class="category <?php echo $class; ?>" itemscope itemtype="https://schema.org/ItemList">
        <meta itemprop="name" content="<?php echo $heading_title; ?>">
        <?php echo $content_top; ?>


        <!-- Новое место Description -->
        <!-- Удалено для переноса вниз -->
        <!-- Не забудь снизу закомментировать js -->

        <!-- LIMITS -->
        <div class="row limits">
          <div class="col-xs-12 col-sm-8 category_title">
            <h1 class="h2 content-title"><?php echo $heading_title; ?></h1>
          </div>
          <div class="col-xs-12 col-sm-4 text-right category_sorts">
            <div class="btn-group text-left">
              <div class="btn-group btn-group-sm dropdown">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                  <?php echo str_replace(":", "", $text_sort); ?><i class="fa fa-fw fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu" id="input-sort">
                  <?php foreach ($sorts as $sorts) { ?>
                    <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                      <li class="active"><a href="<?php echo $sorts['href']; ?>" rel="nofollow"><?php echo $sorts['text']; ?></a></li>
                    <?php } else { ?>
                      <li><a href="<?php echo $sorts['href']; ?>" rel="nofollow"><?php echo $sorts['text']; ?></a></li>
                    <?php } ?>
                  <?php } ?>
                </ul>
              </div>
              <?php if (!$moneymaker2_catalog_layout_switcher_hide) { ?>
                <button type="button" id="list-view" class="btn btn-default btn-sm <?php if ($moneymaker2_catalog_default_view) { ?>active<?php } ?> hidden-xxs" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="<?php echo $button_list; ?>"><i class="fa fa-list"></i></button>
                <button type="button" id="grid-view" class="btn btn-default btn-sm <?php if (!$moneymaker2_catalog_default_view) { ?>active<?php } ?> hidden-xxs" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
              <?php } ?>
              <div class="btn-group btn-group-sm limit-btn-group dropdown">
                <ul class="dropdown-menu pull-right" id="input-limit">
                  <?php foreach ($limits as $limits) { ?>
                    <?php if ($limits['value'] == $limit) { ?>
                      <li class="active"><a href="<?php echo $limits['href']; ?>" rel="nofollow"><small><?php echo $limits['text']; ?></small></a></li>
                      <?php $mmr_limit_active = $limits['text']; ?>
                    <?php } else { ?>
                      <li><a href="<?php echo $limits['href']; ?>" rel="nofollow"><small><?php echo $limits['text']; ?></small></a></li>
                    <?php } ?>
                  <?php } ?>
                </ul>
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-arrows-v hidden-md hidden-lg"></i> <span class="hidden-xs hidden-sm"><?php echo $text_limit; ?> </span><span><?php echo isset($mmr_limit_active) ? $mmr_limit_active : $limits['text']; ?></span><i class="fa fa-fw fa-angle-down"></i>
                </button>
              </div>
            </div>
          </div>
        </div>
        <!-- /LIMITS -->
        <?php if ((!$moneymaker2_catalog_categories_images_hide && $thumb) || ($moneymaker2_common_categories_icons_enabled && $category_icon)) { ?>
          <div class="row catalog-thumb">
            <div class="col-sm-12 text-center">
              <?php if ($moneymaker2_catalog_categories_advantages_enabled && $moneymaker2_categories_advantages_l) { ?><div class="catalog-advantage text-right <?php echo $moneymaker2_categories_advantages_l['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_l['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_l['link']; ?>"><span class="text-right"><?php echo $moneymaker2_categories_advantages_l['name']; ?></span><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_l['icon']; ?> fa-stack-1x fa-inverse"></i></span></div><?php } ?><?php if (!$moneymaker2_catalog_categories_images_hide && $thumb) { ?><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail<?php if ($moneymaker2_catalog_categories_images_round) { ?> img-circle<?php } ?>" /><?php } ?><?php if ($moneymaker2_common_categories_icons_enabled && $category_icon) { ?><span class="fa-stack fa-2x img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $category_icon; ?> fa-stack-1x fa-inverse"></i></span><?php } ?><?php if ($moneymaker2_catalog_categories_advantages_enabled && $moneymaker2_categories_advantages_r) { ?><div class="catalog-advantage text-left <?php echo $moneymaker2_categories_advantages_r['style']; ?>" data-toggle="modal" data-target="#infoModal" data-info-title="<?php echo $moneymaker2_categories_advantages_r['name']; ?>" data-info-description="<?php echo $moneymaker2_categories_advantages_r['link']; ?>"><span class="fa-stack fa-lg img-thumbnail"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-<?php echo $moneymaker2_categories_advantages_r['icon']; ?> fa-stack-1x fa-inverse"></i></span><span class="text-left"><?php echo $moneymaker2_categories_advantages_r['name']; ?></span></div>
              <?php } else if ($moneymaker2_catalog_categories_advantages_enabled && $moneymaker2_categories_advantages_l && !$moneymaker2_categories_advantages_r) { ?>
                <div class="catalog-advantage"></div>
              <?php } ?>
            </div>
          </div>
        <?php } ?>

        <!-- Старое место Description -->
        <?php if ($description == "<p><br></p>") $description = ""; ?>
        <?php if ($description) { ?>
          <div class="row catalog-descr" style="margin-bottom: 40px;">
            <!-- <div class="col-sm-12 col-xlg-10 col-xlg-offset-1"> -->
            <div class="col-sm-12 col-xlg-10">
              <div>
                <?php echo $description; ?>
              </div>
            </div>
          </div>
        <?php } ?>
        <!-- Не забудь раскомментировать JS appendTo внизу файла -->
        <!-- <?php if ($description == "<p><br></p>") $description = ""; ?>
      <?php if ($description) { ?>
          <div class="row catalog-descr<?php if ($moneymaker2_catalog_categories_move_description) { ?> collapse<?php } ?>">
            <div class="col-sm-12 col-xlg-10 col-xlg-offset-1">
            <div class="col-sm-12 col-xlg-10">
              <div>
                <?php echo $description; ?>
              </div>
            </div>
          </div>
      <?php } ?> -->



        <?php if ($categories && !$moneymaker2_catalog_categories_hidechilds) { ?>
          <div class="row catalog-sub">
            <div class="col-sm-12">
              <div class="text-center">
                <?php foreach ($categories as $category) { ?><?php if ($category['thumb']) { ?><div><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" class="img-responsive center-block" />
                    <div class="btn btn-link"><?php if (isset($category['icon']) && $category['icon']) { ?><i class="fa fa-fw fa-<?php echo $category['icon']; ?>"></i> <?php } ?><?php echo $category['name']; ?></div>
                  </a></div><?php } else { ?><a class="btn btn-link" href="<?php echo $category['href']; ?>"><?php if (isset($category['icon']) && $category['icon']) { ?><i class="fa fa-fw fa-<?php echo $category['icon']; ?>"></i> <?php } ?><?php echo $category['name']; ?></a><?php } ?><?php } ?>
              </div>
            </div>
          </div>
        <?php } ?>

        <?php if (((!$moneymaker2_catalog_categories_images_hide && $thumb) || ($moneymaker2_common_categories_icons_enabled && $category_icon)) || ($description && !$moneymaker2_catalog_categories_move_description) || $categories) { ?>
        <?php } ?>

        <?php if ($products) { ?>
          <!-- LIMITS WAS HERE -->

          <div class="row products">
            <?php foreach ($products as $indexOfProduct => $product) { ?>
              <div class="product-layout <?php if ($moneymaker2_catalog_default_view) { ?>product-list<?php } else { ?>product-grid col-lg-2 col-sm-4 col-md-6 col-xs-6<?php } ?> " itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
                <meta itemprop="position" content="<?php echo $indexOfProduct + 1; ?>">

                <div class="product-card-169" data-product-id="<?php echo $product['product_id']; ?>">

                  <!-- Блок изображения с hover-слайдшоу -->
                  <div class="product-card-169__image-container">
                    <div class="product-card-169__image-wrapper" data-additional-images='<?php echo json_encode($product['additional_images']); ?>'>
                      <a href="<?php echo $product['href']; ?>" class="product-card-169__image-link">
                        <img
                          src="<?php echo $product['thumb']; ?>"
                          data-original="<?php echo $product['thumb']; ?>"
                          alt="<?php echo $product['name']; ?>"
                          class="product-card-169__main-image img-responsive" />
                      </a>
                    </div>

                    <!-- Стикеры -->
                    <!-- <?php if ($product['stickers']) { ?>
                      <div class="product-card-169__stickers">
                        <?php foreach ($product['stickers'] as $sticker) { ?>
                          <div class="product-card-169__sticker product-card-169__sticker--<?php echo $sticker['type']; ?>">
                            <?php if ($sticker['type'] == 'delivery') { ?>
                              <span>🚚 Доставим завтра</span>
                            <?php } else { ?>
                              <span><?php echo strip_tags($sticker['caption']); ?></span>
                            <?php } ?>
                          </div>
                        <?php } ?>
                      </div>
                    <?php } ?> -->

                    <!-- Кнопки действий -->
                    <div class="product-card-169__actions">
                      <button type="button" class="product-card-169__action-btn" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                        <i class="fa fa-heart-o"></i>
                      </button>
                      <button type="button" class="product-card-169__action-btn" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                        <i class="fa fa-bar-chart-o"></i>
                      </button>
                    </div>
                  </div>

                  <!-- Информация о товаре -->
                  <div class="product-card-169__info">

                    <!-- Рейтинг -->
                    <?php if ($product['rating']) { ?>
                      <div class="product-card-169__rating">
                        <div class="product-card-169__stars">
                          <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($product['rating'] < $i) { ?>
                              <i class="fa fa-star-o"></i>
                            <?php } else { ?>
                              <i class="fa fa-star"></i>
                            <?php } ?>
                          <?php } ?>
                        </div>
                        <span class="product-card-169__rating-value"><?php echo $product['rating']; ?>.0</span>
                        <span class="product-card-169__reviews">(<?php echo $product['reviews']; ?>)</span>
                      </div>
                    <?php } ?>

                    <!-- Название -->
                    <div class="product-card-169__title">
                      <a href="<?php echo $product['href']; ?>" class="product-card-169__title-link" title="<?php echo $product['name']; ?>">
                        <?php echo $product['name']; ?>
                      </a>
                    </div>

                    <!-- Цветовые свитчи -->
                    <?php if (!empty($product['colors'])) { ?>
                      <div class="product-card-169__colors">
                        <span class="product-card-169__colors-label">Цвет:</span>
                        <div class="product-card-169__colors-list">
                          <?php foreach ($product['colors'] as $color) { ?>
                            <div class="product-card-169__color-swatch"
                              title="<?php echo $color['name']; ?>"
                              style="<?php echo isset($color['image']) ? 'background-image: url(' . $color['image'] . ');' : (isset($color['color_code']) ? 'background-color: ' . strtolower($color['color_code']) . ';' : ''); ?>">
                            </div>
                          <?php } ?>
                        </div>
                      </div>
                    <?php } ?>

                    <!-- Цена -->
                    <div class="product-card-169__price">
                      <?php if ($product['price']) { ?>
                        <?php if ($product['special']) { ?>
                          <span class="product-card-169__price-old"><?php echo $product['price']; ?></span>
                          <span class="product-card-169__price-new"><?php echo $product['special']; ?></span>
                        <?php } else { ?>
                          <span class="product-card-169__price-current"><?php echo $product['price']; ?></span>
                        <?php } ?>
                      <?php } ?>
                    </div>

                    <!-- Кнопка корзины -->
                    <?php if (!$moneymaker2_common_buy_hide) { ?>
                      <button type="button" class="product-card-169__cart-btn" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                        <i class="fa fa-shopping-cart"></i>
                        <span>В корзину</span>
                      </button>
                    <?php } ?>

                  </div>

                  <!-- Hover-блок с характеристиками -->
                  <div class="product-card-169__hover-info">
                    <div class="product-card-169__hover-inner">
                      <div class="product-card-169__attrs">
                        <?php if (!empty($product['attributes'])) { ?>
                          <?php foreach ($product['attributes'] as $attr_name => $attr_value) { ?>
                            <div class="product-card-169__attr-item">
                              <span class="product-card-169__attr-name"><?php echo $attr_name; ?>:</span>
                              <span class="product-card-169__attr-value"><?php echo $attr_value; ?></span>
                            </div>
                          <?php } ?>
                        <?php } ?>

                        <div class="product-card-169__attr-item">
                          <span class="product-card-169__attr-name">Артикул:</span>
                          <span class="product-card-169__attr-value"><?php echo $product['sku']; ?></span>
                        </div>

                        <div class="product-card-169__attr-item">
                          <span class="product-card-169__attr-name">Наличие:</span>
                          <span class="product-card-169__attr-value product-card-169__stock-<?php echo ($product['quantity'] > 0) ? 'in' : 'out'; ?>">
                            <?php echo ($product['quantity'] > 0) ? 'В наличии' : 'Нет в наличии'; ?>
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                </div>
              </div>

              <?php if ($moneymaker2_modules_promo_enabled && $moneymaker2_modules_promos) { ?>
                <?php foreach ($moneymaker2_modules_promos as $moneymaker2_modules_promo) { ?>
                  <?php if ($moneymaker2_modules_promo['sort_order'] == $product['sort_order']) { ?>
                    <div class="product-layout <?php if ($moneymaker2_catalog_default_view) { ?>product-list<?php } else { ?>product-grid<?php } ?>">
                      <div class="product-thumb promo promo-<?php echo $moneymaker2_modules_promo_style; ?>">
                        <div class="image">
                          <?php if ($moneymaker2_modules_stickers_promo_enabled) { ?>
                            <div class="stickers">
                              <div class="sticker text-left">
                                <span class="fa-stack fa-<?php echo $moneymaker2_stickers_size_catalog; ?>" <?php if (!$moneymaker2_stickers_mode) { ?>data-toggle="tooltip" data-placement="right" title="<?php echo strip_tags($moneymaker2_modules_stickers_promo_caption); ?>" <?php } ?>>
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fa fa-<?php echo $moneymaker2_modules_stickers_promo_icon; ?> fa-stack-1x fa-inverse"></i>
                                </span><?php if ($moneymaker2_stickers_mode) { ?><div class="tooltip right in">
                                    <div class="tooltip-arrow"></div>
                                    <div class="tooltip-inner"><?php echo $moneymaker2_modules_stickers_promo_caption; ?></div>
                                  </div><?php } ?>
                              </div>
                            </div>
                          <?php } ?>
                          <img src="<?php echo $moneymaker2_modules_promo['image']; ?>" alt="<?php echo $moneymaker2_modules_promo['text']; ?>" title="<?php echo $moneymaker2_modules_promo['text']; ?>" class="img-responsive" />
                        </div>
                        <div>
                          <div class="caption text-<?php echo $moneymaker2_modules_promo_text_style; ?>">
                            <span><?php echo $moneymaker2_modules_promo['text']; ?></span>
                          </div>
                          <?php if ($moneymaker2_common_price_detached) { ?>
                            <div class="price-detached"><small><span class="text-muted"><?php echo $moneymaker2_modules_stickers_promo_caption; ?></span></small></div>
                          <?php } ?>
                          <?php if ($moneymaker2_modules_promo['link']) { ?>
                          <?php } ?>
                          <div class="additional"></div>
                          <div class="description"><?php echo $moneymaker2_modules_promo['description']; ?></div>
                        </div>
                      </div>
                    </div>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            <?php } ?>
          </div>

          <div class="row paginator">
            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
          </div>
        <?php } ?>
        <?php if (!$categories && !$products) { ?>
          <div class="row">
            <div class="col-sm-12 text-center">
              <p class="h4"><?php echo $text_empty; ?></p>
            </div>
          </div>
          <!-- <div class="buttons"> -->
          <!-- <div class="text-center"><a href="<?php echo $continue; ?>" class="btn btn-default"><i class="fa fa-fw fa-angle-right"></i><?php echo $button_continue; ?></a></div> -->
          <!-- </div> -->
        <?php } ?>
        <?php echo $content_bottom; ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php if ($moneymaker2_catalog_categories_move_description) { ?>
    <script>
      $(document).ready(function() {
        $('.catalog-descr').appendTo($('#content'));
        $('.catalog-descr').show();
      });
    </script>
    <script>
      // image-switcher.js - исправленная версия
      (function($) {
        $(document).ready(function() {

          // Определяем touch-устройство
          const isTouchDevice = 'ontouchstart' in window || navigator.msMaxTouchPoints;

          // Функция для генерации индикаторов
          function createIndicator($wrapper, imageCount) {
            $wrapper.find('.product-card-169__indicators').remove();

            const $indicators = $('<div class="product-card-169__indicators"></div>');

            for (let i = 0; i < imageCount; i++) {
              const $dot = $('<div class="product-card-169__indicator"></div>');
              $dot.data('index', i);

              if (isTouchDevice) {
                $dot.on('click', function(e) {
                  e.stopPropagation();
                  const $wrapper = $(this).closest('.product-card-169__image-wrapper');
                  const index = $(this).data('index');
                  switchToImage($wrapper, index);
                });
              }

              $indicators.append($dot);
            }

            $wrapper.append($indicators);
            return $indicators;
          }

          // Функция для обновления активного индикатора
          function updateActiveIndicator($wrapper, activeIndex) {
            const $indicators = $wrapper.find('.product-card-169__indicators');
            if ($indicators.length === 0) return;

            $indicators.find('.product-card-169__indicator').each(function(index, el) {
              if (index === activeIndex) {
                $(el).addClass('active');
              } else {
                $(el).removeClass('active');
              }
            });
          }

          // Функция для обновления счетчика
          function updateCounter($wrapper, currentIndex, totalCount) {
            // let $counter = $wrapper.find('.product-card-169__counter');

            // if ($counter.length === 0) {
            //     $counter = $('<div class="product-card-169__counter"></div>');
            //     $wrapper.append($counter);
            // }

            // $counter.text((currentIndex + 1) + ' / ' + totalCount);
          }

          // Функция переключения на конкретное изображение
          function switchToImage($wrapper, newIndex) {
            const $img = $wrapper.find('.product-card-169__main-image');
            const images = $wrapper.data('images-array');

            if (!images || !images.length) return;

            newIndex = Math.min(newIndex, images.length - 1);
            newIndex = Math.max(newIndex, 0);

            const currentIndex = $wrapper.data('current-index') || 0;
            if (currentIndex === newIndex) return;

            // Сохраняем новый индекс
            $wrapper.data('current-index', newIndex);

            // Меняем изображение без анимации (быстрее и надежнее)
            $img.attr('src', images[newIndex]);

            // Обновляем индикаторы и счетчик
            updateActiveIndicator($wrapper, newIndex);
            updateCounter($wrapper, newIndex, images.length);
          }

          // Функция сброса к главному изображению
          function resetToMainImage($wrapper) {
            const $img = $wrapper.find('.product-card-169__main-image');
            const originalSrc = $wrapper.data('original-src');
            const images = $wrapper.data('images-array');

            if (!originalSrc) return;

            const currentIndex = $wrapper.data('current-index') || 0;
            if (currentIndex === 0) return;

            // Сбрасываем индекс
            $wrapper.data('current-index', 0);

            // Меняем изображение
            $img.attr('src', originalSrc);

            // Обновляем индикаторы и счетчик
            updateActiveIndicator($wrapper, 0);
            updateCounter($wrapper, 0, images.length);
          }

          // Обрабатываем каждую карточку
          $('.product-card-169__image-wrapper').each(function() {
            const $wrapper = $(this);
            const additionalImages = $wrapper.data('additional-images');

            const $img = $wrapper.find('.product-card-169__main-image');
            const originalSrc = $img.attr('src');

            // Сохраняем оригинальный src
            $wrapper.data('original-src', originalSrc);

            // Формируем массив изображений
            let images = [originalSrc];
            if (additionalImages && additionalImages.length > 0) {
              additionalImages.forEach(function(img) {
                if (img.thumb) images.push(img.thumb);
              });
            }

            // Сохраняем массив изображений
            $wrapper.data('images-array', images);
            $wrapper.data('current-index', 0);

            const imageCount = images.length;

            // Если только одно изображение - выходим
            if (imageCount <= 1) {
              return;
            }

            // Создаем индикаторы и счетчик
            createIndicator($wrapper, imageCount);
            updateCounter($wrapper, 0, imageCount);
            updateActiveIndicator($wrapper, 0);

            // ===== ДЕСКТОП: движение мыши =====
            if (!isTouchDevice) {
              let currentHoverIndex = 0;
              let hoverTimeout = null;

              $wrapper.on('mousemove', function(e) {
                // Очищаем таймер сброса
                if (hoverTimeout) {
                  clearTimeout(hoverTimeout);
                  hoverTimeout = null;
                }

                const rect = this.getBoundingClientRect();
                let x = e.clientX - rect.left;
                let width = rect.width;

                let newIndex = Math.floor((x / width) * imageCount);
                newIndex = Math.min(newIndex, imageCount - 1);
                newIndex = Math.max(newIndex, 0);

                if (newIndex !== currentHoverIndex) {
                  currentHoverIndex = newIndex;
                  switchToImage($wrapper, newIndex);
                }
              });

              $wrapper.on('mouseleave', function() {
                // Устанавливаем таймер для возврата к главному фото
                hoverTimeout = setTimeout(function() {
                  if (currentHoverIndex !== 0) {
                    currentHoverIndex = 0;
                    resetToMainImage($wrapper);
                  }
                  hoverTimeout = null;
                }, 50);
              });
            }

            // ===== МОБИЛЬНЫЕ: touch-события =====
            if (isTouchDevice) {
              let touchStartX = 0;
              let touchEndX = 0;
              let currentIndex = 0;

              $wrapper.on('touchstart', function(e) {
                touchStartX = e.originalEvent.touches[0].clientX;
                currentIndex = $wrapper.data('current-index') || 0;
              });

              $wrapper.on('touchend', function(e) {
                if (!touchStartX) return;

                touchEndX = e.originalEvent.changedTouches[0].clientX;
                const deltaX = touchEndX - touchStartX;
                const minSwipeDistance = 50;

                let newIndex = currentIndex;

                if (Math.abs(deltaX) > minSwipeDistance) {
                  if (deltaX > 0) {
                    // Свайп вправо - предыдущее
                    newIndex = Math.max(0, currentIndex - 1);
                  } else {
                    // Свайп влево - следующее
                    newIndex = Math.min(imageCount - 1, currentIndex + 1);
                  }
                }

                if (newIndex !== currentIndex) {
                  switchToImage($wrapper, newIndex);
                }

                touchStartX = 0;
              });

              $wrapper.on('touchcancel', function() {
                touchStartX = 0;
              });

              // Добавляем класс для мобильных
              $wrapper.addClass('touch-device');
            }
          });

          // Прелоад изображений
          function preloadImages(images) {
            images.forEach(function(src) {
              const img = new Image();
              img.src = src;
            });
          }

          $('.product-card-169__image-wrapper').each(function() {
            const images = $(this).data('images-array');
            if (images && images.length > 1) {
              preloadImages(images.slice(1)); // Прелоадим только дополнительные
            }
          });

        });
      })(jQuery);
    </script>
  <?php } ?>
  <?php if (!empty($breadcrumbs)) { ?>
  <?php
  $breadcrumb_ld = array(
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => array()
  );
  $breadcrumb_pos = 1;
  foreach ($breadcrumbs as $crumb) {
    $item_url = isset($crumb['href']) ? $crumb['href'] : '';
    if ($item_url === '' && $breadcrumb_pos === count($breadcrumbs) && !empty($_SERVER['HTTP_HOST'])) {
      $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
      $item_url = $scheme . '://' . $_SERVER['HTTP_HOST'] . (isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '');
    }
    $crumb_name = isset($crumb['text']) ? strip_tags($crumb['text']) : '';
    $crumb_name = html_entity_decode($crumb_name, ENT_QUOTES, 'UTF-8');
    $breadcrumb_ld['itemListElement'][] = array(
      '@type' => 'ListItem',
      'position' => $breadcrumb_pos,
      'name' => $crumb_name,
      'item' => $item_url
    );
    $breadcrumb_pos++;
  }
  ?>
  <script type="application/ld+json"><?php echo json_encode($breadcrumb_ld, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG); ?></script>
  <?php } ?>
  <?php echo $footer; ?>
</div>