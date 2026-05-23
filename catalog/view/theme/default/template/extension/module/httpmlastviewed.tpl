<h3 style="padding: 25px 0;"><?php echo $heading_title; ?></h3>

<?php if ($view == 's') : // СТАНДАРТНЫЙ ВИД (сетка) ?>
<div class="<?php echo $rowclass; ?> previouslyViewedItems">
  <?php foreach ($products as $product) : ?>
    <div class="product-layout product-grid <?php echo $class; ?>">
      <div class="product-card-169" data-product-id="<?php echo $product['product_id']; ?>">

        <!-- БЛОК ИЗОБРАЖЕНИЯ С HOVER-СЛАЙДШОУ -->
        <div class="product-card-169__image-container">
          <div class="product-card-169__image-wrapper"
               data-additional-images='<?php echo isset($product['additional_images']) ? json_encode($product['additional_images']) : '[]'; ?>'>
            <a href="<?php echo $product['href']; ?>" class="product-card-169__image-link">
              <img src="<?php echo $product['thumb']; ?>"
                   data-original="<?php echo $product['thumb']; ?>"
                   alt="<?php echo $product['name']; ?>"
                   class="product-card-169__main-image img-responsive" />
            </a>
          </div>

          <!-- СТИКЕРЫ (раскомментируйте, если в $product приходят стикеры) -->
          <?php if (isset($product['stickers']) && $product['stickers']) : ?>
            <div class="product-card-169__stickers">
              <?php foreach ($product['stickers'] as $sticker) : ?>
                <div class="product-card-169__sticker product-card-169__sticker--<?php echo $sticker['type']; ?>">
                  <span><?php echo strip_tags($sticker['caption']); ?></span>
                </div>
              <?php endforeach; ?>
            </div>
          <?php endif; ?>

          <!-- КНОПКИ ДЕЙСТВИЙ -->
          <div class="product-card-169__actions">
            <button type="button" class="product-card-169__action-btn" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
              <i class="fa fa-heart-o"></i>
            </button>
            <button type="button" class="product-card-169__action-btn" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
              <i class="fa fa-bar-chart-o"></i>
            </button>
          </div>
        </div>

        <!-- ИНФОРМАЦИЯ О ТОВАРЕ -->
        <div class="product-card-169__info">
          <!-- Рейтинг -->
          <?php if (isset($product['rating']) && $product['rating']) : ?>
            <div class="product-card-169__rating">
              <div class="product-card-169__stars">
                <?php for ($i = 1; $i <= 5; $i++) : ?>
                  <?php if ($product['rating'] < $i) : ?>
                    <i class="fa fa-star-o"></i>
                  <?php else : ?>
                    <i class="fa fa-star"></i>
                  <?php endif; ?>
                <?php endfor; ?>
              </div>
              <span class="product-card-169__rating-value"><?php echo $product['rating']; ?>.0</span>
              <span class="product-card-169__reviews">(<?php echo isset($product['reviews']) ? $product['reviews'] : '0'; ?>)</span>
            </div>
          <?php endif; ?>

          <!-- Название -->
          <div class="product-card-169__title">
            <a href="<?php echo $product['href']; ?>" class="product-card-169__title-link" title="<?php echo $product['name']; ?>">
              <?php echo $product['name']; ?>
            </a>
          </div>

          <!-- Цветовые свитчи -->
          <?php if (isset($product['colors']) && !empty($product['colors'])) : ?>
            <div class="product-card-169__colors">
              <span class="product-card-169__colors-label">Цвет:</span>
              <div class="product-card-169__colors-list">
                <?php foreach ($product['colors'] as $color) : ?>
                  <div class="product-card-169__color-swatch"
                       title="<?php echo $color['name']; ?>"
                       style="<?php echo isset($color['image']) ? 'background-image: url(' . $color['image'] . ');' : (isset($color['color_code']) ? 'background-color: ' . strtolower($color['color_code']) . ';' : ''); ?>">
                  </div>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endif; ?>

          <!-- Цена -->
          <div class="product-card-169__price">
            <?php if ($product['price']) : ?>
              <?php if ($product['special']) : ?>
                <span class="product-card-169__price-old"><?php echo $product['price']; ?></span>
                <span class="product-card-169__price-new"><?php echo $product['special']; ?></span>
              <?php else : ?>
                <span class="product-card-169__price-current"><?php echo $product['price']; ?></span>
              <?php endif; ?>
            <?php endif; ?>
          </div>

          <!-- Кнопка корзины -->
          <button type="button" class="product-card-169__cart-btn" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo isset($product['minimum']) ? $product['minimum'] : 1; ?>');">
            <i class="fa fa-shopping-cart"></i>
            <span><?php echo $button_cart; ?></span>
          </button>
        </div>

        <!-- HOVER-БЛОК С ХАРАКТЕРИСТИКАМИ -->
        <div class="product-card-169__hover-info">
          <div class="product-card-169__hover-inner">
            <div class="product-card-169__attrs">
              <?php if (isset($product['attributes']) && !empty($product['attributes'])) : ?>
                <?php foreach ($product['attributes'] as $attr_name => $attr_value) : ?>
                  <div class="product-card-169__attr-item">
                    <span class="product-card-169__attr-name"><?php echo $attr_name; ?>:</span>
                    <span class="product-card-169__attr-value"><?php echo $attr_value; ?></span>
                  </div>
                <?php endforeach; ?>
              <?php endif; ?>

              <?php if (isset($product['sku']) && $product['sku']) : ?>
                <div class="product-card-169__attr-item">
                  <span class="product-card-169__attr-name">Артикул:</span>
                  <span class="product-card-169__attr-value"><?php echo $product['sku']; ?></span>
                </div>
              <?php endif; ?>

              <div class="product-card-169__attr-item">
                <span class="product-card-169__attr-name">Наличие:</span>
                <span class="product-card-169__attr-value product-card-169__stock-<?php echo (isset($product['quantity']) && $product['quantity'] > 0) ? 'in' : 'out'; ?>">
                  <?php echo (isset($product['quantity']) && $product['quantity'] > 0) ? 'В наличии' : 'Нет в наличии'; ?>
                </span>
              </div>
            </div>
          </div>
        </div>

      </div> <!-- /.product-card-169 -->
    </div> <!-- /.product-layout -->
  <?php endforeach; ?>
</div>

<?php else : // МИНИМАЛЬНЫЙ ВИД (оставлен без изменений) ?>
  <div class="product-minimal <?php echo $rowclass; ?>">
    <?php foreach ($products as $product) : ?>
      <div class="product-layout <?php echo $class; ?>">
        <div class="product-thumb">
          <div class="row">
            <div class="col-md-4 image">
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
            </div>
            <div class="col-md-8">
              <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
              <?php if ($product['price']) : ?>
                <p class="price">
                  <?php if (!$product['special']) : ?>
                    <?php echo $product['price']; ?>
                  <?php else : ?>
                    <span class="price-new"><?php echo $product['special']; ?></span>
                    <span class="price-old"><?php echo $product['price']; ?></span>
                  <?php endif; ?>
                  <?php if ($product['tax']) : ?>
                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                  <?php endif; ?>
                </p>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
<?php endif; ?>