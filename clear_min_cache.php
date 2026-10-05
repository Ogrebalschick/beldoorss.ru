<?php
/**
 * Одноразовый сброс кэша minify (MoneyMaker 2) и storage OpenCart.
 * Залить в корень сайта (рядом с index.php) и открыть в браузере один раз.
 * После отчёта файл удаляет сам себя.
 */
header('Content-Type: text/plain; charset=utf-8');
header('X-Robots-Tag: noindex, nofollow');

$root = str_replace('\\', '/', rtrim(dirname(__FILE__), '/\\'));
$prod_root = '/home/b/beldoors90/beldoorss.ru/public_html';

$allowed_prefixes = array($root);
if (is_dir($prod_root)) {
    $allowed_prefixes[] = $prod_root;
}

function beldoorss_norm($path) {
    return rtrim(str_replace('\\', '/', $path), '/');
}

function beldoorss_is_allowed($dir, $allowed_prefixes) {
    $real = realpath($dir);
    if ($real === false) {
        return false;
    }
    $real = beldoorss_norm($real);
    foreach ($allowed_prefixes as $prefix) {
        $prefix = beldoorss_norm($prefix);
        if ($real === $prefix) {
            return false;
        }
        if (strpos($real . '/', $prefix . '/') === 0) {
            $rel = substr($real, strlen($prefix) + 1);
            if ($rel === 'min/cache'
                || $rel === 'storage_new.beldoorss.ru/cache'
                || $rel === 'storage_new.beldoorss.ru/modification'
                || $rel === 'system/storage/cache'
                || $rel === 'system/storage/modification'
            ) {
                return $real;
            }
        }
    }
    return false;
}

function beldoorss_wipe($dir, &$deleted, &$errors) {
    if (!is_dir($dir)) {
        return;
    }
    $items = @scandir($dir);
    if ($items === false) {
        $errors[] = 'Не удалось прочитать: ' . $dir;
        return;
    }
    foreach ($items as $item) {
        if ($item === '.' || $item === '..' || $item === 'index.html') {
            continue;
        }
        $path = $dir . DIRECTORY_SEPARATOR . $item;
        if (is_link($path)) {
            if (@unlink($path)) {
                $deleted++;
            } else {
                $errors[] = $path;
            }
            continue;
        }
        if (is_dir($path)) {
            beldoorss_wipe($path, $deleted, $errors);
            if (@rmdir($path)) {
                $deleted++;
            } else {
                $left = @scandir($path);
                if (is_array($left) && count($left) > 2) {
                    $errors[] = 'Папка не пуста: ' . $path;
                }
            }
            continue;
        }
        if (@unlink($path)) {
            $deleted++;
        } else {
            $errors[] = $path;
        }
    }
}

function beldoorss_clean_named($candidates, $allowed_prefixes, &$deleted, &$errors, &$report) {
    $seen = array();
    foreach ($candidates as $dir) {
        if (!is_dir($dir)) {
            $report[] = 'Пропуск (нет папки): ' . $dir;
            continue;
        }
        $safe = beldoorss_is_allowed($dir, $allowed_prefixes);
        if ($safe === false) {
            $report[] = 'Пропуск (путь не в белом списке): ' . $dir;
            continue;
        }
        if (isset($seen[$safe])) {
            continue;
        }
        $seen[$safe] = true;
        $before = $deleted;
        beldoorss_wipe($safe, $deleted, $errors);
        $report[] = 'Очищено: ' . $safe . ' (' . ($deleted - $before) . ')';
    }
}

$min_deleted = 0;
$storage_deleted = 0;
$errors = array();
$min_report = array();
$storage_report = array();

$min_dirs = array(
    $root . '/min/cache',
    $prod_root . '/min/cache',
);
beldoorss_clean_named($min_dirs, $allowed_prefixes, $min_deleted, $errors, $min_report);

$tmp = function_exists('sys_get_temp_dir') ? sys_get_temp_dir() : '/tmp';
$tmp = beldoorss_norm($tmp);
if (is_dir($tmp) && is_readable($tmp)) {
    $tmp_items = @scandir($tmp);
    if (is_array($tmp_items)) {
        foreach ($tmp_items as $item) {
            if ($item === '.' || $item === '..') {
                continue;
            }
            if (strpos($item, 'minify_') !== 0) {
                continue;
            }
            $path = $tmp . '/' . $item;
            if (is_file($path) && @unlink($path)) {
                $min_deleted++;
            }
        }
        $min_report[] = 'Очищены minify_* в системном temp: ' . $tmp;
    }
}

$storage_dirs = array(
    $root . '/storage_new.beldoorss.ru/cache',
    $root . '/storage_new.beldoorss.ru/modification',
    $root . '/system/storage/cache',
    $root . '/system/storage/modification',
    $prod_root . '/storage_new.beldoorss.ru/cache',
    $prod_root . '/storage_new.beldoorss.ru/modification',
);
beldoorss_clean_named($storage_dirs, $allowed_prefixes, $storage_deleted, $errors, $storage_report);

echo "Удалено файлов из min/cache: " . $min_deleted . "\n";
echo "Удалено файлов из storage: " . $storage_deleted . "\n\n";

echo "min/cache:\n" . implode("\n", $min_report) . "\n\n";
echo "storage:\n" . implode("\n", $storage_report) . "\n";

if ($errors) {
    echo "\nОшибки:\n" . implode("\n", $errors) . "\n";
}

echo "\nДальше в админке: Модули / Расширения → Модификаторы → синяя кнопка «Обновить».\n";
echo "Без этого тема останется без OCMOD-стилей MoneyMaker 2.\n";

$self = __FILE__;
if (@unlink($self)) {
    echo "\nСкрипт удалён: " . $self . "\n";
} else {
    echo "\nНе удалось самоудалиться. Удалите файл вручную: " . $self . "\n";
}
