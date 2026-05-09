function changeOptionImage(elem, setting) {
	$(elem + ' input:checked, ' + elem + ' option:selected').each(function() {
		if (typeof $(this).data('product-image-popup') != 'undefined') {
			$(setting.popup_element).prop(setting.popup_attr, $(this).data('product-image-popup'));
		}
		
		if (typeof $(this).data('product-image-thumb') != 'undefined') {
			$(setting.thumb_element).prop(setting.thumb_attr, $(this).data('product-image-thumb'));
		}
    });
}