<div id="confirm_view" class="qc-step" data-col="<?php echo $col; ?>" data-row="<?php echo $row; ?>"></div>

<script type="text/html" id="confirm_template">
<div id="confirm_wrap">
	<div class="panel panel-default">
		<div class="panel-body">
			<form id="confirm_form" class="form-horizontal">
			</form>

			<!-- Чекбокс ФЗ-152 -->
			<div class="form-group agree-pdn-wrap" style="margin-bottom: 15px;">
				<label for="agree_terms" style="display: block; font-weight: normal;">
					<input type="checkbox" id="agree_terms" class="agree-checkbox" name="agree_pdn" value="1" required style="margin-right: 8px;" />
					Я согласен на <a href="/politika-konfidencialnosti" target="_blank" rel="noopener">обработку персональных данных</a>
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

	// Активируем кнопку только если чекбокс отмечен
	$(document).on('change', '#agree_terms', function () {
		$('#qc_confirm_order').prop('disabled', !this.checked);
	});
	$(document).on('click', '#qc_confirm_order', function (e) {
		if (!$('#agree_terms').is(':checked')) {
			e.preventDefault();
			e.stopImmediatePropagation();
			alert('Необходимо согласие на обработку персональных данных');
			return false;
		}
	});
});
</script>
