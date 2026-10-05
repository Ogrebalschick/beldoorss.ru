<div id="carousel<?php echo $module; ?>" class="owl-carousel brands-carousel">
  <?php foreach ($banners as $banner) { ?>
  <div class="item text-center">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
    <?php } ?>
  </div>
  <?php } ?>
</div>
<script type="text/javascript"><!--
$('#carousel<?php echo $module; ?>').owlCarousel({
	items: 6,
	itemsDesktop: [1199, 5],
	itemsDesktopSmall: [991, 4],
	itemsTablet: [767, 3],
	itemsMobile: [479, 2],
	autoPlay: 3000,
	navigation: true,
	navigationText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
	pagination: false,
	stopOnHover: true
});
--></script>
