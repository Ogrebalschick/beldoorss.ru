<?php echo $header; ?>

<section class="product">
    <div class="container">
        <div class="row">
            <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
                <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
                <?php if($i+1<count($breadcrumbs)) { ?>
                
                <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a itemprop="item"
                        href="<?php echo $breadcrumb['href']; ?>"><span itemprop="name">
                            <?php echo $breadcrumb['text']; ?>
                        </span></a>
                    <meta itemprop="position" content="<?php echo $i+1; ?>" />
                </li>
                <?php } else { ?>
                <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem" hidden><a itemprop="item"
                        href="" class="catalogTitle"><span itemprop="name">
                            
                        </span></a>
                    <meta itemprop="position" content="<?php echo $i+1; ?>" />
                </li>
                <li class="active">
                    <?php echo $breadcrumb['text']; ?>
                </li>
                <?php } ?>
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
            
            <div id="content" class="col-xs-12 <?php echo $class; ?>" itemscope itemtype="https://schema.org/Product">
                <?php echo $content_top; ?>
                
                <div class="product__inner">
                    <h1 class="product__title" itemprop="name">
                        <?php if ($moneymaker2_product_metatitles_enabled) { ?>
                        <?php echo $meta_title; ?>
                        <?php } else { ?>
                        <?php echo $heading_title; ?>
                        <?php } ?>
                    </h1>
                    <div class="row product__main">
                        <div class="col-xs-12 col-sm-4 product__gallery">
                            <?php if ($thumb || $images) { ?>
                                <?php if ($thumb) { ?>
                                    <div class="product__gallery-top">
                                        <?php /*{{!--<?php if ($stickers) { ?>
                                            <div class="stickers">
                                                <?php foreach ($stickers as $sticker) { ?>
                                                <div class="sticker text-left sticker-<?php echo $sticker['type']; ?>">
                                                    <span class="fa-stack fa-<?php echo $moneymaker2_stickers_size_product; ?>"
                                                        <?php if (!$moneymaker2_stickers_mode) { ?>data-toggle="tooltip"
                                                        data-placement="right" title="
                                                        <?php echo strip_tags($sticker['caption']); ?>"
                                                        <?php } ?>>
                                                        <i class="fa fa-circle fa-stack-2x"></i>
                                                        <i
                                                            class="fa fa-<?php echo $sticker['icon']; ?> fa-stack-1x fa-inverse"></i>
                                                    </span>
                                                    <?php if ($moneymaker2_stickers_mode) { ?>
                                                    <div class="tooltip right in">
                                                        <div class="tooltip-arrow"></div>
                                                        <div class="tooltip-inner">
                                                            <?php echo $sticker['caption']; ?>
                                                        </div>
                                                    </div>
                                                    <?php } ?>
                                                </div>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>
                                        
                                        <?php if ($rating) { ?>
                                            <div class="rating" itemprop="aggregateRating" itemscope
                                                itemtype="https://schema.org/AggregateRating">
                                                <meta itemprop="reviewCount"
                                                    content="<?php echo preg_replace('/[^0-9]/', '', $tab_review); ?>" />
                                                <meta itemprop="ratingValue" content="<?php echo $rating; ?>" />
                                                <?php for ($i = 5; $i >= 1; $i--) { ?>
                                                <?php if ($rating < $i) { ?>
                                                <i class="fa fa-lg fa-star"></i>
                                                <?php } else { ?>
                                                <i class="fa fa-lg fa-star active"></i>
                                                <?php } ?>
                                                <?php } ?>
                                            </div>
                                        <?php } ?>--}}*/ ?>
                                        
                                        <a class="thumbnail" href="<?php echo $popup; ?>"
                                            title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>"
                                            title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"
                                            itemprop="image" /></a>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                            
                            <?php if ($thumb || $images) { ?>
                                <?php if ($images) { ?>
                                    <div class="product__gallery-bottom thumbnails image-additional">
                                        <div class="owl-carousel owl-moneymaker2">
                                            <?php foreach ($images as $image) { ?>
                                                <a class="item thumbnail" href="<?php echo $image['popup']; ?>"
                                                    title="<?php echo $heading_title; ?>"><img class="img-circle"
                                                        src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>"
                                                        alt="<?php echo $heading_title; ?>" /></a>
                                            <?php } ?>
                                        </div>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        </div>
                        
                        <div class="col-xs-12 col-sm-8 product__info" id="product" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                            <meta itemprop="priceCurrency" content="<?php echo $moneymaker2_currency; ?>" />
                            <meta itemprop="price" content="<?php echo rtrim(preg_replace(" /[^0-9\.]/", "" ,
                                ($special ? $special : $price)), '.' ); ?>" />
                            <link itemprop="availability" href="https://schema.org/<?php echo ($quantity>0 ? "
                                InStock" : "OutOfStock" ) ?>" />
                            <meta itemprop="priceValidUntil"
                                content="<?php echo date('Y-m-d', strtotime('+1 week')); ?>" />
                            <link itemprop="url" href="<?php echo end($breadcrumbs)['href']; ?>"
                                content="<?php echo end($breadcrumbs)['href']; ?>" property="" />
                                
                            <div class="row">    
                                <div class="col-xs-12 col-sm-6 product-left">
                                    
                                    <?php if ($options) { ?>
                                        <div class="options">
                                            <?php foreach ($options as $option_key => $option) { ?>
                                                <?php if ($option['type'] == 'radio') { ?>
                                                    <div class="product__types radioblock-<?php echo $option_key; ?>">
                                                        <?php if (strpos($option['name'], 'Размер полотна') === 0) { ?>
                                                            <div class="optionSize form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input type="radio" 
																				    name="option[<?php echo $option['product_option_id']; ?>]"	
                                                                                    value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                                <?php if ($option_value['image']) { ?>
                                                                                    <img src="<?php echo $option_value['image']; ?>"
                                                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                        class="img-thumbnail" />
                                                                                <?php } ?>
                                                                                <b><?php echo $option_value['name']; ?></b>
                                                                                <?php if ($option_value['price']) { ?>
                                                                                    
                                                                                    
                                                                                <?php } ?>
                                                                            </label>
                                                                        </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'Цвет') === 0) { ?>
                                                            <div class="optionColor form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                    <div class="radio">
                                                                        <label data-toggle="tooltip" title="<?php echo $option_value['name']; ?>">
                                                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                            <?php if ($option_value['image']) { ?>
                                                                                <img src="<?php echo $option_value['image']; ?>"
                                                                                    alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                    class="img-thumbnail" />
                                                                            <?php } ?>
                                                                            <!--<b><?php echo $option_value['name']; ?></b><br>-->
                                                                            <!--<?php if ($option_value['price']) { ?>
                                                                                <?php echo $option_value['price']; ?>
                                                                            <?php } ?>-->
                                                                        </label>
                                                                    </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'ЦВЕТ-ВИСТ') === 0) { ?>
                                                            <div class="optionColor form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                    <div class="radio">
                                                                        <label data-toggle="tooltip" title="<?php echo $option_value['name']; ?>">
                                                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                            <?php if ($option_value['image']) { ?>
                                                                                <img src="<?php echo $option_value['image']; ?>"
                                                                                    alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                    class="img-thumbnail" />
                                                                            <?php } ?>
                                                                            <!--<b><?php echo $option_value['name']; ?></b><br>-->
                                                                            <!--<?php if ($option_value['price']) { ?>
                                                                                <?php echo $option_value['price']; ?>
                                                                            <?php } ?>-->
                                                                        </label>
                                                                    </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'Размер двери') === 0) { ?>
                                                            <div class="optionSize form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input type="radio"
                                                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                                                    value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                                <?php if ($option_value['image']) { ?>
                                                                                    <img src="<?php echo $option_value['image']; ?>"
                                                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                        class="img-thumbnail" />
                                                                                <?php } ?>
                                                                                <b><?php echo $option_value['name']; ?></b>
                                                                                <?php if ($option_value['price']) { ?>
                                                                                    
                                                                                    
                                                                                <?php } ?>
                                                                            </label>
                                                                        </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'Сторона открывания') === 0) { ?>
                                                            <div class="openingSide form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input type="radio"
                                                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                                                    value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                                <?php if ($option_value['image']) { ?>
                                                                                    <img src="<?php echo $option_value['image']; ?>"
                                                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                        class="img-thumbnail" />
                                                                                <?php } ?>
                                                                                <b><?php echo $option_value['name']; ?></b>
                                                                                <?php if ($option_value['price']) { ?>
                                                                                    
                                                                                    
                                                                                <?php } ?>
                                                                            </label>
                                                                        </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'Остекление') === 0) { ?>
                                                            <div class="optionSize form-group<?php echo ($option['required'] ? ' required' : ''); ?> option-osteclenie">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input type="radio"
                                                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                                                    value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                                <?php if ($option_value['image']) { ?>
                                                                                    <img src="<?php echo $option_value['image']; ?>"
                                                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                        class="img-thumbnail" />
                                                                                <?php } ?>
                                                                                <b><?php echo $option_value['name']; ?></b>
                                                                                <?php if ($option_value['price']) { ?>
                                                                                    
                                                                                    
                                                                                <?php } ?>
                                                                            </label>
                                                                        </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                        <?php if (strpos($option['name'], 'Терморазрыв') === 0) { ?>
                                                            <div class="optionSize form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                                <label class="control-label">
                                                                    <?php echo $option['name']; ?>
                                                                </label>
                                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input type="radio"
                                                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                                                    value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                                <?php if ($option_value['image']) { ?>
                                                                                    <img src="<?php echo $option_value['image']; ?>"
                                                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                        class="img-thumbnail" />
                                                                                <?php } ?>
                                                                                <b><?php echo $option_value['name']; ?></b>
                                                                                <?php if ($option_value['price']) { ?>
                                                                                    
                                                                                    
                                                                                <?php } ?>
                                                                            </label>
                                                                        </div>
                                                                    <?php } ?>
                                                                </div>
                                                            </div>
                                                        <?php } ?>
                                                    </div>
                                                <?php } ?>
                                            <?php } ?>
                                            <hr>
                                        </div>
                                    <?php } ?>  
                                </div>    
                                <div class="col-xs-12 col-sm-6 product-right">
                                    <div class="product-points">
                                        <?php if ($moneymaker2_product_points_stock) { ?>
                                            <div class="stock-<?php echo $moneymaker2_product_points_stock_id; ?>">
                                                <span
                                                    class="fa-stack fa-<?php echo $moneymaker2_product_points_size; ?> pull-left"><i
                                                        class="fa fa-circle fa-stack-1x" style="line-height: 1em !important;"></i><i
                                                        class="fa fa-<?php echo $moneymaker2_product_points_stock_icon; ?> fa-stack-1x fa-inverse"></i></span>
                                                <span class="h4">
                                                    <?php echo $text_stock; ?>
                                                    <?php echo $stock; ?>
                                                </span>
                                                <div class="text-muted">
                                                    <?php echo $moneymaker2_product_points_stock_caption; ?>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        
                                        <?php if ($moneymaker2_product_points_manufacturer&&$manufacturer) { ?>
                                            <div>
                                                <img class="img-circle text-center pull-left"
                                                    src="<?php echo $moneymaker2_manufacturer_image; ?>"
                                                    title="<?php echo $manufacturer; ?>" alt="<?php echo $manufacturer; ?>">
                                                <span class="h4">
                                                    <?php echo $text_manufacturer; ?>
                                                    <?php echo $manufacturer; ?>
                                                </span>
                                                <div class="text-muted"><a href="<?php echo $manufacturers; ?>"
                                                        title="<?php echo $moneymaker2_product_points_manufacturer_caption; ?> - <?php echo $manufacturer; ?>">
                                                        <?php echo $moneymaker2_product_points_manufacturer_caption; ?>
                                                    </a></div>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    
                                    <?php if ($category_name == 'Межкомнатные двери') { ?>
                                        <?php if ($price_base) { ?>
                                            <div class="product-total price_base active">
                                                <div class="product-total__inner">
                                                    <div>Цена за полотно</div>
                                                    
                                                    <?php if ($options) { ?>
                                                        <?php foreach ($options as $option_key => $option) { ?>
                                                            <?php if (strpos($option['name'], 'Остекление') === 0) { ?>
                                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                  
                                                                    <div class="price-new"><?php echo $price_base; ?></div>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    <?php } else if (!isset($special_base)) { ?>
                                                        <div class="price-new"><?php echo $price_base; ?></div>
                                                    <?php } else { ?>
                                                        <div class="price-new"><b><?php echo $special_base; ?></b></div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                     
                                    
                                    <?php if ($category_name == 'Входные двери') { ?>
                                        <?php if ($price_base) { ?>
                                            <div class="product-total active">
                                                <div class="product-total__inner">
                                                    <div>Цена</div>
                                                    <?php if ($moneymaker2_common_price_detached) { ?>
                                            <?php if ($price) { ?>
                                                <span class="product-price price__detached">
                                                    <?php if (!isset($special_base)) { ?>
                                                        <div class="price-new"><?php echo $price_base; ?></div>
                                                    <?php } else { ?>
                                                        <div class="price-new"><b><?php echo $special_base; ?></b></div>
                                                    <?php } ?>
                                                </span>
                                            <?php } ?>
                                        <?php } ?>
                                                </div>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                    
                                    <?php if ($options) { ?>
                                        <div class="options">
                                            <?php foreach ($options as $option_key => $option) { ?>
                                                <?php if ($option['type'] == 'checkbox') { ?>
                                                    <?php if (strpos($option['name'], 'Комплект') === 0) { ?>
                                                        <div class="checkblock-<?php echo $option_key; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                            <label class="product-total checkbox-option control-label">
                                                                <div class="product-total__inner">
                                                                    <div><?php echo $option['name']; ?></div>
                                                                    <div class="product-price"><?php echo $option['summ_option']; ?></div>
                                                                </div>
                                                                <i class="fa fa-fw fa-angle-down"></i>
                                                            </label>
                                                            
                                                            <div id="input-option<?php echo $option['product_option_id']; ?>" class="input-option" style="display: none;">
                                                                <?php if ($price_base) { ?>
                                                                        <div class="checkbox">
                                                                            <?php if (!isset($special_base)) { ?>
                                                                                <label>Полотно ( = <?php echo $price_base; ?> )</label>
                                                                            <?php } else { ?>
                                                                                <label>Полотно ( = <?php echo $special_base; ?> )</label>
                                                                            <?php } ?>
                                                                        </div>
                                                                <?php } ?>
                                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                <div class="checkbox">
                                                                    <label>
                                                                        <input type="checkbox"
                                                                            name="option[<?php echo $option['product_option_id']; ?>][]"
                                                                            value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                            
                                                                        <?php if ($option_value['image']) { ?>
                                                                            <img src="<?php echo $option_value['image']; ?>"
                                                                                alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                class="img-thumbnail" />
                                                                        <?php } ?>
                                                                        
                                                                        <?php echo $option_value['name']; ?>
                                                                        
                                                                        <?php if ($option_value['price']) { ?>
                                                                            (
                                                                            <?php echo $option_value['price_prefix']; ?>
                                                                            <?php echo $option_value['price']; ?>
                                                                            )
                                                                        <?php } ?>
                                                                    </label>
                                                                </div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                    <?php } else if (strpos($option['name'], 'Дополнительные') === 0) { ?>
                                                        <div class="checkblock-<?php echo $option_key; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?> options-more">
                                                            <label class="product-total checkbox-option control-label">
                                                                <div class="product-total__inner">
                                                                    <div><?php echo $option['name']; ?></div>
                                                                </div>
                                                                <i class="fa fa-fw fa-angle-down"></i>
                                                            </label>
                                                            
                                                            <div id="input-option<?php echo $option['product_option_id']; ?>" class="input-option" style="display: none;">
                                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                <div class="checkbox">
                                                                    <label>
                                                                        <input type="checkbox"
                                                                            name="option[<?php echo $option['product_option_id']; ?>][]"
                                                                            value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                            
                                                                        <?php if ($option_value['image']) { ?>
                                                                            <img src="<?php echo $option_value['image']; ?>"
                                                                                alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                                class="img-thumbnail" />
                                                                        <?php } ?>
                                                                        
                                                                        <?php echo $option_value['name']; ?>
                                                                        
                                                                        <?php if ($option_value['price']) { ?>
                                                                            (
                                                                            <?php echo $option_value['price_prefix']; ?>
                                                                            <?php echo $option_value['price']; ?>
                                                                            )
                                                                        <?php } ?>
                                                                    </label>
                                                                </div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                    <?php } ?>
                                                <?php } ?>
                                            <?php } ?>
                                            <hr>
                                        </div>
                                    <?php } ?>
                                    
                                    <div class="product__price-group">
                                        <!--Отдельная цена-настройки-->
                                        <?php if ($moneymaker2_common_price_detached) { ?>
                                            <?php if ($price) { ?>
                                                <span class="product-price price__detached">
                                                    <?php if (!$special) { ?>
                                                        <div class="price-new"><?php echo $price; ?></div>
                                                    <?php } else { ?>
                                                        <div class="price-new"><b><?php echo $special; ?></b></div> 
                                                        <div class="price-old"><?php echo $price; ?></div>
                                                    <?php } ?>
                                                </span>
                                            <?php } ?>
                                        <?php } ?>
                                        
                                        <div class="quantity_wrap">
                                            <!--Функция покупки-настройки-->
                                            <?php if (!$moneymaker2_common_buy_hide) { ?>
                                                <div class="quantity_inner">
                                                    <button 
                                                        type="button" 
                                                        data-info-title="<?php echo $button_cart; ?>" 
                                                        id="button-cart"
                                                        data-toggle="tooltip" 
                                                        data-html="true"
                                                        data-placement="bottom" 
                                                        title="<?php echo $addtocart_tooltip; ?>">
                                                        <!--если не включена Отдельная цена-настройки-->
                                                        <?php if (!$moneymaker2_common_price_detached) { ?>
                                                            <?php if ($price && $special) { ?>
                                                                <?php echo $special; ?>
                                                            <?php } else if ($price) { ?>
                                                                <?php echo $price; ?>
                                                            <?php } ?>
                                                        <?php } else { ?>
                                                            <?php echo $button_cart; ?>
                                                        <?php } ?>
                                                    </button>
                                                    <div class="product-quantity">
                                                        <button type="button" id="quantity-sub" class="quantity-sub">&minus;</button>
                                                        <input 
                                                            type="number" 
                                                            data-toggle="tooltip" 
                                                            data-placement="bottom" 
                                                            min="1"
                                                            name="quantity" 
                                                            value="<?php echo $minimum; ?>" 
                                                            size="2" 
                                                            id="input-quantity"
                                                            class="form-control<?php if ($moneymaker2_common_buy_hide) { ?> hidden<?php } ?>"
                                                            title="<?php echo $entry_qty; ?>"
                                                            autocomplete="off" />
                                                        <button type="button" id="quantity-add" class="quantity-add">&plus;</button>
                                                    </div>
                                                </div>
                                            <?php } ?>
                                            <!--Закладки-настройки-->
                                            <?php if (!$moneymaker2_common_wishlist_hide) { ?>
                                                <button type="button"
                                                    class="product-wishlist" 
                                                    <?php if (!$moneymaker2_common_wishlist_caption) { ?>
                                                    data-toggle="tooltip" data-placement="bottom"<?php } ?>
                                                    title="<?php echo $button_wishlist; ?>" 
                                                    onclick="wishlist.add('<?php echo $product_id; ?>');">
                                                    <i class="fa fa-fw fa-heart"></i>
                                                    <?php if ($moneymaker2_common_wishlist_caption) { ?>
                                                        <?php echo $button_wishlist; ?>
                                                    <?php } ?>
                                                </button>
                                            <?php } ?>
                                        </div>
                                        
                                        <!--Сравнение-настройки-->
                                        <?php if (!$moneymaker2_common_compare_hide) { ?>
                                            <button type="button"
                                                class="btn btn-default hidden-xs" <?php if
                                                (!$moneymaker2_common_compare_caption) { ?>data-toggle="tooltip"
                                                data-placement="bottom"
                                                <?php } ?>title="
                                                <?php echo $button_compare; ?>" onclick="compare.add('
                                                <?php echo $product_id; ?>');"><i class="fa fa-fw fa-area-chart"></i>
                                                <?php if ($moneymaker2_common_compare_caption) { ?>
                                                <?php echo $button_compare; ?>
                                                <?php } ?>
                                            </button>
                                        <?php } ?>
                                    </div>
                                    
                                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                    
                                    <!--Быстрый заказ-настройки-->
                                    <?php if ($moneymaker2_modules_quickorder_enabled) { ?>
                                        <div class="product_quickorder <?php echo $quickorder_class; ?>" 
                                            <?php if (!$product_sold) { ?>
                                                data-toggle="modal" data-target="#orderModal" data-order-mode="product"
                                                data-order-product-id="<?php echo $product_id; ?>" 
                                                data-order-title="<?php echo $heading_title; ?>" 
                                                data-order-img-src="<?php echo $quickorder_thumb; ?>" 
                                                data-order-price="
                                                    <?php if ($price&&$special) { ?>
                                                        <?php echo strip_tags($special); ?>
                                                    <?php } else if ($price) { ?>
                                                        <?php echo strip_tags($price); ?>
                                                    <?php } ?>"
                                            <?php } ?>>
                                            <span <?php if (strip_tags($quickorder_tooltip)) { ?> 
                                                data-toggle="tooltip" 
                                                data-html="true" 
                                                data-placement="bottom" title="<?php echo $quickorder_tooltip; ?>"
                                                    <?php } ?>>
                                                <?php echo $moneymaker2_modules_quickorder_button_title; ?>
                                            </span>
                                        </div>
                                    <?php } ?>    
                                    
                                    <?php if ($moneymaker2_modules_quickorder_enabled) { ?>
                                        <div class="product_quickorder <?php echo $quickorder_class; ?>" 
                                            <?php if (!$product_sold) { ?>
                                                data-toggle="modal" data-target="#orderModal" data-order-mode="product"
                                                data-order-product-id="<?php echo $product_id; ?>" 
                                                data-order-title="<?php echo $heading_title; ?>" 
                                                data-order-img-src="<?php echo $quickorder_thumb; ?>" 
                                                data-order-price="
                                                    <?php if ($price&&$special) { ?>
                                                        <?php echo strip_tags($special); ?>
                                                    <?php } else if ($price) { ?>
                                                        <?php echo strip_tags($price); ?>
                                                    <?php } ?>"
                                            <?php } ?>>
                                            <span <?php if (strip_tags($quickorder_tooltip)) { ?> 
                                                data-toggle="tooltip" 
                                                data-html="true" 
                                                data-placement="bottom" title="<p>Заказать замеры бесплатно</p>"
                                                    <?php } ?>>
                                                Заказать замеры бесплатно
                                            </span>
                                        </div>
                                    <?php } ?>    

                                    <?php if ($moneymaker2_product_points) { ?>
                                        <?php foreach ($moneymaker2_product_points as $key => $value) { ?>
                                        <div class="moneymaker2_product_points">
                                            <?php if ($value['icon'] == '--') $value['icon'] = ''  ?>
                                            <?php if ($value['icon']) { ?>
                                                <span class="fa-stack fa-<?php echo $moneymaker2_product_points_size; ?> pull-left">
                                                    <i class="fa fa-<?php echo $value['icon']; ?> fa-stack-1x fa-inverse"></i>
                                                </span>
                                            <?php } ?>
                                            <?php if ($value['name']) { ?>
                                                <span class="h4">
                                                    <?php echo $value['name']; ?>
                                                </span>
                                            <?php } ?>
                                            <?php if ($value['text']) { ?>
                                                <div class="product_points-text">
                                                    <?php echo $value['text']; ?>
                                                </div>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
            <?php if ($attribute_groups) { ?>
            <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
            <?php } ?>
            <?php if ($review_status) { ?>
            <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
            <!-- <li><a href="/dostavka">Доставка/установка/оплата</a></li> -->
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
            <?php if ($attribute_groups) { ?>
            <div class="tab-pane" id="tab-specification">
              <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
                        
                        
                            <?php if ($review_status) { ?>
                                <div class="tab-pane fade<?php if ($moneymaker2_product_tabs_hide) { ?> in active<?php } ?>" id="tab-review">
                                    <form class="form-horizontal" id="form-review">
                                        <?php if ($moneymaker2_product_tabs_headers) { ?>
                                        <h3 class="text-center">
                                            <?php echo $moneymaker2_product_review_header; ?>
                                        </h3>
                                        <?php } ?>
                                        <div id="review">
                                            <?php if ($moneymaker2_product_tabs_reviews_indexed) { ?>
                                            <?php if ($reviews) { ?>
                                            <?php foreach ($reviews as $review) { ?>
                                            <div class="panel <?php if (true) { if ($review['rating'] >= 4) { ?>panel-success<?php } else if ($review['rating'] == 3) { ?>panel-warning<?php } else { ?>panel-danger<?php } } else { ?>panel-default<?php } ?> "
                                                itemprop="review" itemscope itemtype="https://schema.org/Review">
                                                <div class="panel-heading">
                                                    <div class="pull-left">
                                                        <b itemprop="author">
                                                            <?php echo $review['author']; ?>
                                                        </b>
                                                    </div>
                                                    <div class="text-right" itemprop="reviewRating" itemscope
                                                        itemtype="https://schema.org/Rating">
                                                        <meta itemprop="worstRating" content="1">
                                                        <meta itemprop="bestRating" content="5">
                                                        <meta itemprop="ratingValue" content="<?php echo $review['rating']; ?>">
                                                        <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                        <?php if ($review['rating'] < $i) { ?>
                                                        <i class="fa fa-star-o"></i>
                                                        <?php } else { ?>
                                                        <i class="fa fa-star"></i>
                                                        <?php } ?>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="panel-body">
                                                    <p itemprop="reviewBody">
                                                        <?php echo $review['text']; ?>
                                                    </p>
                                                    <p class="text-right text-muted">
                                                        <time itemprop="datePublished"
                                                            datetime="<?php echo $review['date_added']; ?>">
                                                            <?php echo $review['date_added']; ?>
                                                        </time>
                                                    </p>
                                                </div>
                                            </div>
                                            <?php } ?>
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <?php echo $pagination; ?>
                                                </div>
                                            </div>
                                            <?php } else { ?>
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <p>
                                                        <?php echo $text_no_reviews; ?>
                                                    </p>
                                                </div>
                                            </div>
                                            <?php } ?>
                                            <?php } ?>
                                        </div>
                                        <h4 class="h3 text-center">
                                            <?php echo $text_write; ?>
                                        </h4>
                                        <?php if ($review_guest) { ?>
                                        <div class="form-group required">
                                            <label class="col-sm-2 control-label" for="input-name">
                                                <?php echo $entry_name; ?>
                                            </label>
                                            <div class="col-sm-4">
                                                <input type="text" name="name" value="<?php echo $customer_name; ?>"
                                                    id="input-name" class="form-control" />
                                            </div>
                                            <label class="col-sm-2 control-label">
                                                <?php echo $entry_rating; ?>
                                            </label>
                                            <div class="col-sm-4">
                                                <input type="number" data-max="5" data-min="1" name="rating"
                                                    class="form-control moneymaker2-rating" />
                                            </div>
                                        </div>
                                        <div class="form-group required">
                                            <label class="col-sm-2 control-label" for="input-review">
                                                <?php echo $entry_review; ?>
                                            </label>
                                            <div class="col-lg-8 col-md-9 col-sm-10 ">
                                                <textarea name="text" rows="3" id="input-review"
                                                    class="form-control"></textarea>
                                            </div>
                                        </div>
                                        <?php echo $captcha; ?>
                                        <div class="form-group required">
                                            <div class="buttons clearfix col-sm-offset-2 col-sm-10">
                                                <button type="button" id="button-review"
                                                    data-loading-text="<i class='fa fa-spinner fa-spin'></i> <?php echo $text_loading; ?>"
                                                    class="btn btn-default"><i class="fa fa-pencil"></i>
                                                    <?php echo $button_submit; ?>
                                                </button>
                                            </div>
                                        </div>
                                        <?php } else { ?>
                                        <?php echo $text_login; ?>
                                        <?php } ?>
                                    </form>
                                </div>
                            <?php } ?>
                            <?php if ($moneymaker2_product_tabs) { ?>
                                <?php foreach ($moneymaker2_product_tabs as $key => $value) { ?>
                                    <?php if ($value['link']) { ?>
                                        <div class="tab-pane fade<?php if ($moneymaker2_product_tabs_hide) { ?> in active<?php } ?>"
                                            id="tab-additional-<?php echo $key; ?>">
                                            <?php if ($moneymaker2_product_tabs_headers) { ?>
                                            <h3 class="text-center">
                                                <?php echo $value['name']; ?>
                                            </h3>
                                            <?php } ?>
                                            <div id="tab-additional-content-<?php echo $key; ?>"></div>
                                            <script><!--
                                            $(function() { $('#tab-additional-content-<?php echo $key; ?>').load('index.php?route=information/information/agree&information_id=<?php echo $value['link']; ?>');});
                                            //--></script>
                                        </div>
                                    <?php } ?>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>
                    <hr>
                </div>
                
                <?php if ($products) { ?>
                    <div class="h2 text-center text_related">
                        <div class="h2 text-center text_related">
                            <?php echo $text_related; ?>
                        </div>
                        <div class="row related_carousel">
                            <?php if ($moneymaker2_product_related_carousel) { ?>
                            <div class="owl-carousel owl-moneymaker2 owl-moneymaker2-products owl-moneymaker2-products-related">
                                <?php } ?>
                                <?php foreach ($products as $key => $product) { ?>
                                <div class="product-layout product-grid">
                                    <div class="product-thumb">
                                        <div class="image">
                                            <?php if ($product['stickers']) { ?>
                                            <div class="stickers">
                                                <?php foreach ($product['stickers'] as $sticker) { ?>
                                                <div class="sticker text-left sticker-<?php echo $sticker['type']; ?>">
                                                    <span class="fa-stack fa-<?php echo $moneymaker2_stickers_size_catalog; ?>"
                                                        <?php if (!$moneymaker2_stickers_mode) { ?>data-toggle="tooltip"
                                                        data-placement="right" title="
                                                        <?php echo strip_tags($sticker['caption']); ?>"
                                                        <?php } ?>>
                                                        <i class="fa fa-circle fa-stack-2x"></i>
                                                        <i class="fa fa-<?php echo $sticker['icon']; ?> fa-stack-1x fa-inverse"></i>
                                                    </span>
                                                    <?php if ($moneymaker2_stickers_mode) { ?>
                                                    <div class="tooltip right in">
                                                        <div class="tooltip-arrow"></div>
                                                        <div class="tooltip-inner">
                                                            <?php echo $sticker['caption']; ?>
                                                        </div>
                                                    </div>
                                                    <?php } ?>
                                                </div>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <?php if ($product['rating']) { ?>
                                            <div class="rating">
                                                <?php for ($i = 5; $i >= 1; $i--) { ?>
                                                <?php if ($product['rating'] < $i) { ?>
                                                <i class="fa fa-star"></i>
                                                <?php } else { ?>
                                                <i class="fa fa-star active"></i>
                                                <?php } ?>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>"
                                                    alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"
                                                    class="img-responsive" /></a>
                                        </div>
                                        <div>
                                            <div class="caption">
                                                <a href="<?php echo $product['href']; ?>" <?php if ($product['special']) { ?>
                                                    class="text-special"
                                                    <?php } ?>>
                                                    <?php echo $product['name']; ?>
                                                </a>
                                            </div>
                                            <?php if ($moneymaker2_common_price_detached) { ?>
                                            <div class="price-detached"><small>
                                                    <?php if ($product['price']) { ?><span class="price text-muted">
                                                        <?php if (!$product['special']) { ?>
                                                        <?php echo $product['price']; ?>
                                                        <?php } else { ?><span class="price-new"><b>
                                                                <?php echo $product['special']; ?>
                                                            </b></span> <span class="price-old">
                                                            <?php echo $product['price']; ?>
                                                        </span>
                                                        <?php } ?>
                                                    </span>
                                                    <?php } ?>
                                                    <?php if ($product['tax']) { ?><br /><span class="price-tax text-muted">
                                                        <?php echo $text_tax; ?>
                                                        <?php echo $product['tax']; ?>
                                                    </span>
                                                    <?php } ?>
                                                </small></div>
                                            <?php } ?>
                                            <div class="btn-group btn-group-sm">
                                                <?php if (!$moneymaker2_common_buy_hide) { ?>
                                                <button type="button" data-toggle="tooltip" data-html="true" data-placement="bottom"
                                                    title="<?php echo $product['addtocart_tooltip']; ?>"
                                                    class="<?php echo $product['addtocart_class']; ?>" <?php if (!$product['sold'])
                                                    { ?>onclick="cart.add('
                                                    <?php echo $product['product_id']; ?>', '
                                                    <?php echo $product['minimum']; ?>');"
                                                    <?php } ?>><i class="fa fa-fw fa-shopping-cart"></i>
                                                    <?php if (!$moneymaker2_common_price_detached&&$product['price']) { ?><span
                                                        class="price">
                                                        <?php if (!$product['special']) { ?>
                                                        <?php echo $product['price']; ?>
                                                        <?php } else { ?><span class="price-new">
                                                            <?php echo $product['special']; ?>
                                                        </span>
                                                        <?php } ?>
                                                    </span>
                                                    <?php } else { ?>
                                                    <?php echo $button_cart; ?>
                                                    <?php } ?>
                                                </button>
                                                <?php } ?>
                                                <?php if ($moneymaker2_modules_quickorder_enabled&&$moneymaker2_modules_quickorder_display_catalog) { ?>
                                                <div class="<?php echo $product['quickorder_class']; ?>" <?php if
                                                    (!$product['sold']) { ?>data-toggle="modal" data-target="#orderModal"
                                                    data-order-mode="catalog" data-order-product-id="
                                                    <?php echo $product['product_id']; ?>" data-order-title="
                                                    <?php echo $product['name']; ?>" data-order-img-src="
                                                    <?php echo $product['thumb']; ?>" data-order-price="
                                                    <?php if (!$product['special']) { ?>
                                                    <?php echo $product['price']; ?>
                                                    <?php } else { ?>
                                                    <?php echo $product['special']; ?>
                                                    <?php } ?>"
                                                    <?php } ?>><span data-toggle="tooltip" data-html="true" data-placement="bottom"
                                                        title="<?php echo $product['quickorder_tooltip']; ?>"><i
                                                            class="fa fa-fw fa-send"></i></span>
                                                </div>
                                                <?php } ?>
                                                <?php if (!$moneymaker2_common_wishlist_hide) { ?><button type="button"
                                                    class="btn btn-default" <?php if (!$moneymaker2_common_wishlist_caption) {
                                                    ?>data-toggle="tooltip" data-placement="bottom"
                                                    <?php } ?>title="
                                                    <?php echo $button_wishlist; ?>" onclick="wishlist.add('
                                                    <?php echo $product['product_id']; ?>');"><i class="fa fa-fw fa-heart"></i>
                                                    <?php if ($moneymaker2_common_wishlist_caption) { ?>
                                                    <?php echo $button_wishlist; ?>
                                                    <?php } ?>
                                                </button>
                                                <?php } ?>
                                                <?php if (!$moneymaker2_common_compare_hide) { ?><button type="button"
                                                    class="btn btn-default" <?php if (!$moneymaker2_common_compare_caption) {
                                                    ?>data-toggle="tooltip" data-placement="bottom"
                                                    <?php } ?>title="
                                                    <?php echo $button_compare; ?>" onclick="compare.add('
                                                    <?php echo $product['product_id']; ?>');"><i class="fa fa-fw fa-area-chart"></i>
                                                    <?php if ($moneymaker2_common_compare_caption) { ?>
                                                    <?php echo $button_compare; ?>
                                                    <?php } ?>
                                                </button>
                                                <?php } ?>
                                            </div>
                                            <?php if (!$moneymaker2_common_price_detached&&$product['price']&&$product['tax']) { ?>
                                            <div class="price-tax"><small class="text-muted">
                                                    <?php echo $text_tax; ?>
                                                    <?php echo $product['tax']; ?>
                                                </small></div>
                                            <?php } ?>
                                            <div class="additional">
                                                <?php echo $product['stock']; ?>
                                                <?php echo $product['code']; ?>
                                            </div>
                                            <div class="description">
                                                <?php echo $product['description']; ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if ($moneymaker2_product_related_carousel) { ?>
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                    <hr>
                <?php } ?>
                <?php echo $content_bottom; ?>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</section>

<script><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
$.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
    dataType: 'json',
    beforeSend: function() {
        $('#recurring-description').html('');
    },
    success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['success']) {
            $('#recurring-description').html(json['success']);
        }
    }
});
});
//--></script>
<script><!--
$('#button-cart').on('click', function() {
<?php if (!$product_sold) { ?>
$.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('#product input[type=\'number\'], #product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
    dataType: 'json',
    beforeSend: function() {
  $('#button-cart .fa').removeClass('shopping-cart');
  $('#button-cart .fa').addClass('fa-spinner fa-spin');
    },
    complete: function() {
  $('#button-cart .fa').removeClass('fa-spinner fa-spin');
  $('#button-cart .fa').addClass('shopping-cart');

    },
    success: function(json) {
        $('.alert, .text-danger').remove();
        $('.form-group').removeClass('has-error');

        if (json['error']) {
            if (json['error']['option']) {
      $('.options .collapse').show();
      <?php if ($moneymaker2_product_options_hide&&$moneymaker2_product_options_hide_limit&&(count($options)>=$moneymaker2_product_options_hide_limit)) { ?>
        $('.options > div:first-child').hide();
      <?php } ?>
      for (i in json['error']['option']) {
                    var element = $('#input-option' + i.replace('_', '-'));

                    if (element.parent().hasClass('input-group')) {
                        element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                    } else {
                        element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                    }
                }
            }

            if (json['error']['recurring']) {
                $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
            }

            // Highlight any found errors
            $('.text-danger').parent().addClass('has-error');
        }

        if (json['success']) {
    var moneymaker2_total_count = json['moneymaker2_total_count'];
    var moneymaker2_total_sum = json['moneymaker2_total_sum'];
    $('#cart > .dropdown-toggle #cart-total').html(moneymaker2_total_sum);
    $('#cart > .dropdown-toggle .fa-stack .fa-stack-1x, .navbar-cart-toggle .fa-stack .fa-stack-1x').html(moneymaker2_total_count);
    $('#cart > ul').load('index.php?route=common/cart/info ul li');
    $('#popupModal').find('.modal-body').load('index.php?route=common/cart/info ul', function() {
      $('#popupModal .modal-header .close').addClass('hidden');
      $('#popupModal .modal-body > ul').removeClass('dropdown-menu keep-open');
      $('#popupModal .modal-body > ul').addClass('list-unstyled');
      $('#popupModal .modal-body .btn-primary').parent().parent().prepend('<div class="panel panel-info"><div class="panel-heading text-center"><small>' + json['success'] + '</small></div></div>');
      $('#popupModal').find('.modal-title').load('index.php?route=common/cart/info #cart-total', function () {
        $('#popupModal .modal-title').text(json['total']);
        $('#popupModal').modal();
      });
    });
        }
    },
    error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
});
<?php } ?>
});

//--></script>
<script><!--
/*$('.date').datetimepicker({
pickTime: false
});

$('.datetime').datetimepicker({
pickDate: true,
pickTime: true
});

$('.time').datetimepicker({
pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
var node = this;

$('#form-upload').remove();

$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

$('#form-upload input[name=\'file\']').trigger('click');

if (typeof timer != 'undefined') {
    clearInterval(timer);
}

timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);

        $.ajax({
            url: 'index.php?route=tool/upload',
            type: 'post',
            dataType: 'json',
            data: new FormData($('#form-upload')[0]),
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function() {
                $(node).button('loading');
            },
            complete: function() {
                $(node).button('reset');
            },
            success: function(json) {
                $('.text-danger').remove();

                if (json['error']) {
                    $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                }

                if (json['success']) {
                    alert(json['success']);

                    $(node).parent().find('input').val(json['code']);
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}, 500);
});*/
//--></script>
<script><!--
$('#review').delegate('.pagination a', 'click', function(e) {
e.preventDefault();

$('#review').fadeOut('slow');

$('#review').load(this.href);

$('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
$.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: $("#form-review").serialize(),
    beforeSend: function() {
        $('#button-review').button('loading');
    },
    complete: function() {
        $('#button-review').button('reset');
    },
    success: function(json) {
        $('#form-review .alert-success').parent().parent().remove();
        $('#form-review .alert-danger').parent().parent().remove();
        $('#form-review .alert-success, #form-review .alert-danger').remove();

        if (json['error']) {
    if (typeof grecaptcha != "undefined") {grecaptcha.reset();} //refresh recaptcha if enabled
    $('#button-review').parent().parent().before('<div class="form-group"><div class="col-sm-offset-2 col-lg-8 col-md-9 col-sm-10"><div class="alert alert-danger">' + json['error'] + '</div></div></div>');
        }

        if (json['success']) {
    $('#button-review').parent().parent().before('<div class="form-group"><div class="col-sm-offset-2 col-lg-8 col-md-9 col-sm-10"><div class="alert alert-success">' + json['success'] + '</div></div></div>');

            $('input[name=\'name\']').val('');
            $('textarea[name=\'text\']').val('');
            $('input[name=\'rating\']:checked').prop('checked', false);
        }
    }
});
});

$(document).ready(function() {
    <?php if ($moneymaker2_product_gallery_moved) { ?>
    // to center imgs remove 2* from owl.carousel.min.js
    // and add .owl-carousel .owl-wrapper, .owl-carousel .owl-item { margin: 0 auto; }
    //$('.thumbnails.image-additional').detach().insertAfter( $('.thumbnails.image-thumb') );
    <?php } ?>

    $('.thumbnails .owl-carousel').owlCarousel({
         animateOut: 'slideOutUp',
  animateIn: 'slideInUp',
        itemsCustom : [
            [0, 1], 
            [320, <?php echo $moneymaker2_product_thumbs_limit['xxxsm'] ? $moneymaker2_product_thumbs_limit['xxxsm'] : 3; ?>], 
            [450, <?php echo $moneymaker2_product_thumbs_limit['xxsm'] ? $moneymaker2_product_thumbs_limit['xxsm'] : 5; ?>], 
            [560, <?php echo $moneymaker2_product_thumbs_limit['xsm'] ? $moneymaker2_product_thumbs_limit['xsm'] : 6; ?>], 
            [768, <?php echo $moneymaker2_product_thumbs_limit['sm'] ? $moneymaker2_product_thumbs_limit['sm'] : 6; ?>], 
            [992, <?php echo $moneymaker2_product_thumbs_limit['md'] ? $moneymaker2_product_thumbs_limit['md'] : 4; ?>], 
            [1200, <?php echo $moneymaker2_product_thumbs_limit['lg'] ? $moneymaker2_product_thumbs_limit['lg'] : 5; ?>], 
            [1583, <?php echo $moneymaker2_product_thumbs_limit['xlg'] ? $moneymaker2_product_thumbs_limit['xlg'] : 5; ?>]
            ],
    });

    $('.thumbnails').magnificPopup({
        type:'image',
        delegate: 'a',
        midClick:true,
        fixedContentPos: true,
        overflowY: 'scroll',
        gallery: {
            enabled:true,
            tCounter: '%curr% / %total%'
        },
        mainClass: '<?php if ($moneymaker2_product_gallery_round) { ?>mfp-round<?php } else { ?>mfp-square<?php } ?> <?php if ($moneymaker2_product_gallery_animation) { ?>mfp-effect mfp-<?php echo ($moneymaker2_product_gallery_animation_in); ?><?php } ?>',
        <?php if ($moneymaker2_product_gallery_animation) { ?>removalDelay: 300,<?php } ?>
        callbacks: {
            open: function() {
                $.magnificPopup.instance.next = function() {
                  var self = this;
                  self.wrap.removeClass('mfp-image-loaded');
                  setTimeout(function() { $.magnificPopup.proto.next.call(self); }, 100);
                }
                $.magnificPopup.instance.prev = function() {
                  var self = this;
                  self.wrap.removeClass('mfp-image-loaded');
                  setTimeout(function() { $.magnificPopup.proto.prev.call(self); }, 100);
                }
        
                $(".mfp-figure figure").prepend("<div id='image-addon' class='hidden-xs'><?php if ($moneymaker2_common_price_detached) { ?><?php if ($price) { ?><div class='price-detached'><span class='price'><?php if (!$special) { ?><?php echo $moneymaker2_product_price; ?><?php } else { ?><span class='price-new'><b><?php echo $moneymaker2_product_special; ?></b></span> <span class='price-old'><?php echo $moneymaker2_product_price; ?></span><?php } ?></span></div><?php } ?><?php } ?><div class='btn-group additional-buttons'><?php if (!$moneymaker2_common_buy_hide) { ?><button class='<?php echo $addtocart_class; ?>' type='button' data-toggle='tooltip' data-html='true' data-placement='bottom' title='<?php echo str_replace("'",'\"',$addtocart_tooltip); ?>' <?php if (!$product_sold) { ?>onclick='$(\".mfp-figure .btn-primary\").tooltip(\"hide\"); $(\"#image-addon\").remove();$(\"#button-cart\").click();'<?php } ?>><i class='fa fa-shopping-cart'></i> <?php if (!$moneymaker2_common_price_detached) { ?><?php if ($price&&$special) { ?><?php echo $moneymaker2_product_special; ?><?php } else if ($price) { ?><?php echo $moneymaker2_product_price; ?><?php } ?><?php } else { ?><?php echo $button_cart; ?><?php } ?></button><?php } ?><?php if (!$moneymaker2_common_wishlist_hide) { ?><button type='button' class='btn btn-default' <?php if (!$moneymaker2_common_wishlist_caption) { ?>data-toggle='tooltip' data-placement='bottom' <?php } ?>title='<?php echo $button_wishlist; ?>' onclick='wishlist.add(<?php echo $product_id; ?>);'><i class='fa fa-heart'></i><?php if ($moneymaker2_common_wishlist_caption) { ?> <?php echo $button_wishlist; ?><?php } ?></button><?php } ?><?php if (!$moneymaker2_common_compare_hide) { ?><button type='button' class='btn btn-default' <?php if (!$moneymaker2_common_compare_caption) { ?>data-toggle='tooltip' data-placement='bottom' <?php } ?>title='<?php echo $button_compare; ?>' onclick='compare.add(<?php echo $product_id; ?>);'><i class='fa fa-area-chart'></i><?php if ($moneymaker2_common_compare_caption) { ?> <?php echo $button_compare; ?><?php } ?></button><?php } ?></div><?php if ($moneymaker2_modules_quickorder_enabled&&$moneymaker2_modules_quickorder_display_thumb) { ?><span class='<?php echo $quickorder_class; ?>' <?php if (!$product_sold) { ?>data-toggle='modal' data-target='#orderModal' data-order-mode='product' data-order-product-id='<?php echo $product_id; ?>' data-order-title='<?php echo $heading_title; ?>' data-order-img-src='<?php echo $quickorder_thumb; ?>' data-order-price='<?php if ($price&&$special) { ?><?php echo strip_tags($special); ?><?php } else if ($price) { ?><?php echo strip_tags($price); ?><?php } ?>'<?php } ?>><span data-toggle='tooltip' data-html='true' data-placement='bottom' title='<?php echo str_replace("'",'\"',$quickorder_tooltip); ?>'><i class='fa fa-fw fa-send'></i> <?php echo $moneymaker2_modules_quickorder_button_title; ?></span></span><?php } ?></div>");
                $('.mfp-figure [data-toggle="tooltip"]').tooltip({trigger: 'hover', container: 'body'});
                $('.navbar-fixed-top').css('overflow-y', 'scroll');
            },
            imageLoadComplete: function() {
                var self = this;
                setTimeout(function() { self.wrap.addClass('mfp-image-loaded'); }, 15);
            },
            beforeClose: function() {
                $(".mfp-arrow-right").remove();
                $(".mfp-arrow-left").remove();
                $('.mfp-figure [data-toggle="tooltip"]').tooltip('hide');
                $('body > .tooltip').remove();
            },
            afterClose: function() {
                $("#image-addon").remove();
            },
            close: function() {
                $('.navbar-fixed-top').css('overflow-y', '');
            },
        },
        closeOnContentClick: true,
    });


    <?php if ($moneymaker2_modules_timer&&$moneymaker2_modules_timer_date) { ?>
        function getDaysText(number, titles) {
            cases = [2, 0, 1, 1, 1, 2];
            return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
        }
        var countDownDate = new Date("<?php echo $moneymaker2_modules_timer_date; ?>").getTime();
        var delimiter = "<span class='blink'>:</span>";
        function setTimer() {
            var now = new Date().getTime();
            var distance = countDownDate - now;
            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            var daysText=getDaysText(days,['<?php echo $text_timer_days_numeral1; ?>','<?php echo $text_timer_days_numeral2; ?>','<?php echo $text_timer_days_numeral3; ?>']);
            var remainingText=getDaysText(days,['<?php echo $text_timer_ends_numeral1; ?>','<?php echo $text_timer_ends_numeral2; ?>','<?php echo $text_timer_ends_numeral3; ?>']);
            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            if (hours<10) hours='0'+hours;
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            if (minutes<10) minutes='0'+minutes;
            var seconds = Math.floor((distance % (1000 * 60)) / 1000);
            if (seconds<10) seconds='0'+seconds;
            if ($('#timer-countdown').css("opacity") == 0 ) {
              $('#timer-countdown').velocity("fadeIn", {duration: 500});
            }
            if (days < 1) {
              document.getElementById("timer-countdown").innerHTML = remainingText + hours + delimiter + minutes + delimiter + seconds;
            } else {
              document.getElementById("timer-countdown").innerHTML = remainingText + days + "&nbsp;" + daysText + "&nbsp;" + hours + delimiter + minutes + delimiter + seconds;
            }
            if (distance < 0) {
              clearInterval(moneymaker2_timer);
              document.getElementsByClassName("product-timer")[0].outerHTML = "";
            }
        }
        var moneymaker2_timer = setInterval(function() {setTimer()}, 1000);
    <?php } ?>

    <?php if ($products&&$moneymaker2_product_related_carousel) { ?>
        $('.col-sm-6 > div > .owl-moneymaker2-products-related').owlCarousel({
            itemsCustom : [[0, 1], [561, 2], [768, 1], [992, 2], [1200, 2], [1583, 3]],
            navigation: true,
            navigationText: ['', ''],
            pagination: true,
            <?php if ($moneymaker2_product_related_carousel_autoplay) { ?>
                autoPlay: true,
                stopOnHover: true,
                autoPlay: 3500,
            <?php } ?>
        });
        $('.col-sm-9 > div > .owl-moneymaker2-products-related').owlCarousel({
            itemsCustom : [[0, 1], [561, 2], [992, 3], [1200, 3], [1583, 4]],
            navigation: true,
            navigationText: ['', ''],
            pagination: true,
            <?php if ($moneymaker2_product_related_carousel_autoplay) { ?>
                autoPlay: true,
                stopOnHover: true,
                autoPlay: 3500,
            <?php } ?>
        });
        $('.col-sm-12 > div > .owl-moneymaker2-products-related').owlCarousel({
            itemsCustom : [[0, 1], [561, 2], [768, 3], [992, 4], [1200, 4], [1583, 5]],
            navigation: true,
            navigationText: ['', ''],
            pagination: true,
            <?php if ($moneymaker2_product_related_carousel_autoplay) { ?>
                autoPlay: true,
                stopOnHover: true,
                autoPlay: 3500,
            <?php } ?>
        });
    <?php } ?>
});
//--></script>
<script>
  $('.product__gallery-top .thumbnail').magnificPopup({type:'image'});
 const inputElements = document.querySelectorAll('.product__types input[data-checked="1"]');
if (inputElements.length > 0) {
    inputElements[0].checked = true;
}
</script>
<?php echo $footer; ?>