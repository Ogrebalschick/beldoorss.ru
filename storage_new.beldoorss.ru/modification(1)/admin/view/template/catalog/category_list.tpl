<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">

            <!-- DragSort -->

            <?php if ($column_drag_sort) { ?>
			<a href="index.php?route=catalog/category&token=<?php echo $token; ?>" data-toggle="tooltip" title="Выйти из режима" class="btn btn-primary"><i class="fa fa-sign-out"></i></a>
            <button type="button" class="btn btn-danger btn-make-order"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i>&nbsp;&nbsp;Упорядочить сортировку</button>
            <?php } ?>
            <?php if (!$column_drag_sort) { ?>
            <a href="<?php echo $drag_sort_mode_link; ?>" class="btn btn-primary"><i class="fa fa-sort" aria-hidden="true"></i>&nbsp;&nbsp;Режим перетаскивания</a>
            <?php } ?>
            <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>

            <!-- -------- -->

             <a href="<?php echo $repair; ?>" data-toggle="tooltip" title="<?php echo $button_rebuild; ?>" class="btn btn-default"><i class="fa fa-refresh"></i></a>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-category').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-category">
          <div class="table-responsive">
            

            <!-- DragSort -->

            <?php if ($button_back) { ?>
            <div class="" style="padding-top: 0; padding-bottom: 10px;"><a href="<?php echo $button_back; ?>" class="btn btn-default"><i class="fa fa-reply"></i>&nbsp;&nbsp;Назад</a></div>
            <?php } ?>

            <!-- <table class="table table-bordered table-hover"> -->

            <table class="table table-bordered table-hover<?php echo $column_drag_sort ? ' drag-sort-table' : ''; ?>">

            <!-- -------- -->

            
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>


            <!-- DragSort -->

            <?php if ($column_drag_sort) { ?>
            <td style="width: 1px;" class="text-center">
                <?php echo $column_drag_sort; ?>
            </td>
            <?php } ?>

            <!-- -------- -->

            
                  <td class="text-left"><?php if ($sort == 'name') { ?>
                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php if ($sort == 'sort_order') { ?>
                    <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($categories) { ?>
                <?php foreach ($categories as $category) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($category['category_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" />
                    <?php } ?></td>


            <!-- DragSort -->

            <?php if ($column_drag_sort) { ?>
            <td class="text-center">
                <span class="btn btn-primary drag-sort-handle"><i class="fa fa-sort" aria-hidden="true"></i></span>
            </td>
            <?php } ?>

            <!-- -------- -->

            
                  

            <!-- DragSort -->

            <!-- <td class="text-left"><?php echo $category['name']; ?></td> -->

            <?php if ($category['href']) { ?>
            <td class="left"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></td>
            <?php } else { ?>
            <td class="left"><?php echo $category['name']; ?></td>
            <?php } ?>

            <!-- -------- -->

            
                  

            <!-- DragSort -->

            <?php if ($column_drag_sort) { ?>
            <td class="text-right">
                <input type="text" value="<?php echo $category['sort_order']; ?>" class="form-control text-right drag-sort-order-input" data-category-id="<?php echo $category['category_id']; ?>" style="width: 100px; margin-left: auto;">

                <input type="hidden" class="drag-sort-order" value="<?php echo $category['sort_order']; ?>" name="category_sort[<?php echo $category['category_id']; ?>]">
            </td>
            <?php } else { ?>
            <td class="text-right"><?php echo $category['sort_order']; ?></td>
            <?php } ?>

            <!-- -------- -->

            
                  <td class="text-right"><a href="<?php echo $category['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>


            <!-- DragSort -->

            <?php if ($column_drag_sort) { ?>

            <script>
                $(document).ready(function() {
                    var url = 'index.php?route=catalog/drag_sort/updateSort&token=<?php echo $token; ?>';

                    initTable(url);
                    initInputSort(url);

                    $('.btn-make-order').click(function(event) {
                        event.preventDefault();

                        $.ajax({
                            url: 'index.php?route=catalog/drag_sort/makeOrder&token=<?php echo $token; ?>',
                            type: 'post',
                            data: [{name: 'order', value: 'categories'}, {name: 'category_id', value: '<?php echo $drag_sort_category; ?>'}],
                            dataType: 'json',
                            beforeSend: function() {
                            },
                            complete: function() {
                            },
                            success: function(json) {

                                $(".drag-sort-table tbody").sortable("destroy");

                                $('.drag-sort-table').load(window.location.href + ' .drag-sort-table > *', function() {
                                    initTable(url);
                                    initInputSort(url);
                                });
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });

                    });
                });
            </script>

            <script>
                function initInputSort(url) {
                    $('.drag-sort-order-input').change(function() {

                        updateSort(url, [{name: 'category_sort[' + $(this).attr('data-category-id') + ']', value: $(this).val()}], function() {
                            $(".drag-sort-table tbody").sortable("destroy");
                            $('.drag-sort-table').load(window.location.href + ' .drag-sort-table > *', function() {
                                initTable(url);
                                initInputSort(url);
                            });
                        });
                    });
                }
            </script>

            <script>
                function initTable(url) {
                    $(".drag-sort-table tbody").sortable({
                        handle: ".drag-sort-handle",
                        placeholder: "ui-state-highlight",
                        forcePlaceholderSize: true,
                        forceHelperSize: true,
                        revert: true,
                        start: function(event, ui) {
                            $('.ui-state-highlight').css('height', ui.item.height());
                        },
                        stop: function(event, ui) {
                            var order = [];

                            $(".drag-sort-table tbody").find('.drag-sort-order').each(function() {
                                order.push(parseInt($(this).val()));
                            });

                            order.sort(function(a, b) {return a - b;});
                            var i = 0;

                            $(".drag-sort-table tbody").find('.drag-sort-order').each(function() {
                                $(this).val(order[i]);
                                $(this).parent().find('.drag-sort-order-input').val(order[i++]);
                            });

                            updateSort(url, $(".drag-sort-table tbody").find(':input').serializeArray());
                        }
                    });
                }
            </script>

            <script>
                function updateSort(url, data, successCallback) {
                    $.ajax({
                        url: url,
                        type: 'post',
                        data: data,
                        dataType: 'json',
                        beforeSend: function() {
                        },
                        complete: function() {
                        },
                        success: function(json) {
                            if(successCallback) successCallback();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
            </script>

            <?php } ?>

            <!-- -------- -->

            
<?php echo $footer; ?>