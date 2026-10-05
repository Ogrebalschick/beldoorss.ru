<?php
/**
 * Поиск beldoorss.local в текстовых полях БД OpenCart.
 * Залить в корень сайта, открыть один раз, скопировать отчёт.
 * UPDATE сам не выполняет. После отчёта удаляет себя.
 */
header('Content-Type: text/plain; charset=utf-8');
header('X-Robots-Tag: noindex, nofollow');

require dirname(__FILE__) . '/config.php';

$needle = 'beldoorss.local';
$mysqli = @new mysqli(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, (int) DB_PORT);
if ($mysqli->connect_error) {
    echo 'DB connect error: ' . $mysqli->connect_error . "\n";
    exit(1);
}
$mysqli->set_charset('utf8');
$prefix = DB_PREFIX;
$db = $mysqli->real_escape_string(DB_DATABASE);

echo "=== oc_setting: value LIKE '%local%' ===\n\n";
$sql = "SELECT `setting_id`, `store_id`, `code`, `key`, `serialized`, `value`
FROM `" . $prefix . "setting`
WHERE `value` LIKE '%local%'
ORDER BY `key`";
$res = $mysqli->query($sql);
if (!$res) {
    echo 'SELECT error: ' . $mysqli->error . "\n";
} else {
    $n = 0;
    while ($row = $res->fetch_assoc()) {
        $n++;
        $val = $row['value'];
        if (strlen($val) > 400) {
            $val = substr($val, 0, 400) . '…';
        }
        echo 'setting_id=' . $row['setting_id']
            . ' store_id=' . $row['store_id']
            . ' code=' . $row['code']
            . ' key=' . $row['key']
            . ' serialized=' . $row['serialized']
            . "\n  value=" . str_replace(array("\r", "\n"), ' ', $val) . "\n\n";
    }
    echo "Строк: " . $n . "\n";
}

echo "\n=== Готовый UPDATE для config_url / config_ssl ===\n\n";
echo "UPDATE `" . $prefix . "setting`\n"
    . "SET `value` = 'https://beldoorss.ru/'\n"
    . "WHERE `store_id` = 0\n"
    . "  AND `key` IN ('config_url', 'config_ssl');\n";

echo "\n=== Поиск '" . $needle . "' по текстовым таблицам ===\n\n";

$skip_tables = array(
    $prefix . 'session',
    $prefix . 'api_session',
    $prefix . 'customer_search',
);

$col_sql = "SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLUMN_KEY
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = '" . $db . "'
  AND TABLE_NAME LIKE '" . $mysqli->real_escape_string($prefix) . "%'
  AND DATA_TYPE IN ('char','varchar','tinytext','text','mediumtext','longtext','blob','tinyblob','mediumblob','longblob')
ORDER BY TABLE_NAME, ORDINAL_POSITION";
$cols = $mysqli->query($col_sql);
if (!$cols) {
    echo 'information_schema error: ' . $mysqli->error . "\n";
    $mysqli->close();
    exit(1);
}

$by_table = array();
$pk_by_table = array();
while ($c = $cols->fetch_assoc()) {
    $table = $c['TABLE_NAME'];
    if (in_array($table, $skip_tables, true)) {
        continue;
    }
    $by_table[$table][] = $c['COLUMN_NAME'];
}

$pk_sql = "SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = '" . $db . "'
  AND CONSTRAINT_NAME = 'PRIMARY'
ORDER BY TABLE_NAME, ORDINAL_POSITION";
$pks = $mysqli->query($pk_sql);
if ($pks) {
    while ($p = $pks->fetch_assoc()) {
        $pk_by_table[$p['TABLE_NAME']][] = $p['COLUMN_NAME'];
    }
}

$hits = 0;
$like = $mysqli->real_escape_string('%' . $needle . '%');

foreach ($by_table as $table => $columns) {
    $wheres = array();
    foreach ($columns as $col) {
        $wheres[] = '`' . $mysqli->real_escape_string($col) . "` LIKE '" . $like . "'";
    }
    $pk = isset($pk_by_table[$table]) ? $pk_by_table[$table] : array();
    $select_cols = $pk;
    foreach ($columns as $col) {
        if (!in_array($col, $select_cols, true)) {
            $select_cols[] = $col;
        }
    }
    $select_sql = array();
    foreach ($select_cols as $col) {
        $select_sql[] = '`' . $mysqli->real_escape_string($col) . '`';
    }
    $q = 'SELECT ' . implode(', ', $select_sql)
        . ' FROM `' . $mysqli->real_escape_string($table) . '`'
        . ' WHERE ' . implode(' OR ', $wheres)
        . ' LIMIT 50';
    $r = $mysqli->query($q);
    if (!$r) {
        continue;
    }
    while ($row = $r->fetch_assoc()) {
        foreach ($columns as $col) {
            if (!isset($row[$col]) || strpos($row[$col], $needle) === false) {
                continue;
            }
            $hits++;
            $id = array();
            foreach ($pk as $pkcol) {
                if (isset($row[$pkcol])) {
                    $id[] = $pkcol . '=' . $row[$pkcol];
                }
            }
            $snippet = $row[$col];
            if (strlen($snippet) > 240) {
                $pos = strpos($snippet, $needle);
                $start = max(0, $pos - 40);
                $snippet = ($start ? '…' : '') . substr($snippet, $start, 240) . '…';
            }
            echo $table . '.' . $col
                . ($id ? ' (' . implode(', ', $id) . ')' : '')
                . "\n  " . str_replace(array("\r", "\n"), ' ', $snippet) . "\n\n";
        }
    }
}

echo "Совпадений beldoorss.local: " . $hits . "\n";

echo "\n=== Если local застрял не только в config_url/ssl (JSON/текст, не PHP serialize) ===\n\n";
echo "UPDATE `" . $prefix . "setting`\n"
    . "SET `value` = REPLACE(REPLACE(`value`, 'http://beldoorss.local/', 'https://beldoorss.ru/'), 'https://beldoorss.local/', 'https://beldoorss.ru/')\n"
    . "WHERE `value` LIKE '%beldoorss.local%';\n\n";
echo "UPDATE `" . $prefix . "module`\n"
    . "SET `setting` = REPLACE(REPLACE(`setting`, 'http://beldoorss.local/', 'https://beldoorss.ru/'), 'https://beldoorss.local/', 'https://beldoorss.ru/')\n"
    . "WHERE `setting` LIKE '%beldoorss.local%';\n\n";
echo "UPDATE `" . $prefix . "banner_image`\n"
    . "SET `link` = REPLACE(REPLACE(`link`, 'http://beldoorss.local/', 'https://beldoorss.ru/'), 'https://beldoorss.local/', 'https://beldoorss.ru/')\n"
    . "WHERE `link` LIKE '%beldoorss.local%';\n\n";
echo "UPDATE `" . $prefix . "store`\n"
    . "SET `url` = 'https://beldoorss.ru/', `ssl` = 'https://beldoorss.ru/'\n"
    . "WHERE `url` LIKE '%beldoorss.local%' OR `ssl` LIKE '%beldoorss.local%';\n";

$mysqli->close();

echo "\nПосле UPDATE в админке: Модификаторы → Обновить, затем очистить кэш.\n";

$self = __FILE__;
if (@unlink($self)) {
    echo "\nСкрипт удалён: " . $self . "\n";
} else {
    echo "\nУдалите файл вручную: " . $self . "\n";
}
