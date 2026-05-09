<div id="confirm_view" class="qc-step" data-col="<?php echo $col; ?>" data-row="<?php echo $row; ?>"></div>

<script type="text/html" id="confirm_template">
<div id="confirm_wrap">
	<div class="panel panel-default">
		<div class="panel-body">
			<form id="confirm_form" class="form-horizontal">
			</form>

			<!-- ✅ Чекбокс с условиями -->
			<div class="form-group" style="margin-bottom: 15px;">
				<label for="agree_terms" style="display: block; font-weight: normal;">
					<input type="checkbox" id="agree_terms" style="margin-right: 8px;" />
					Спасибо за ваш заказ! Перед покупкой вы соглашаетесь с условиями:
					<a href="/politika-konfidencialnosti" target="_blank">Политика конфиденциальности</a>,
					<a href="/polzovatelskoe-soglashenie" target="_blank">Пользовательское соглашение</a>
				</label>
			</div>

			<!-- Кнопка подтверждения заказа -->
			<button id="qc_confirm_order" class="btn btn-primary btn-lg btn-block" disabled>
				<% if(Number(model.payment_popup)) { %>
					<?php echo $button_continue; ?>
				<% } else { %>
					<?php echo $button_confirm; ?>
				<% } %>
			</button>

		</div>
	</div>
</div>
</script>

<script>
$(function () {
	qc.confirm = $.extend(true, {}, new qc.Confirm(<?php echo $json; ?>));
	qc.confirmView = $.extend(true, {}, new qc.ConfirmView({
		el: $("#confirm_view"),
		model: qc.confirm,
		template: _.template($("#confirm_template").html())
	}));

	// ✅ Активируем кнопку только если чекбокс отмечен
	$(document).on('change', '#agree_terms', function () {
		$('#qc_confirm_order').prop('disabled', !this.checked);
	});
});
</script>
