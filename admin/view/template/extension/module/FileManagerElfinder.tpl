<div id="filemanager" class="modal-dialog modal-lg">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"><?php echo $heading_title; ?></h4>
    </div>
    <div class="modal-body">
      <div class="elfinder">
        <div id="elfinder" data-connector="<?php echo $url_connector; ?>" data-base-url="<?php echo $base_url; ?>"></div>
      </div>
    </div>
  </div>
</div>
<link href="view/javascript/jquery/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<link href="view/javascript/FileManagerElfinder/css/elfinder.min.css" rel="stylesheet">
<link href="view/javascript/FileManagerElfinder/css/theme.css" rel="stylesheet">

<script src="view/javascript/bootstrap/js/bootstrap.min.js"></script>
<script src="view/javascript/jquery/jquery-ui/jquery-ui.min.js"></script>
<script src="view/javascript/FileManagerElfinder/js/elfinder.min.js"></script>
<script src="view/javascript/FileManagerElfinder/js/extras/editors.default.min.js"></script>

<script>
  $(document).ready(function() {
    var fileManager = $('#elfinder');
    var connectorUrl = fileManager.data('connector');
    var baseUrlAssets = fileManager.data('base-url');
    var fileManagerLanguage = $('html').attr('lang');
    $(document).ready(function() {
      fileManager.elfinder({
        cssAutoLoad: false,
        baseUrl: baseUrlAssets,
        url: connectorUrl,
        lang: fileManagerLanguage,
        rememberLastDir: true,
        useBrowserHistory: false,
        resizable: false,
        height: 600,
        commandsOptions: {
          getfile: {
           <?php if ($multiple) { ?>
           multiple: true,
           <?php } else { ?>
           multiple: false,
           <?php } ?>
           onlyURL: false
         },
        },
        closeOnEditorCallback: true,
        getFileCallback:
        <?php if ($multiple) { ?>
            function(files, fm) {
                var ff = 0;
                $.each(files, function(item, file) {
                  if ((file.read && file.hash)) {
                    if (ff == 0) {
                      var path = file.path;
                      path = path.replace(/\\\\/g,'/');
                      path = path.replace(/\\/g,'/');
                      $('#<?php echo $target; ?>').val(path);
                      var img_tmb  = '<img src="' + file.tmb + '">';
                      $('#<?php echo $thumb; ?>').html(img_tmb);
                      ff++;
                    } else {
                      var path = file.path;
                      path = path.replace(/\\\\/g,'/');
                      path = path.replace(/\\/g,'/');
                      add_multiple(path, file.tmb);
                    }
                  }
                })
                $('#modal-image').modal('hide');
                fm.hide();
            }
          <?php } else { ?>
            function(file, fm) {
              <?php if ($target) { ?>
                var path = file.path;
                path = path.replace(/\\\\/g,'/');
                path = path.replace(/\\/g,'/');
                $('#<?php echo $target; ?>').val(path);
              <?php } ?>
              <?php if ($thumb) { ?>
                var img_tmb  = '<img src="' + file.tmb + '">';
                $('#<?php echo $thumb; ?>').html(img_tmb);
              <?php } ?>
              <?php if ($summernote) { ?>
                if (file.mime == 'video/mp4') {
                    $('#<?php echo $summernote; ?>').summernote('pasteHTML','<div class="summernote-html5-video"><video controls="" name="media" style="height:auto; max-width:100%"><source src="' + file.url + '" type="video/mp4"></video></div>');   
                } else {
                    $('#<?php echo $summernote; ?>').summernote('insertImage', file.url);
                }
              <?php } ?>
              <?php if ($ckeditor) { ?>
                var cke_target = '<?php echo $ckeditor; ?>}' || null;
                cke_target = cke_target.split( ':' ); 
                CKEDITOR.dialog.getCurrent().setValueOf(cke_target[0], cke_target[1], file.url);
              <?php } ?>
              $('#modal-image').modal('hide');
              fm.hide();
            }
          <?php } ?>
      });
    });
  });
</script>
<style>
  #modal-image.modal.ckeditor.in {
    z-index: 10010;
  }
  @media (min-width: 1200px) {
    #filemanager.modal-lg {
        width: 1200px;
    }
  }
</style>