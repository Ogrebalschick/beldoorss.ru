<?
$firstName = $_POST['firstName'];
$phone = $_POST['phone'];
$mail = $_POST['mail'];
$country = $_POST['country'];
if (mail("beldoorss@mail.ru",
        "Новое письмо с сайта",
        "Имя: " . $firstName . "\n" . "Телефон: " . $phone . "\n" . 'Почта: ' . $mail . "\n" . 'Страна: ' . $country,
        "From: no-reply@mydomain.ru \r\n")
    ) {
        header("Location: /spasibo-za-zayavku");
    } else {
        echo "Есть ошибки";
    };