
<?php if ($implus_status) {?>
<script type="text/javascript" charset="utf-8">
<?php if ($implus_image_folder) {?>
function dirname(a){return a.replace(/\\/g,"/").replace(/\/[^\/]*\/?$/,"")}function base64_encode(a){var c,d,e,f,g,h,i,j,b="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",k=0,l=0,m="",n=[];if(!a)return a;do c=a.charCodeAt(k++),d=a.charCodeAt(k++),e=a.charCodeAt(k++),j=c<<16|d<<8|e,f=j>>18&63,g=j>>12&63,h=j>>6&63,i=63&j,n[l++]=b.charAt(f)+b.charAt(g)+b.charAt(h)+b.charAt(i);while(k<a.length);m=n.join("");var o=a.length%3;return(o?m.slice(0,o-3):m)+"===".slice(o||3)}function strtr(a,b,c){var d="",e=0,f=0,g=0,h=0,i=!1,j="",k="",l="",m=[],n=[],o="",p=!1;if("object"==typeof b){i=this.ini_set("phpjs.strictForIn",!1),b=this.krsort(b),this.ini_set("phpjs.strictForIn",i);for(d in b)b.hasOwnProperty(d)&&(m.push(d),n.push(b[d]));b=m,c=n}for(g=a.length,h=b.length,j="string"==typeof b,k="string"==typeof c,e=0;e<g;e++){if(p=!1,j){for(l=a.charAt(e),f=0;f<h;f++)if(l==b.charAt(f)){p=!0;break}}else for(f=0;f<h;f++)if(a.substr(e,b[f].length)==b[f]){p=!0,e=e+b[f].length-1;break}o+=p?k?c.charAt(f):c[f]:a.charAt(e)}return o}function rtrim(a,b){b=b?(b+"").replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g,"\\$1"):" \\s ";var c=new RegExp("["+b+"]+$","g");return(a+"").replace(c,"")}function generate_hash(a){return str=get_folder(),ghash=dirname(a),ghash=ghash.replace(str,""),ghash=strtr(base64_encode(ghash),"+/=","-_."),ghash=rtrim(ghash,"."),ghash="elf_l1_"+ghash,ghash}function get_folder() {<?php if ($im_root_folder == "") { ?>str = "image/catalog/";<?php  }else if ($im_root_folder == "catalog/") { ?>str = "catalog/";<?php } else { ?>str = "image/' . $im_root_folder . '";<?php } ?>return str;}
<?php } ?>

  $(document).ready(function() {
  <?php /*
    $disabled_routes = array('extension/installer', 'catalog/download/add', 'marketing/contact', 'catalog/product_ext', 'sale/order', 'sale/order/edit', 'sale/order/info', 'sale/order/add', 'extension/modification_editor','module/admin_quick_edit', 'sale/customer/edit', 'extension/modification/edit', 'sale/return', 'sale/return/edit', 'sale/return/add');

    // advanced admin edit
    array_push($disabled_routes, 'catalog/product', 'catalog/category', 'customer/customer');


    if (isset($_GET['route'])) {
        if (in_array($_GET['route'],$disabled_routes)) {} else { ?>
          if($.fn.button.noConflict) {
             $.fn.btn = $.fn.button.noConflict();
          }
     <?php  }
    }else{ ?>
        if($.fn.button.noConflict) {
               $.fn.btn = $.fn.button.noConflict();
            }
    <?php } */ ?> 

    var implus_language = '<?php echo $image_manager_language;?>';
    var implus_width = <?php echo $con_implus_width;?>;
    var implus_height = <?php echo $con_implus_height;?>;
    var implus_drag_upload_allow = <?php echo $con_implus_drag_upload_allow;?>;
    var implus_lazy_load = <?php echo $con_implus_lazy_load;?>;
    var implus_load_treshold = <?php echo $con_implus_lazy_load_treshold;?>;
    var implus_images = <?php if ($con_implus_only_images) {?>["image"]<?php } else { ?>[]<?php } ?>;
    $(document).undelegate('a[data-toggle=\'image\']', 'click');
    $(document).delegate('a[data-toggle=\'image\']', 'click', function(e) {
        e.preventDefault();
        $('a[data-toggle=\'image\']').click(function(){
            $('.popover').popover('hide');
        });
        var imagebox = this;
        $(imagebox).popover({
            html: true,
            placement: 'right',
            trigger: 'manual',
            content: function() {
                return '<button type="button" id="button-image" class="btn btn-primary"><i class="fa fa-pencil"></i></button> <button type="button" id="button-clear" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>';
            }
        });
        $(imagebox).popover('toggle');       
        $('#button-image').on('click', function() {
              if($.fn.button.noConflict) { $.fn.btn = $.fn.button.noConflict(); }
              <?php if ($implus_image_folder) {?>
              //window.location.hash = $('input#elfinder-imaage-path').val();
              var target_hash = $(imagebox).parent().find('input').val();
              window.location.hash = generate_hash(target_hash);
              <?php } ?>
              elFinder.prototype._options.commands.push("upmulti");
              elFinder.prototype.i18.en.messages['cmdupmulti'] = 'Upload Multiple Images (Only available on product form)';   
              var target = $(imagebox).parent().find('input').attr('id');
              var thumb = $(imagebox).attr('id');
                var elframe = $('<div/>').dialogelfinder({
                url : 'index.php?route=common/filemanager/connector&token=' + getURLVar('token'),
                lang : implus_language,
                width : implus_width,
                height: implus_height, 
                defaultView: 'icons',      
                dragUploadAllow: implus_drag_upload_allow,
                showFiles: implus_lazy_load,
                showThreshold: implus_load_treshold,
                destroyOnClose : true,   
                onlyMimes: implus_images,  
                uiOptions : {toolbar : [['home', 'back', 'forward','up'],['reload'],['mkdir', 'upload'],['open', 'download', 'getfile','upmulti'],['quicklook'],['copy', 'cut', 'paste'],['rm'],['duplicate', 'rename', 'edit', 'resize'],['extract', 'archive', 'sort'],['search'],['view'],['info'],['help']]},
                  getFileCallback : function(files, fm) {               
                  console.log(files);
                  console.log(fm);

                    var img_file = files;
                    <?php if ($implus_user_catalog) { ?> 
                        // search path fix
                        if ((img_file.path  == "<?php echo $current_user_name ?>\\") || (img_file.path  == "<?php echo $current_user_name ?>/")) {
                        var string = img_file.url;
                        var ress = string.split("<?php echo $current_user_name ?>/");
                        var filepath = "<?php echo $current_user_name ?>/" + ress[1];
                        } else {
                           var filepath = img_file.path;
                        };
                    <?php } else { ?>
                        if ((img_file.path  == "catalog\\") || (img_file.path  == "catalog/")) {
                        var string = img_file.url;
                        var ress = string.split("catalog/");
                        var filepath = "catalog/" + ress[1];
                        } else {
                           var filepath = img_file.path;
                           <?php if ($default_root == "") { ?>
                             var filepath = filepath.replace("image\\", ""); 
                           <?php }; ?>
                        };
                    <?php } ?>

                   // var filethum = img_file.tmb; filethum = filethum.replace(/\\/g, "/");
                    var filethum = img_file.tmb; if (filethum != 1) { filethum = filethum.replace(/\\/g, "/"); };

                    filepath = filepath.replace(/\\/g, "/");

                    <?php if ($implus_user_catalog) { ?>
                    filepath = "catalog/" + filepath;
                    <?php } ?>

                    // if catalog is missing add it
                    if (filepath.indexOf('catalog/') == -1) {
                      //filepath = "catalog/" + filepath;
                    }

                    <?php if ($ftp_save_status) { ?>
                      // FTP HACK
                      if (img_file.url.indexOf("<?php echo HTTPS_CATALOG; ?>") === -1) {
                          <?php if ($tp_save_path) { ?>
                            filepath = img_file.url;
                            save_image(filepath);
                            filepath = "catalog/ftp-img/" + img_file.name;
                          <?php } ?>
                      };
                    <?php } ?>

                    // multy fix
                    if ('<?php echo $im_root_folder; ?>' == '') {
                       filepath = filepath.replace("image/", ""); 
                    }
                    //

                    $('#'+thumb).find('img').attr('src', filethum);
                    $('#'+target).val(filepath);
                    $('#radio_'+parseInt(target.replace ( /[^\d.]/g, '' ))).removeAttr('disabled');  
                    $('#radio_'+parseInt(target.replace ( /[^\d.]/g, '' ))).val(filepath);
                    $(imagebox).popover('hide'); 
                  },
                        

                        commandsOptions : {
                            getfile : {
                                oncomplete : 'close',
                                folders : false
                            }
                        }
                    }).dialogelfinder('instance');   
                    return;   
        }); 
        $('#button-clear').on('click', function() {
            $(imagebox).find('img').attr('src', $(imagebox).find('img').attr('data-placeholder'));
            $(imagebox).parent().find('input').attr('value', '');
            $(imagebox).popover('hide');
        });
});


<?php $disable_at_journal = false;
if (isset($_GET['route'])) {
    if ($_GET['route'] == "module/journal2") {
        $disable_at_journal = true;
    } 
} ?>

<?php if (!$con_implus_ckeditor OR $disable_at_journal == true) { ?>
  
  var image_to_edit = "none";
  $('.note-editable').attr('id', 'note-editable');

  var what_was_clicked = document.getElementById("note-editable");
  if (what_was_clicked != null) {
    function whatClicked(evt) {
        image_to_edit = evt.target.id;
        if (image_to_edit == "") {
          image_to_edit = "none";
        };  
    }
    <?php if (!$con_implus_journal) { ?>
       what_was_clicked.addEventListener("click", whatClicked, false);
    <?php } ?>
  };

$('.note-insert button:nth-child(2)').attr('data-toggle', 'image');
$(document).undelegate('button[data-toggle=\'image\']', 'click');
  $(document).delegate('button[data-toggle=\'image\']', 'click', function() {
  if($.fn.button.noConflict) { $.fn.btn = $.fn.button.noConflict(); }
  var range, sel = window.getSelection();

        var elframe = $('<div/>').dialogelfinder({
        url : 'index.php?route=common/filemanager/connector&token=' + getURLVar('token'),
               lang : implus_language,
                width : implus_width,
                height: implus_height, 
                defaultView: 'icons',      
                dragUploadAllow: implus_drag_upload_allow,
                showFiles: implus_lazy_load,
                showThreshold: implus_load_treshold,
                destroyOnClose : true,   
                onlyMimes: implus_images,
              uiOptions : {toolbar : [['home', 'back', 'forward','up'],['reload'],['mkdir', 'upload'],['open', 'download', 'getfile'],['info'],['quicklook'],['copy', 'cut', 'paste'],['rm'],['duplicate', 'rename', 'edit', 'resize'],['extract', 'archive', 'sort'],['view'],['help']]},        
             contextmenu: {navbar: ["open", "|", "copy", "cut", "paste", "duplicate", "|", "rm", "|", "info"],cwd: ["reload", "back", "|", "upload", "mkdir", "mkfile", "paste", "|", "sort", "|", "info"],files: ["getfile", "|", "open", "quicklook", "|", "download", "|", "copy", "cut", "paste", "duplicate", "|", "rm", "|", "edit", "rename", "resize", "|", "archive", "extract", "|", "info"]},

                        getFileCallback : function(files, elframe) {
                          //console.log(files);
                             //var range, sel = window.getSelection(); 
                               if (sel.rangeCount) { 

                                //label images
                                var highest = 0;
                                $('img[id^="el-image"]').each(function() {    
                                      var id = this.id.match(/\d+/); 
                                        if(id > highest) {
                                            highest = id;
                                        }
                                        highest += 1;
                                });

                                var img = document.createElement('img');
                                img.setAttribute("id", "el-image-" + highest);
                                img.src = files.url; 

                                if (image_to_edit != "none" && image_to_edit != "note-editable") {
                                  $("#" + image_to_edit).attr('src', files.url);
                                  console.log("this");
                                } else if (image_to_edit != "none" && image_to_edit == "note-editable") { 

                                  // Get the current selection
                                  var range = window.getSelection().getRangeAt(0);
                                  var node = range.startContainer;
                                  var startOffset = range.startOffset;  // where the range starts
                                  var endOffset = range.endOffset;      // where the range ends

                                  var range = document.createRange();
                                  range.setStart(node, startOffset);
                                  range.setEnd(node, endOffset);

                                  img.src = files.url;
                                  range.insertNode(img);

                                } else {
                                  range = sel.getRangeAt(0); 
                                  range.insertNode(img); 
                                  highest = highest + 1;
                                };
                              }
                       },
                        commandsOptions : {
                            getfile : {
                                oncomplete : 'close',
                                folders : false
                            }
                        },
                        handlers : {
                            load : function(event, elfinder) {
                                 $('#modal-image').remove();
                                 $('.modal-backdrop').remove();
                            }
                        }
                    }).dialogelfinder('instance');   
                    return;   
    });  
});
//--></script>
<?php } else { // load elfinder for ckeditor manager ?> 
});

//--></script>

          <style type="text/css">
                .dialogelfinder { z-index: 99999 !important ;}
                </style>
                <script type="text/javascript"><!--
                  var implus_language = '<?php echo $image_manager_language;?>';
                  var implus_width = <?php echo $con_implus_width;?>;
                  var implus_height = <?php echo $con_implus_height;?>;
                  var implus_drag_upload_allow = <?php echo $con_implus_drag_upload_allow;?>;
                  var implus_lazy_load = <?php echo $con_implus_lazy_load;?>;
                  var implus_load_treshold = <?php echo $con_implus_lazy_load_treshold;?>;
                  var implus_images = <?php if ($con_implus_only_images) {?>["image"]<?php } else { ?>[]<?php } ?>;

        CKEDITOR.on('dialogDefinition', function(event) {
        if($.fn.button.noConflict) { $.fn.btn = $.fn.button.noConflict(); }
        var editor = event.editor;
        var dialogDefinition = event.data.definition;
        //console.log(event.editor);
        var dialogName = event.data.name;

        var tabCount = dialogDefinition.contents.length;
        for (var i = 0; i < tabCount; i++) {
            var browseButton = dialogDefinition.contents[i].get('browse');
            if (browseButton !== null) {
                browseButton.hidden = false;
                browseButton.onClick = function(dialog, i) {
                    editor._.filebrowserSe = this;
                            jQuery('<div/>').dialogelfinder({
                                url: 'index.php?route=common/filemanager/connector&token=' + getURLVar('token'),
                                width : implus_width,
                                height: implus_height, 
                                defaultView: 'icons',      
                                dragUploadAllow: implus_drag_upload_allow,
                                showFiles: implus_lazy_load,
                                showThreshold: implus_load_treshold,
                                destroyOnClose : true,   
                                onlyMimes: implus_images,  
                              uiOptions : {toolbar : [['home', 'back', 'forward','up'],['reload'],['mkdir', 'upload'],['open', 'download', 'getfile'],['info'],['quicklook'],['copy', 'cut', 'paste'],['rm'],['duplicate', 'rename', 'edit', 'resize'],['extract', 'archive', 'sort'],['search'],['view'],['help']]},
                              contextmenu: {navbar: ["open", "|", "copy", "cut", "paste", "duplicate", "|", "rm", "|", "info"],cwd: ["reload", "back", "|", "upload", "mkdir", "mkfile", "paste", "|", "sort", "|", "info"],files: ["getfile", "|", "open", "quicklook", "|", "download", "|", "copy", "cut", "paste", "duplicate", "|", "rm", "|", "edit", "rename", "resize", "|", "archive", "extract", "|", "info"]},
                              
                                getFileCallback: function(files, elframe) {
                                          CKEDITOR.tools.callFunction(editor._.filebrowserFn, files.url);
                                          jQuery('.ui-dialog-titlebar-close[type="button"]').click();
                                    },
                                    commandsOptions: {
                                        getfile: {
                                            oncomplete: 'close',
                                            folders: false
                                        }
                                    }
                            }).elfinder('instance')
                          }
                      }
                  }
              });
                //--></script> 
<?php } ?> 

<script type="text/javascript"><!--
  $( document ).ready(function() {
    $('button[data-original-title = "Picture"]').addClass('btn-success');
    $('button[data-original-title = "Картинка"]').addClass('btn-success');
  });            
//--></script> 

      <?php if ($theme_status) {?>
      <style type="text/css">.elfinder-toolbar {background-color: <?php echo $con_implus_theme_toolbar_bg_color; ?>!important; background-image: none!important; padding: 0px;}.elfinder .elfinder-navbar {background: <?php echo $con_implus_theme_left_panel; ?>;}.ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl,.elfinder .ui-corner-all, .elfinder .ui-corner-top, .elfinder .ui-corner-right, .elfinder .ui-corner-tr{-webkit-border-radius: <?php echo $con_implus_theme_toolbar_round; ?>px!important; -moz-border-radius: <?php echo $con_implus_theme_toolbar_round; ?>px!important; border-radius: <?php echo $con_implus_theme_toolbar_round; ?>px!important;} .ui-state-hover, .ui-widget-content .ui-state-hover{background-color: <?php echo $con_implus_theme_hower; ?>;}.ui-corner-all.ui-state-hover{background-image: none!important;background-color: <?php echo $con_implus_theme_hower; ?>; }.elfinder-navbar .ui-state-active.ui-state-hover{  border-color: <?php echo $con_implus_theme_hower; ?>;}.ui-droppable.ui-draggable.ui-state-hover{  border-color: <?php echo $con_implus_theme_hower; ?>;}.ui-widget-content .ui-state-default {background-color: <?php echo $con_implus_theme_left_panel; ?>;}.elfinder .elfinder-button {background: <?php echo $con_implus_theme_icon_active; ?>;}.elfinder .elfinder-button.ui-state-disabled {background: <?php echo $con_implus_theme_icon_inactive; ?>;}.elfinder .elfinder-button.ui-state-hover{background: <?php echo $con_implus_theme_icon_hover; ?>;}.elfinder-workzone .elfinder-cwd-wrapper{border: 0px;background: <?php echo $con_implus_theme_right_panel; ?>;}.elfinder .elfinder-button{webkit-border-radius: <?php echo $con_implus_theme_icon_round; ?>px!important;-moz-border-radius: <?php echo $con_implus_theme_icon_round; ?>px!important;border-radius: <?php echo $con_implus_theme_icon_round; ?>px!important;}.elfinder-cwd-view-icons .elfinder-cwd-file .ui-state-hover {background: <?php echo $con_implus_theme_selected; ?>;}.elfinder .elfinder-button{border: <?php echo $con_implus_theme_icon_border; ?>px solid;}.elfinder .elfinder-button.elfinder-button-search{background: none; border: none; min-height: 28px;}.elfinder-quicklook-titlebar .ui-icon{width: 18px;}
      </style>
      <?php } ?> 
      <style type="text/css">
      .elfinder-button-icon-getfile, .elfinder-contextmenu-item {
          -webkit-touch-callout: none!important;
          -webkit-user-select: none!important;
          -khtml-user-select: none!important;
          -moz-user-select: none!important;
          -ms-user-select: none!important;
          user-select: none!important;
      } 
      .elfinder-button-icon-upmulti{background-position: 0px -860px;}
      <?php if ($double_images) {?>
        .elfinder-cwd-view-icons .elfinder-cwd-file-wrapper {width: 96px;height: 96px;}
        .elfinder-ltr .elfinder-cwd-view-icons .elfinder-cwd-file {margin: 0 3px 30px 0;}
        .elfinder-cwd-icon {width: 96px;height: 96px;}  
        .elfinder-cwd-view-icons .elfinder-cwd-file {width: 130px;height: 100px;}
        .elfinder-cwd-view-icons .elfinder-cwd-filename {font-size: 0.9em;}
        .elfinder-cwd-icon-directory {background-position: 0 -80px; background-size: 80px;}
        .elfinder-cwd-icon-image, .elfinder-cwd-icon-vnd-adobe-photoshop, .elfinder-cwd-icon-postscript{background-position: 0 -440px;background-size: 85px;}
        .elfinder-cwd-icon-html {background-position: 0 -973px;background-size: 85px;}
      <?php } ?> 
      </style>
      <script type="text/javascript">
              function addImages(image) {
               // console.log(image_row);
               // console.log(image); 

               // multy fix
                if ('<?php echo $im_root_folder; ?>' == '') {
                   image = image.replace("image/", ""); 
                }
                //

                $.ajax({
                  url: 'index.php?route=catalog/product/upmulti&token=<?php echo $token; ?>&uimage=' + encodeURIComponent(image),
                  dataType: 'text',
                  success: function(text) {
                    html = '<tr id="image-row' + image_row + '"><td class="text-left"><a href="" id="thumb-image' + image_row + '"data-toggle="image" class="img-thumbnail"><img src="'+text+'" alt="" title="" data-placeholder="" /><input type="hidden" name="product_image[' + image_row + '][image]" value="' + image + '" id="input-image' + image_row + '" /></td><td class="text-right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" placeholder="" class="form-control" /></td><td class="text-right"><input type="radio" name="implus_default_img" value="'+image+'" class="form-control"></td><td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row  + '\').remove();" data-toggle="tooltip" title="Remove" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td></tr>';                         
                    $('#images tbody').append(html);
                    image_row++;                    
                  }
                });
              } 

              function save_image(ftp_image) {
                    url = 'index.php?route=catalog/product/save_used_image_to_server&token=<?php echo $token; ?>'; 
                    if (ftp_image) {
                    url += '&ftp_image=' + encodeURIComponent(ftp_image);
                    }
                    // add to database
                    $.ajax({
                        url: url,
                        dataType: 'html',     
                        success: function(html){
                            console.log('--------');                           
                            console.log(html);
                        },
                        error: function(xhr, ajaxOptions, thrownError){ 
                            alert(xhr.responseText);
                        }
                    });
                    return false;
            }
        </script>
<?php } ?>
        
<footer id="footer"><?php echo $text_footer; ?><br /><?php echo $text_version; ?></footer></div>

			<script type="text/javascript"><!--
				function seoUrlFill(string,lang='en'){var delimiter='-',keyword=$('#input-keyword'),abc={'ß':'ss','à':'a','á':'a','â':'a','ã':'a','ä':'a','å':'a','æ':'ae','ç':'c','è':'e','é':'e','ê':'e','ë':'e','ì':'i','í':'i','î':'i','ï':'i','ð':'d','ñ':'n','ò':'o','ó':'o','ô':'o','õ':'o','ö':'o','ő':'o','ø':'o','ù':'u','ú':'u','û':'u','ü':'u','ű':'u','ý':'y','þ':'th','ÿ':'y','α':'a','β':'b','γ':'g','δ':'d','ε':'e','ζ':'z','η':'h','θ':'8','ι':'i','κ':'k','λ':'l','μ':'m','ν':'n','ξ':'3','ο':'o','π':'p','ρ':'r','σ':'s','τ':'t','υ':'y','φ':'f','χ':'x','ψ':'ps','ω':'w','ά':'a','έ':'e','ί':'i','ό':'o','ύ':'y','ή':'h','ώ':'w','ς':'s','ϊ':'i','ΰ':'y','ϋ':'y','ΐ':'i','ş':'s','ı':'i','ç':'c','ü':'u','ö':'o','ğ':'g','а':'a','б':'b','в':'v','г':'g','д':'d','е':'e','ё':'yo','ж':'zh','з':'z','и':'i','й':'j','к':'k','л':'l','м':'m','н':'n','о':'o','п':'p','р':'r','с':'s','т':'t','у':'u','ф':'f','х':'h','ц':'c','ч':'ch','ш':'sh','щ':'sh','ъ':'','ы':'y','ь':'','э':'e','ю':'yu','я':'ya','є':'ye','і':'i','ї':'yi','ґ':'g','č':'c','ď':'d','ě':'e','ň':'n','ř':'r','š':'s','ť':'t','ů':'u','ž':'z','ą':'a','ć':'c','ę':'e','ł':'l','ń':'n','ó':'o','ś':'s','ź':'z','ż':'z','ā':'a','č':'c','ē':'e','ģ':'g','ī':'i','ķ':'k','ļ':'l','ņ':'n','š':'s','ū':'u','ž':'z','ө':'o','ң':'n','ү':'u','ә':'a','ғ':'g','қ':'q','ұ':'u','ა':'a','ბ':'b','გ':'g','დ':'d','ე':'e','ვ':'v','ზ':'z','თ':'th','ი':'i','კ':'k','ლ':'l','მ':'m','ნ':'n','ო':'o','პ':'p','ჟ':'zh','რ':'r','ს':'s','ტ':'t','უ':'u','ფ':'ph','ქ':'q','ღ':'gh','ყ':'qh','შ':'sh','ჩ':'ch','ც':'ts','ძ':'dz','წ':'ts','ჭ':'tch','ხ':'kh','ჯ':'j','ჰ':'h'};switch(lang){case'bg':abc['щ']='sht';abc['ъ']='a';break;case'uk':abc['и']='y';break;}
				string=string.toLowerCase();for(var k in abc){string=string.replace(RegExp(k,'g'),abc[k]);}
				var alnum=(typeof(XRegExp)==='undefined')?RegExp('[^a-z0-9]+','ig'):XRegExp('[^\\p{L}\\p{N}]+','ig');string=string.replace(alnum,delimiter);string=string.replace(RegExp('['+delimiter+']{2,}','g'),delimiter);string=string.replace(RegExp('(^'+delimiter+'|'+delimiter+'$)','g'),'');if(keyword.length){keyword.val(string);}}
			//--></script>
			
</body></html>
