$.fn.extend({
    TSProductFilterUp: function(options) {
        var options = $.extend({
            toggle: true,						// switching the method of displaying filter groups (true/false)
            speed: 200,							// speed of the animation (number: 0 or more)
            items: 10,							// if greater than "N", then the "Show more" button appears; specify 0 if you want to show all
            items_count: true,					// number of checked items of the filter group (true/false)
            items_count_all: true,				// number of checked items of all groups (true/false)
            btn_reset: true,					// allows one-click to reset all applied filter parameters (true/false)
            btn_filter: true,					// additional "floating" button - "Refuse Search" (true/false)
            btn_filter_text: 'Поиск',
            btn_more_text: 'Показать еще'
        }, options);
        
        
        // filter accordion
        this.find('a.active').next('div').find('div').not('.checkbox').addClass('collapse in');
        this.find('a').not('.active, .more_items').next('div').find('div').not('.checkbox').addClass('collapse');
        this.find('a').not('.more_items').on('click', function (e) {
            e.preventDefault();
            
            $(this).toggleClass('active').next('div').find('div').not('.checkbox').collapse('toggle');
            
            if (options.toggle) {
                $(this).siblings().removeClass('active').next('div').find('div.in').not('.checkbox').collapse('hide');
            } else {
                $(this).next('div').find('div.in').not('.checkbox').collapse('hide');
            }
            
            addMoreBtn( $(this).next('div').find('div') );
            
            $('#button-filter-up').remove();
            
            return false;
        });
        
        
        // filter actions
        this.find('input[type="checkbox"]').on('click', function (e) {
            
            // filter group items
            var filter_group = $(this).closest('.checkbox').parent('div');
            var filter_group_items = parseInt(filter_group.data('items'));
            var filter_group_items_all = parseInt($('.filter-items-all').data('items'));
            if($(this).prop('checked')) {
                filter_group_items++;
                filter_group_items_all++;
            } else {
                filter_group_items--;
                filter_group_items_all--;
            }
            
			if(options.items_count) {
				filter_group.data('items', filter_group_items);
				if(filter_group_items > 0) {
					filter_group.parent('div').prev('a.active').find('.filter-items').html('(' + filter_group_items + ')');
				} else {
					filter_group.parent('div').prev('a.active').find('.filter-items').html('');
				}
			}
            
			if(options.items_count_all) {
				$('.filter-items-all').data('items', filter_group_items_all);
				if(filter_group_items_all > 0) {
					$('.filter-items-all').html('(' + filter_group_items_all + ')');
				} else {
					$('.filter-items-all').html('');
				}
			}

            // filter reset button
			if(options.btn_reset) {
				if(filter_group_items_all > 0) {
					$('#button-filter-reset').show(options.speed);
				} else {
					$('#button-filter-reset').hide(options.speed);
				}
			}
            
            // second filter button
			if(options.btn_filter) {
				$('#button-filter-up').remove();
				$(this).closest('.checkbox').append('<button type="button" id="button-filter-up" class="btn btn-primary" onclick="$(\'#button-filter\').click();">' + options.btn_filter_text + '</button>');
			}
            
            var ch = 0;
            $('input[type="checkbox"]:checked').each(function(){ ch++; });
            if(ch == 0) {
                $('#button-filter-up').remove();
            }
            
        });
        
        
        // filter after fulfilment
        this.find('input[type="checkbox"]:checked').each(function() {
            
            // filter group items
			if(options.items_count) {
				var filter_group = $(this).closest('.checkbox').parent('div');
				filter_group.data('items', parseInt(filter_group.data('items')) + 1);
				if(parseInt(filter_group.data('items')) > 0) {
					filter_group.parent('div').prev('a').find('.filter-items').html('(' + parseInt(filter_group.data('items')) + ')');
				} else {
					filter_group.parent('div').prev('a').find('.filter-items').html('');
				}
			}
            
            // filter group items all
			if(options.items_count_all) {
				$('.filter-items-all').data('items', parseInt($('.filter-items-all').data('items')) + 1);
				if(parseInt($('.filter-items-all').data('items')) > 0) {
					$('.filter-items-all').html('(' + parseInt($('.filter-items-all').data('items')) + ')');
				} else {
					$('.filter-items-all').html('');
				}
			}
            
			if(options.btn_reset) {
				// filter reset button
				if(parseInt($('.filter-items-all').data('items')) > 0) {
					$('#button-filter-reset').show(options.speed);
				} else {
					$('#button-filter-reset').hide(options.speed);
				}
			}
            
        });
        
        
        // filter reset button
        this.prev('.panel-heading').find('#button-filter-reset').on('click', function (e) {
            $(this).parent('div').next('.list-group').find('input[type="checkbox"]:checked').each(function() {
                
                $(this).prop('checked', false);
                
                // reset group items
                var filter_group = $(this).closest('.checkbox').parent('div');
                filter_group.parent('div').prev('a').find('.filter-items').html('');
                filter_group.data('items', 0);
                
                // reset group items all
                $('.filter-items-all').data('items', 0).html('');
                
            });
            
            $('#button-filter-up').remove();
            $(this).hide(options.speed);
        });
        
        
        
        // "More" btn
        this.on('click', 'a.more-items', function () {
            $(this).parent('div.in').find('div.checkbox').show(options.speed);
            $(this).hide(0);
            
            return false;
        });
        
        $('div.collapse').each(function(){
            addMoreBtn( $(this) );
        });
        
        // add "More" btn & hide items
        function addMoreBtn(list) {
            if(options.items > 0) {
                list.find('div.checkbox').each(function(id, element) {
                    var items_count = list.find('div.checkbox').length;
                    
                    if(id == options.items - 1 && items_count > options.items) {
                        if(list.find('a.more-items').length == 0) {
                            var items_left = items_count - options.items;
                            $(this).after('<a href="javascript:void(0);" class="more-items">' + options.btn_more_text + ' ' + items_left + '</a>');
                        } else {
                            list.find('a.more-items').show(0);
                        }
                    }
                    
                    if(id > options.items - 1) {
                        $(this).hide(0);
                    }
                });
            }
        }
        
        
    }
});