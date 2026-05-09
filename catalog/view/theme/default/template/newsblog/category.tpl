<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h2><?php echo $heading_title; ?></h2>
      <?php if ($thumb || $description) { ?>
      <div class="row">
        <?php if ($thumb) { ?>
        <div class="col-sm-2"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
        <?php } ?>
        <?php if ($description) { ?>
        <div class="col-sm-10"><?php echo $description; ?></div>
        <?php } ?>
      </div>
      <hr>
      <?php } ?>
      <?php if ($categories) { ?>
      <h3><?php echo $text_refine; ?></h3>
      <?php if (count($categories) <= 5) { ?>
      <div class="row">
        <div class="col-sm-3">
          <ul>
            <?php foreach ($categories as $category) { ?>
            <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
      </div>
      <?php } else { ?>
      <div class="row">
        <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
        <div class="col-sm-3">
          <ul>
            <?php foreach ($categories as $category) { ?>
            <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php if ($articles) { ?>
  <div class="articles-list container">
    <div class="row gy-4">
      <?php foreach ($articles as $article) { ?>
          <article class="article-card shadow-sm h-100 border rounded-3 overflow-hidden">
            
            <?php if ($article['thumb']) { ?>
              <div class="article-image position-relative">
                <a href="<?php echo $article['href']; ?>" class="d-block">
                  <img 
                    src="<?php echo $article['thumb']; ?>" 
                    alt="<?php echo $article['name']; ?>" 
                    title="<?php echo $article['name']; ?>" 
                    class="img-fluid w-100"
                  />
                </a>
              </div>
            <?php } ?>

            <div class="article-content p-3 d-flex flex-column justify-content-between h-100">
              <div>
                <h4 class="article-title mb-2">
                  <a href="<?php echo $article['href']; ?>" class="text-decoration-none text-dark fw-semibold">
                    <?php echo $article['name']; ?>
                  </a>
                </h4>

                <p class="article-preview text-muted mb-3">
                  <?php echo $article['preview']; ?>
                </p>

                <?php if ($article['attributes']) { ?>
                  <div class="article-attributes small border-top pt-2 mt-2">
                    <h6 class="fw-bold mb-1"><?php echo $text_attributes; ?></h6>
                    <?php foreach ($article['attributes'] as $attribute_group) { ?>
                      <?php foreach ($attribute_group['attribute'] as $attribute_item) { ?>
                        <div>
                          <b><?php echo $attribute_item['name']; ?>:</b>
                          <?php echo $attribute_item['text']; ?>
                        </div>
                      <?php } ?>
                    <?php } ?>
                  </div>
                <?php } ?>
              </div>
            </div>

        </div>
      <?php } ?>
    </div>

    <div class="row mt-4 align-items-center">
      <div class="col-md-6 text-start"><?php echo $pagination; ?></div>
      <div class="col-md-6 text-end text-muted small"><?php echo $results; ?></div>
    </div>
  </div>
<?php } ?>

      <?php if (!$categories && !$articles) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php if ($comments_vk) { ?>
      <div class="row">
        <div class="col-md-12">
			<div id="vk_comments"></div>
			<script type="text/javascript">
			VK.init({apiId: <?php echo $comments_vk; ?>, onlyWidgets: true});
			VK.Widgets.Comments("vk_comments", {limit: 10, attach: "*"});
			</script>
        </div>
      </div>
      <?php } ?>

      <?php if ($comments_fb) { ?>
      <div class="row">
        <div class="col-md-12">
            <div id="fb-root"></div>
			<script>(function(d, s, id) {
			  var js, fjs = d.getElementsByTagName(s)[0];
			  if (d.getElementById(id)) return;
			  js = d.createElement(s); js.id = id;
			  js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.10";
			  fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));</script>
			<div class="fb-comments" data-href="<?php echo $canonical; ?>" data-width="100%" data-numposts="10"></div>
        </div>
      </div>
      <?php } ?>

      <?php if ($comments_dq) { ?>
      <div class="row">
        <div class="col-md-12">
        	<div id="disqus_thread"></div>
			<script>
			var disqus_config = function () {
				this.page.url = "<?php echo $canonical; ?>";
			};

			(function() { // DON'T EDIT BELOW THIS LINE
			var d = document, s = d.createElement('script');
			s.src = 'https://<?php echo $comments_dq; ?>.disqus.com/embed.js';
			s.setAttribute('data-timestamp', +new Date());
			(d.head || d.body).appendChild(s);
			})();
			</script>
			<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
        </div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>