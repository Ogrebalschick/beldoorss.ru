// Для разработки
if (document.location.href.indexOf('vhodnye-dveri-vse') !== -1) {
    location = "http://beldoorss.ru/precategorypage";
};
// if(document.location.href.indexOf('nashi-raboty') !== -1){
//     location="http://beldoorss.ru/galereya";
// }
if (document.location.href.indexOf('https://new.beldoorss.ru/index.php?route=information/information&information_id=17') !== -1) {
    location = "http://beldoorss.ru/galereya";
};

/**
 * Калькулятор стоимости двери на карточке товара.
 *
 * Формула:
 *   итог = цена полотна (базовая)
 *        + отмеченные пункты комплекта
 *        + отмеченные дополнительные опции
 *
 * Доборы («Комплект доборов…», «Установка доборов…») НЕ входят
 * в базовую цену «Комплект стандарт». Их стоимость прибавляется
 * только если пользователь явно поставил галочку.
 *
 * Автокальк OpenCart (`recalculateprice` в product.tpl) считает
 * ту же сумму по отмеченным input[data-price].
 */
(function ($) {
    var DOBOR_RE = /добор/i;

    function parseMoney(value) {
        if (value == null || value === '') {
            return 0;
        }
        return Number(String(value).replace(/[^\d.,-]/g, '').replace(',', '.')) || 0;
    }

    function parseDisplayedPrice(text) {
        return Number(String(text || '').replace(/[^\d]/g, '')) || 0;
    }

    function formatRub(amount) {
        amount = Math.round(Number(amount) || 0);
        return String(amount).replace(/(\d)(?=(\d{3})+(?:\D|$))/g, '$1 ') + ' руб.';
    }

    function isDoborInput($input) {
        if (!$input || !$input.length) {
            return false;
        }
        if (String($input.attr('data-dobor')) === '1' || $input.hasClass('option-dobor')) {
            return true;
        }
        var labelText = $input.closest('label').text() || '';
        return DOBOR_RE.test(labelText);
    }

    function kitFormGroup() {
        return $('.options .checkbox-option').filter(function () {
            return /комплект/i.test($(this).text());
        }).closest('.form-group').first();
    }

    function getCanvasPrice() {
        var $polotno = $('.input-option label').filter(function () {
            return /полотно/i.test($(this).text());
        }).first();
        if ($polotno.length) {
            var fromLabel = parseDisplayedPrice($polotno.text());
            if (fromLabel) {
                return fromLabel;
            }
        }
        var $shown = $('.price_base .price-new.price-show, .price_base .price-new').first();
        if ($shown.length) {
            return parseDisplayedPrice($shown.text());
        }
        return parseDisplayedPrice($('.product-total').not('.checkbox-option').first().find('.price-new').text());
    }

    function applyOptionPrice(total, $input) {
        var prefix = String($input.data('prefix') || '+');
        var price = parseMoney($input.data('price'));
        if (prefix === '=') {
            return price;
        }
        if (prefix === '-') {
            return total - price;
        }
        return total + price;
    }

    var storedKitPrice = '';

    function rememberKitPrice() {
        if (!storedKitPrice) {
            storedKitPrice = $.trim(kitFormGroup().find('.product-price').first().text());
        }
    }

    function kitHasCheckedOptions() {
        return kitFormGroup().find('.input-option input[type="checkbox"]:checked').length > 0;
    }

    function updateKitHeadline() {
        var $group = kitFormGroup();
        if (!$group.length) {
            return;
        }
        rememberKitPrice();
        if (!kitHasCheckedOptions()) {
            if (storedKitPrice) {
                $group.find('.product-price').first().text(storedKitPrice);
            }
            return;
        }
        var total = getCanvasPrice();
        $group.find('.input-option input[type="checkbox"]:checked').each(function () {
            total = applyOptionPrice(total, $(this));
        });
        $group.find('.product-price').first().text(formatRub(total));
    }

    function recalcAll() {
        if (typeof recalculateprice === 'function') {
            recalculateprice();
        }
        updateKitHeadline();
    }

    /**
     * @param {boolean} selectKit true — включить состав комплекта БЕЗ доборов
     */
    function applyKitSelection(selectKit) {
        kitFormGroup().find('.input-option input[type="checkbox"]').each(function () {
            var $el = $(this);
            if (!selectKit) {
                $el.prop('checked', false);
            } else {
                // Доборы остаются выключенными, пока клиент сам не отметит галочку
                $el.prop('checked', !isDoborInput($el));
            }
        });
        recalcAll();
    }

    window.beldoorssIsDobor = isDoborInput;
    window.beldoorssUpdateKitPrice = updateKitHeadline;
    window.beldoorssApplyKitSelection = applyKitSelection;
    window.beldoorssRecalcDoorPrice = recalcAll;
})(jQuery);

$(document).ready(function () {
    $('.header__menu').hover(function () {
        $('.header__menu-inner').toggleClass('active')
    })
    /*В зависимости от ширины экрана, меняется meta тег viewport для адаптивности*/
    var resize = false;
    $(window).on('load resize orientationchange', function (e) {
        if (resize === false) {
            if (screen.width <= 768) {
                var mvp = document.getElementById('myViewport');
                mvp.setAttribute('content', 'width=390');
            }
            if (screen.width > 768) {
                var mvp = document.getElementById('myViewport');
                mvp.setAttribute('content', 'width=1600');
            }
            resize = true;
        }

        setTimeout(function (object) {
            resize = false;
        }, 300);
    });

    $(".burger").on('click', function () {
        $(".menu").toggleClass("menu__open");
        $("body").toggleClass("overflow-hidden");
    });

    $('.product__types .radio:first-child').addClass('active');

    $(`.product-total__inner .price-new:nth-child(2)`).addClass('price-show');

    let optionSizeID = 0
    $.each($('.option-osteclenie .optionSize>div .radio'), function (index, data) {
        optionSizeID++
        $(this).attr('id', `${optionSizeID}`);
    });

    $('.option-osteclenie .radio:first-child').removeClass('active');
    $('.option-osteclenie .radio').find(`input[data-link="${window.location.href}"]`).parent().parent().addClass('active');
    $('.option-osteclenie .radio').click(function () {
        var data_link = $(this).find('label input').attr('data-link')
        if (data_link != 0) {
            window.location.href = data_link;
        }
    });
    $('.product__types .radio').click(function () {
        $(this).parent().find('.radio').removeClass('active')
        $(this).addClass('active')

    });
    $('.option-osteclenie .optionSize>div .radio.active').each(function () {
        let numOptionSize4 = $(this).attr('id');
        numOptionSize4++
        $(`.product-total__inner .price-new`).removeClass('price-show')
        $(`.product-total__inner .price-new:nth-child(${numOptionSize4})`).addClass('price-show')
    });
    $('.option-osteclenie .optionSize>div .radio').click(function () {
        let numOptionSize4 = $(this).attr('id');
        numOptionSize4++
        $(`.product-total__inner .price-new`).removeClass('price-show')
        $(`.product-total__inner .price-new:nth-child(${numOptionSize4})`).addClass('price-show')
        console.log('1234')
    });

    /* Вкладки комплектации: полотно / комплект стандарт / доп.опции */
    if (typeof window.beldoorssUpdateKitPrice === 'function') {
        window.beldoorssUpdateKitPrice();
    }
    $('.checkbox-option').siblings('.input-option').find('input').prop('checked', false);
    if (typeof recalculateprice === 'function') {
        recalculateprice();
    }

    $('.product-total').on('click', function (e) {
        var $block = $(this);
        var $arrow = $block.find('i');
        if ($block.closest('.options-more').length) {
            return;
        }
        if (e.target === $arrow[0] || $(e.target).closest('i').length) {
            return;
        }
        $('.product-total').not($block).removeClass('active');
        $block.addClass('active');
        if (typeof window.beldoorssApplyKitSelection === 'function') {
            // Первая вкладка («Цена за полотно» / «Цена») — только полотно
            window.beldoorssApplyKitSelection($block.hasClass('checkbox-option'));
        }
    });

    $('.product-total.checkbox-option i').on('click', function () {
        var $list = $(this).parent().siblings('.input-option');
        $list.toggle();
    });

    $(document).on('change', '.options input[type="checkbox"]', function () {
        if (typeof window.beldoorssUpdateKitPrice === 'function') {
            window.beldoorssUpdateKitPrice();
        }
    });

    // Плюс/минус в карточке товара  
    $(".quantity-add").click(function () {
        $(this).prev().val(+$(this).prev().val() + 1)
    });
    $(".quantity-sub").click(function () {
        $(this).next().next().val() > 1 && $(this).next().next().val(+$(this).next().next().val() - 1)
        console.log($(this).next())
    });
    $('.maincategories__opened-item').hover(function () {
        $(this).addClass('active')
    });
    $('.maincategories__inside-doors').hover(function () {
        if ($('.inside-doors__opened').hasClass('active')) {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
        } else {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
            $('.inside-doors__opened').addClass('active')
        }
    });
    $('.maincategories__mejrooms-doors').hover(function () {
        if ($('.mejrooms-doors__opened').hasClass('active')) {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
        } else {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
            $('.mejrooms-doors__opened').addClass('active')
        }

    });
    $('.maincategories__furniture-doors').hover(function () {
        if ($('.furneturs-doors__opened').hasClass('active')) {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
        } else {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
            $('.furneturs-doors__opened').addClass('active')
        }
    });
    $('.maincategories__akcii-doors').hover(function () {
        if ($('.akcii-doors__opened').hasClass('active')) {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
        } else {
            $('.maincategories__opened .maincategories__opened-item').removeClass('active')
            $('.akcii-doors__opened').addClass('active')
        }
    });

    $('.maincategories__inner .maincategories__item').hover(function () {
        $('.maincategories__inner').find('.maincategories__item').removeClass('active')
        $(this).addClass('active')
    });
    /*$('.product__gallery-top .thumbnail').magnificPopup({type:'image'});/*
  
      /*var swiper = new Swiper(".maingroup__slider",{
          spaceBetween:30,
          effect:"fade",
          navigation:{
              nextEl:".swiper-button-next",
              prevEl:".swiper-button-prev"
          },
          pagination:{
              el:".swiper-pagination",
              clickable:!0
          }
      });
                  
      function openCity(e,t){
          var n,a,l;
          for(a=document.getElementsByClassName("tabcontent"),n=0;n < a.length;n++)
          a[n].style.display="none";
          for(l=document.getElementsByClassName("tablinks"),n=0;n<l.length;n++)
          l[n].className=l[n].className.replace(" active","");
          
          document.getElementById(t).style.display="block",e.currentTarget.className+=" active"
      }*/

    var priceOld = $('.product-total__inner .price-new.price-show').text()
    $('.optionColor').on('change', 'input', function () {
        console.log("$('.product-total__inner .product-price').text(): " + $('.product-total__inner .product-price').text());
        let complectPriceOldAfter = $('.product-total__inner .product-price').text();
        var symol = $(this).attr("data-prefix");
        var price = $(this).attr("data-price");
        console.log(symol, price);

        console.log('.product-total__inner .product-price: ' + $('.product-total__inner .product-price').text());
        console.log('priceOld: ' + priceOld);




        if (price == 0) {
            var priceNew = priceOld.replace(/[^\d]/g, '');

            console.log(priceOld);
        } else if (symol == 'u') {
            var priceProcent = '1.' + price;
            var priceNew = priceOld.replace(/[^\d]/g, '') * priceProcent;


            console.log(priceNew);
        } else if (symol == 'd') {
            var priceProcent = 1 - ('0.' + price);
            var priceNew = priceOld.replace(/[^\d]/g, '') * priceProcent;
        } else if (symol == '+') {
            var priceNew = Number(priceOld.replace(/[^\d]/g, '')) + Number(price);
        } else if (symol == '-') {
            var priceMinus = price;
            var priceNew = priceOld.replace(/[^\d]/g, '') - priceMinus;
            console.log(priceNew);
        } else {
            var priceNew = priceOld.replace(/[^\d]/g, '');
        }

        console.log('price: ' + priceNew);
        var priceNew = Number(priceNew).toFixed();
        var priceNew = String(priceNew);
        var readyPrice = priceNew.replace(/(\d)(?=(\d{3})+(\D|$))/g, '$1 ');


        $('.product-total__inner .price-new.price-show').text(readyPrice + ' руб.');
        $('.input-option').find('label:contains("Полотно")').text("Полотно ( = " + readyPrice + " руб. )");
        if (typeof window.beldoorssUpdateKitPrice === 'function') {
            window.beldoorssUpdateKitPrice();
        }

        var data_link_color = $(this).attr("data-link");
        if (data_link_color != '0') {
            console.log('123123123');
            window.location.href = data_link_color;
        }
    });

    var color = $('.optionColor').find('.radio input[data-checked="1"]')
    $('.optionColor').find('input[data-checked="1"]').attr('checked', true);
    $('.optionColor').find('.radio input[data-checked="1"]').parent().parent().click();
    if (color) {
        $('.optionColor').find('.radio').removeClass('active');
        $('.optionColor').find('.radio input[data-checked="1"]').parent().parent().addClass('active');

    }
    setTimeout(() => {
        $('.optionColor').find('input[data-checked="1"]').prop('checked', true);
    }, 1000);

    var color = $('.optionMirror').find('.radio input[data-checked="1"]')
    $('.optionMirror').find('input[data-checked="1"]').attr('checked', true);
    $('.optionMirror').find('.radio input[data-checked="1"]').parent().parent().click();
    if (color) {
        $('.optionMirror').find('.radio').removeClass('active');
        $('.optionMirror').find('.radio input[data-checked="1"]').parent().parent().addClass('active');

    }
    setTimeout(() => {
        $('.optionMirror').find('input[data-checked="1"]').prop('checked', true);
    }, 1000);

    if ($('.h2.content-title').text() !== '') {
        var catalogTitleNow = $('.h2.content-title').text();
        localStorage.setItem("catalogTitle", catalogTitleNow);

        localStorage.setItem("catalogLink", window.location.href);
    }
    var catalogLink = localStorage.getItem("catalogLink");
    var catalogTitle = localStorage.getItem("catalogTitle");
    console.log(catalogTitle);
    $(".catalogTitle>span").text(catalogTitle);
    $(".catalogTitle").attr('href', catalogLink);

    if (catalogTitle != null) {
        console.log('not pustoi');
        $(".catalogTitle").parent().attr('hidden', false);
    }


    // let maincategories__category_vhod = `
    // <div class="maincategories__opened">
    //  <div class="maincategories__opened-item inside-doors__opened active">
    //     <a href="https://new.beldoorss.ru/ulichnye-dveri/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2><span>Уличные</span> двери</h2>
    //             <p>(двери в дом, коттедж)</p>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //     <a href="https://new.beldoorss.ru/dveri-v-kvartiru/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2>Двери <span>в квартиру</span></h2>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //     <a href="https://new.beldoorss.ru/dvustvorchatye-dveri/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2><span>Двухстворчатые</span> двери</h2>
    //             <p>нестандартные</p>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //     <a href="https://new.beldoorss.ru/dveri-s-umnym-biometricheskim-zamkom/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2>Двери с <span>биометрическим</span> замком</h2>
    //             <p>(умным, электронным)</p>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //     <a href="https://new.beldoorss.ru/tekhnicheskie_dveri/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2><span>Противопожарные,</span><br>Технические двери</h2>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //  </div>
    //  </div>
    // `
    // let vhodnieDveri = $('.breadcrumb').find('li:contains("Входные двери")').text()
    // let vhodnieDveri2 = $('.breadcrumb').find('a:contains("Входные двери")').text()
    // if (vhodnieDveri2 != '' || vhodnieDveri != '') {
    //     $('main .row').find('.maincategories__wrap').append(maincategories__category_vhod)
    // }

    // let maincategories__category_mej = `
    // <div class="maincategories__opened">
    //  <div class="maincategories__opened-item mejrooms-doors__opened active">
    //     <a href="https://new.beldoorss.ru/specialnye/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2><span>Специальные</span></h2>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //     <a href="https://new.beldoorss.ru/dekor-stenovye-paneli/" class="category-item category-item__withtext">
    //         <div class="category-item__text">
    //             <h2><span>Декор. <br>Стеновые панели</span></h2>
    //         </div>
    //         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //     </a>
    //  </div>
    //  </div>
    // `

    // let mejDveri = $('.breadcrumb').find('li:contains("Межкомнатные двери")').text()
    // let mejDveri2 = $('.breadcrumb').find('a:contains("Межкомнатные двери")').text()
    // if (mejDveri != '' || mejDveri2 != '') {
    //     $('main .row').find('.maincategories__wrap').append(maincategories__category_mej)
    // }


    // let maincategories__category_furnitura = `
    //  <div class="maincategories__opened">

    //                  <div class="maincategories__opened-item furneturs-doors__opened active">
    //                     <a href="https://new.beldoorss.ru/dvernaya-furnitura-v-internet-magazine/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2>Дверная <span>фурнитура</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/mezhkomnatnye-dveri/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2>Дверные <span>ручки</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/dvernye-zamki/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2>Дверные <span>замки</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/dvernye-petli/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2>Дверные <span>петли</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/fiksatory-i-nakladki/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2><span>Фиксаторы и накладки</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/cilindry-i-lichinki/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2><span>Цилиндры и личинки</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                     <a href="https://new.beldoorss.ru/dvernye-upory/" class="category-item category-item__withtext">
    //                         <div class="category-item__text">
    //                             <h2><span>Дверные упоры</span></h2>
    //                         </div>
    //                         <div class="category-item__img"><img src="https://new.beldoorss.ru/image/category/1.jpg" alt=""></div>
    //                     </a>
    //                  </div>
    //         </div>
    // `

    // let furnituraDveri = $('.breadcrumb').find('li:contains("Дверная фурнитура в интернет-магазине")').text()
    // let furnituraDveri2 = $('.breadcrumb').find('a:contains("Дверная фурнитура в интернет-магазине")').text()
    // if (furnituraDveri != '' || furnituraDveri2 != '') {
    //     $('main .row').find('.maincategories__wrap').append(maincategories__category_furnitura)
    // }



    $('.headerMenu>li').hover(function () {
        $(this).toggleClass('active');
    });

    $('.special').parent().parent().parent().addClass('special-mej-doors');
    $('.special').parent().parent().parent().removeClass('container');

    $('.special__form-close').click(function () {
        $('.special__form-wrap').removeClass('active');
    });
    $('.special__form-open').click(function () {
        $('.special__form-wrap').addClass('active');
    });

    $('.special-block-btn').click(function () {
        $('.special__form-wrap').addClass('active');
    });



    var header = $('.header__bottom-wrap'),
        scrollPrev = 0;

    $(window).scroll(function () {
        var scrolled = $(window).scrollTop();

        if (scrolled > 200) {
            header.addClass('scrolled');
        } else {
            header.removeClass('scrolled');
        }
        if (scrolled > 200 && scrolled > scrollPrev) {
            header.addClass('out');
        } else {
            header.removeClass('out');
        }
        scrollPrev = scrolled;
    });



});

document.addEventListener("DOMContentLoaded", () => {
    const scrollToTopBtn = document.getElementById("scrollToTopBtn");

    // Показываем кнопку при прокрутке вниз на 200 пикселей
    window.addEventListener("scroll", () => {
        if (window.scrollY > 200) {
            scrollToTopBtn.classList.add("visible");
        } else {
            scrollToTopBtn.classList.remove("visible");
        }
    });

    // Плавный скролл наверх при нажатии на кнопку
    scrollToTopBtn.addEventListener("click", () => {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    });

    $(document).ajaxStart(function () {
        $('.header__search').addClass('loading');
    }).ajaxStop(function () {
        $('.header__search').removeClass('loading');
    });
});



// КАТАЛОГ: скрытие верхнего текста под "Читать дальше..."
$(document).ready(function () {
    if ($(window).width() <= 768) {
        $('.ocf-description-top').each(function () {
            if (this.scrollHeight > $(this).innerHeight()) {
                const $btn = $('<span class="ocf-read-more-btn">Читать дальше...</span>');
                $(this).wrap('<div class="ocf-description-top-wrapper"></div>');
                $(this).after($btn);

                $btn.on('click', function () {
                    const $block = $(this).prev('.ocf-description-top');
                    $block.toggleClass('is-expanded');
                    $(this).text($block.hasClass('is-expanded') ? 'Свернуть' : 'Читать дальше...');
                });
            }
        });
    }
});
