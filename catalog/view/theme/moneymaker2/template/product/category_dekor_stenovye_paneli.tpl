<?php echo $header ?>
<section class="special" style="height:auto;">
        <div class="container">
            <div class="special__inner">
                <div class="special__left">
                    <div class="special-title">
                        <h1>Декор.<br>
                            Стеновые панели</h1>
                        <p>от производителя</p>
                    </div>
                    <span>Закажите дверь прямо сейчас!</span>
                    <div class="special__form-open special__form-btn">Отправить заявку</div>
                    <div class="special__form-wrap">
                    <form class="special__form" action="https://beldoorss.ru/catalog/view/theme/moneymaker2/template/common/specialPost.php" method="post">
                        <div class="special__form-close">x</div>
                        <input type="text" placeholder="Имя*" name="firstName">
                        <input type="text" placeholder="+7 (777) 777 7777*" class="tel" name="phone">
                        <input type="text" placeholder="E-mail*" name="mail">
                        <input type="text" placeholder="Страна*" name="country">
                        <button type="submit" class="special__form-btn">Отправить заявку</button>
                    </form>
                    </div>
                </div>
                <div class="special-image" style="position:initial;"><img src="https://beldoorss.ru/image/category/interior-doors/decor-wall-panels.jpg" alt=""></div>
            </div>
        </div>
    </section>
<div class="container">
    <embed src="/docs/dekor-stenovye-paneli.pdf#view=FitH&amp;toolbar=0&amp;navpanes=0" type="application/pdf" width="100%" height="900px">

</div>
<script>
        window.addEventListener("DOMContentLoaded", function() {
        [].forEach.call( document.querySelectorAll('.tel'), function(input) {
            var keyCode;
            function mask(event) {
            event.keyCode && (keyCode = event.keyCode);
            var pos = this.selectionStart;
            if (pos < 3) event.preventDefault();
            var matrix = "+7 (___) ___ ____",
                i = 0,
                def = matrix.replace(/\D/g, ""),
                val = this.value.replace(/\D/g, ""),
                new_value = matrix.replace(/[_\d]/g, function(a) {
                    return i < val.length ? val.charAt(i++) : a
                });
            i = new_value.indexOf("_");
            if (i != -1) {
                i < 5 && (i = 3);
                new_value = new_value.slice(0, i)
            }
            var reg = matrix.substr(0, this.value.length).replace(/_+/g,
                function(a) {
                    return "\\d{1," + a.length + "}"
                }).replace(/[+()]/g, "\\$&");
            reg = new RegExp("^" + reg + "$");
            if (!reg.test(this.value) || this.value.length < 5 || keyCode > 47 && keyCode < 58) {
                this.value = new_value;
            }
            if (event.type == "blur" && this.value.length < 5) {
                this.value = "";
            }
            }

            input.addEventListener("input", mask, false);
            input.addEventListener("focus", mask, false);
            input.addEventListener("blur", mask, false);
            input.addEventListener("keydown", mask, false);

        });

        });
    </script>
<?php echo $footer ?>
<?php die(); ?>
