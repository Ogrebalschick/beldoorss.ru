<?php if($heading_title) { ?>
<p class="h2"><?php echo $heading_title; ?></p>
<?php } ?>
<div class="moneymaker_activity moneymaker_activity<?php echo $module; ?>">
    <div></div>
    <ul class="list-unstyled">
        <?php if ($activities) { ?>
        <?php foreach ($activities as $activity) { ?>
        <li>
            <span><?php echo $activity['comment']; ?></span>
            <small class="text-muted"><?php echo $activity['date_added']; ?></small>
        </li>
        <?php } ?>
        <?php } else { ?>
        <li><?php echo $text_no_activity; ?></li>
        <?php } ?>
    </ul>
</div>
<?php if ($activities) { ?>
<script>
    function scrollActivity<?php echo $module; ?>(){
        $('.moneymaker_activity<?php echo $module; ?> > ul > li:first').fadeTo(300, 0).slideUp(500);
        setTimeout(function(){
            $('.moneymaker_activity<?php echo $module; ?> > ul > li:first').appendTo($('.moneymaker_activity<?php echo $module; ?> > ul')).fadeTo(0, 1);
            $('.moneymaker_activity<?php echo $module; ?> > ul > li:not(:first-child)').removeAttr('style');
        }, 1000);
    }
    setInterval(function(){scrollActivity<?php echo $module; ?>()}, <?php echo $speed; ?>*1000);
</script>
<?php } ?>