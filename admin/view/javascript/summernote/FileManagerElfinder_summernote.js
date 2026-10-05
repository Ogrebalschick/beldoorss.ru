$(document).ready(function() {
  // Override summernotes image manager
  $('.summernote').each(function() {
    var element = this;
    var lang = $(element).data('lang');
    
    if (typeof(lang) == 'undefined') {
      lang = 'en-US';
    }
    
    $(element).summernote({
      disableDragAndDrop: true,
      height: 300,
      lang: lang,
      emptyPara: '',
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'underline', 'clear']],
        ['fontname', ['fontname']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['table', ['table']],
        ['insert', ['link', 'image', 'video']],
        ['view', ['fullscreen', 'codeview', 'help']]
      ],
      buttons: {
          image: function() {
          var ui = $.summernote.ui;

          // create button
          var button = ui.button({
            contents: '<i class="note-icon-picture" />',
            tooltip: $.summernote.lang[$.summernote.options.lang].image.image,
            click: function () {
              $('#modal-image').remove();
            
              $.ajax({
                url: 'index.php?route=extension/module/FileManagerElfinder/manager&token=' + getURLVar('token') + '&summernote=' + $(element).attr('id'),
                dataType: 'html',
                beforeSend: function() {
                  $('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
                  $('#button-image').prop('disabled', true);
                },
                complete: function() {
                  $('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
                  $('#button-image').prop('disabled', false);
                },
                success: function(html) {
                  beldoorssOpenElfinderFromHtml(html);
                }
              });           
            }
          });
        
          return button.render();
        }
        }
    });
  });
  
});