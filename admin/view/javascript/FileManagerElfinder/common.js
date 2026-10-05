function getURLVar(key) {
	var value = [];

	var query = document.location.search.split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}

function beldoorssFmAsset(path) {
	return path;
}

function beldoorssConnectorUrl(cfg) {
	var token = getURLVar('token') || (cfg && cfg.token) || '';
	var fallback = 'index.php?route=extension/module/FileManagerElfinder/connector&token=' + encodeURIComponent(token);
	var url = (cfg && cfg.url) ? String(cfg.url) : fallback;

	if (/^https?:\/\//i.test(url)) {
		try {
			var a = document.createElement('a');
			a.href = url;
			if (a.hostname && a.hostname !== window.location.hostname) {
				return fallback;
			}
			url = a.pathname + a.search;
		} catch (e) {
			return fallback;
		}
	}

	if (url.indexOf('token=') === -1 && token) {
		url += (url.indexOf('?') === -1 ? '?' : '&') + 'token=' + encodeURIComponent(token);
	}

	return url || fallback;
}

function beldoorssLoadElfinder(callback) {
	if ($.fn.elfinder) {
		callback();
		return;
	}

	if (!document.getElementById('elfinder-css-core')) {
		var cssFiles = [
			beldoorssFmAsset('view/javascript/jquery/jquery-ui/jquery-ui.min.css'),
			beldoorssFmAsset('view/javascript/FileManagerElfinder/css/elfinder.min.css'),
			beldoorssFmAsset('view/javascript/FileManagerElfinder/css/theme.css')
		];
		for (var c = 0; c < cssFiles.length; c++) {
			var link = document.createElement('link');
			link.rel = 'stylesheet';
			link.href = cssFiles[c];
			if (c === 0) {
				link.id = 'elfinder-css-core';
			}
			document.head.appendChild(link);
		}
	}

	$.getScript(beldoorssFmAsset('view/javascript/FileManagerElfinder/js/elfinder.min.js'), function() {
		$.getScript(beldoorssFmAsset('view/javascript/FileManagerElfinder/js/i18n/elfinder.ru.js')).always(function() {
			callback();
		});
	});
}

function beldoorssElfinderIsRendered($el) {
	if (!$el || !$el.length) {
		return false;
	}
	return $el.hasClass('elfinder') || $el.find('.elfinder-cwd, .elfinder-workzone, .elfinder-navbar').length > 0;
}

function beldoorssRetryElfinderIfEmpty() {
	var $el = $('#modal-image #elfinder');
	if (!$el.length || beldoorssElfinderIsRendered($el)) {
		return;
	}
	$el.removeAttr('data-elfinder-inited');
	try {
		if ($.fn.elfinder && $el.hasClass('elfinder')) {
			$el.elfinder('destroy');
		}
	} catch (e) {}
	beldoorssInitElfinderModal(true);
}

function beldoorssOpenElfinderFromHtml(html) {
	var nodes = $.parseHTML(html, document, false);
	var $modal = $('<div id="modal-image" class="modal"></div>');
	$modal.append(nodes);
	$('body').append($modal);
	$modal.one('shown.bs.modal', function() {
		beldoorssInitElfinderModal();
		window.setTimeout(beldoorssRetryElfinderIfEmpty, 300);
	});
	$modal.modal('show');
	window.setTimeout(function() {
		if ($('#modal-image').hasClass('in') || $('#modal-image').is(':visible')) {
			beldoorssInitElfinderModal();
		}
		window.setTimeout(beldoorssRetryElfinderIfEmpty, 300);
	}, 300);
}

function beldoorssInitElfinderModal(force) {
	var $el = $('#modal-image #elfinder');
	if (!$el.length) {
		return;
	}
	if (!force && $el.attr('data-elfinder-inited') === '1' && beldoorssElfinderIsRendered($el)) {
		return;
	}

	beldoorssLoadElfinder(function() {
		if (!$.fn.elfinder) {
			return;
		}

		$el = $('#modal-image #elfinder');
		if (!$el.length) {
			return;
		}
		if (!force && $el.attr('data-elfinder-inited') === '1' && beldoorssElfinderIsRendered($el)) {
			return;
		}

		var cfg = {};
		try {
			cfg = JSON.parse($el.attr('data-fm-config') || '{}');
		} catch (e) {
			cfg = {};
		}

		var lang = ($('html').attr('lang') || 'en').split('-')[0];
		var connectorUrl = beldoorssConnectorUrl(cfg);

		if ($.fn.button && $.fn.button.noConflict) {
			$.fn.btn = $.fn.button.noConflict();
		}

		try {
			if ($el.hasClass('elfinder')) {
				$el.elfinder('destroy');
			}
		} catch (e) {}

		$el.attr('data-elfinder-inited', '1');

		$el.elfinder({
			cssAutoLoad: false,
			baseUrl: cfg.baseUrl || beldoorssFmAsset('view/javascript/FileManagerElfinder/'),
			url: connectorUrl,
			customData: {
				token: cfg.token || getURLVar('token') || ''
			},
			lang: lang,
			rememberLastDir: false,
			useBrowserHistory: false,
			resizable: false,
			height: 600,
			commandsOptions: {
				getfile: {
					multiple: !!cfg.multiple,
					onlyURL: false
				}
			},
			closeOnEditorCallback: true,
			getFileCallback: function(fileOrFiles, fm) {
				function applyFile(file, first) {
					if (!file) {
						return;
					}
					var path = (file.path || '').replace(/\\\\/g, '/').replace(/\\/g, '/');
					if (first && cfg.target) {
						$('#' + cfg.target).val(path);
					}
					if (first && cfg.thumb) {
						$('#' + cfg.thumb).html('<img src="' + file.tmb + '">');
					}
					if (cfg.summernote && file.url) {
						if (file.mime == 'video/mp4') {
							$('#' + cfg.summernote).summernote('pasteHTML', '<div class="summernote-html5-video"><video controls="" name="media" style="height:auto; max-width:100%"><source src="' + file.url + '" type="video/mp4"></video></div>');
						} else if ($('#' + cfg.summernote).length) {
							$('#' + cfg.summernote).summernote('insertImage', file.url);
						}
					}
					if (cfg.ckeditor && file.url && window.CKEDITOR && CKEDITOR.dialog.getCurrent()) {
						var cke_target = String(cfg.ckeditor).split(':');
						CKEDITOR.dialog.getCurrent().setValueOf(cke_target[0], cke_target[1], file.url);
					}
				}

				if (cfg.multiple && $.isArray(fileOrFiles)) {
					var firstApplied = false;
					$.each(fileOrFiles, function(item, file) {
						if (file.read && file.hash) {
							applyFile(file, !firstApplied);
							firstApplied = true;
						}
					});
				} else {
					applyFile(fileOrFiles, true);
				}

				$('#modal-image').modal('hide');
				if (fm && fm.hide) {
					fm.hide();
				}
			}
		});
	});
}

$(document).ready(function() {
	//Form Submit for IE Browser
	$('button[type=\'submit\']').on('click', function() {
		$("form[id*='form-']").submit();
	});

	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Set last page opened on the menu
	$('#menu a[href]').on('click', function() {
		sessionStorage.setItem('menu', $(this).attr('href'));
	});

	if (!sessionStorage.getItem('menu')) {
		$('#menu #dashboard').addClass('active');
	} else {
		// Sets active and open to selected page in the left column menu.
		$('#menu a[href=\'' + sessionStorage.getItem('menu') + '\']').parents('li').addClass('active open');
	}

	if (localStorage.getItem('column-left') == 'active') {
		$('#button-menu i').replaceWith('<i class="fa fa-dedent fa-lg"></i>');

		$('#column-left').addClass('active');

		// Slide Down Menu
		$('#menu li.active').has('ul').children('ul').addClass('collapse in');
		$('#menu li').not('.active').has('ul').children('ul').addClass('collapse');
	} else {
		$('#button-menu i').replaceWith('<i class="fa fa-indent fa-lg"></i>');

		$('#menu li li.active').has('ul').children('ul').addClass('collapse in');
		$('#menu li li').not('.active').has('ul').children('ul').addClass('collapse');
	}

	// Menu button
	$('#button-menu').on('click', function() {
		// Checks if the left column is active or not.
		if ($('#column-left').hasClass('active')) {
			localStorage.setItem('column-left', '');

			$('#button-menu i').replaceWith('<i class="fa fa-indent fa-lg"></i>');

			$('#column-left').removeClass('active');

			$('#menu > li > ul').removeClass('in collapse');
			$('#menu > li > ul').removeAttr('style');
		} else {
			localStorage.setItem('column-left', 'active');

			$('#button-menu i').replaceWith('<i class="fa fa-dedent fa-lg"></i>');

			$('#column-left').addClass('active');

			// Add the slide down to open menu items
			$('#menu li.open').has('ul').children('ul').addClass('collapse in');
			$('#menu li').not('.open').has('ul').children('ul').addClass('collapse');
		}
	});

	// Menu
	$('#menu').find('li').has('ul').children('a').on('click', function() {
		if ($('#column-left').hasClass('active')) {
			$(this).parent('li').toggleClass('open').children('ul').collapse('toggle');
			$(this).parent('li').siblings().removeClass('open').children('ul.in').collapse('hide');
		} else if (!$(this).parent().parent().is('#menu')) {
			$(this).parent('li').toggleClass('open').children('ul').collapse('toggle');
			$(this).parent('li').siblings().removeClass('open').children('ul.in').collapse('hide');
		}
	});

	// Tooltip remove fixed
	$(document).on('click', '[data-toggle=\'tooltip\']', function(e) {
		$('body > .tooltip').remove();
	});

	// Image Manager
  $(document).on('click', 'a[data-toggle=\'image\']', function(e) {
		var $element = $(this);
		var $popover = $element.data('bs.popover'); // element has bs popover?
		
		e.preventDefault();

		// destroy all image popovers
		$('a[data-toggle="image"]').popover('destroy');

		// remove flickering (do not re-add popover when clicking for removal)
		if ($popover) {
			return;
		}

		$element.popover({
			html: true,
			placement: 'right',
			trigger: 'manual',
			content: function() {
				return '<button type="button" id="button-elfinder" class="btn btn-primary"><i class="fa fa-pencil"></i></button> <button type="button" id="button-clear" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>';
			}
		});

		$element.popover('show');

		if($(this).hasClass('multiple')) {
			var $multiple = '&multiple=true';
		} else {
			var $multiple = '';
		}

		$('#button-elfinder').on('click', function() {
			var $button = $(this);
			var $icon   = $button.find('> i');
			
			$('#modal-image').remove();

			$.ajax({
				url: 'index.php?route=extension/module/FileManagerElfinder/manager&token=' + getURLVar('token') + '&target=' + encodeURIComponent($element.parent().find('input').attr('id') || '') + '&thumb=' + encodeURIComponent($element.attr('id') || '') + $multiple,
				dataType: 'html',
				beforeSend: function() {
					$button.prop('disabled', true);
					if ($icon.length) {
						$icon.attr('class', 'fa fa-circle-o-notch fa-spin');
					}
				},
				complete: function() {
					$button.prop('disabled', false);
					if ($icon.length) {
						$icon.attr('class', 'fa fa-pencil');
					}
				},
				success: function(html) {
					beldoorssOpenElfinderFromHtml(html);
				}
			});

			$element.popover('destroy');
		});

		$('#button-clear').on('click', function() {
			var img  = '<img src="view/image/no_image.png">';
			$element.html(img);

			$element.parent().find('input').val('');

			$element.popover('destroy');
		});
	});

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body', html: true});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});

	// https://github.com/opencart/opencart/issues/2595
	$.event.special.remove = {
		remove: function(o) {
			if (o.handler) {
				o.handler.apply(this, arguments);
			}
		}
	}

	$('[data-toggle=\'tooltip\']').on('remove', function() {
		$(this).tooltip('destroy');
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			var $this = $(this);
			var $dropdown = $('<ul class="dropdown-menu" />');
			
			this.timer = null;
			this.items = [];

			$.extend(this, option);

			$this.attr('autocomplete', 'off');

			// Focus
			$this.on('focus', function() {
				this.request();
			});

			// Blur
			$this.on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$this.on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				var value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $this.position();

				$dropdown.css({
					top: pos.top + $this.outerHeight(),
					left: pos.left
				});

				$dropdown.show();
			}

			// Hide
			this.hide = function() {
				$dropdown.hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				var html = '';
				var category = {};
				var name;
				var i = 0, j = 0;

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						// update element items
						this.items[json[i]['value']] = json[i];

						if (!json[i]['category']) {
							// ungrouped items
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						} else {
							// grouped items
							name = json[i]['category'];
							if (!category[name]) {
								category[name] = [];
							}

							category[name].push(json[i]);
						}
					}

					for (name in category) {
						html += '<li class="dropdown-header">' + name + '</li>';

						for (j = 0; j < category[name].length; j++) {
							html += '<li data-value="' + category[name][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[name][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$dropdown.html(html);
			}

			$dropdown.on('click', '> li > a', $.proxy(this.click, this));
			$this.after($dropdown);
		});
	}
})(window.jQuery);
