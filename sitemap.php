<?php
/**
 * Прокси для XML-карты сайта: обходит ограничения Nginx (физический файл).
 * Контент берётся из стандартного фида OpenCart 2.3.
 */

$scheme = 'http';
if (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') {
	$scheme = 'https';
}
if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])) {
	$scheme = strtolower((string) $_SERVER['HTTP_X_FORWARDED_PROTO']);
}

$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : 'localhost';
$dir = isset($_SERVER['SCRIPT_NAME']) ? dirname($_SERVER['SCRIPT_NAME']) : '';
$dir = str_replace('\\', '/', $dir);
if ($dir === '/' || $dir === '.') {
	$dir = '';
}

$url = $scheme . '://' . $host . $dir . '/index.php?route=extension/feed/google_sitemap';

$body = false;
$httpCode = 0;

if (function_exists('curl_init')) {
	$ch = curl_init($url);
	curl_setopt_array($ch, array(
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_TIMEOUT        => 120,
		CURLOPT_HTTPHEADER     => array('Accept: application/xml, text/xml;q=0.9, */*;q=0.8'),
	));
	if (defined('CURLOPT_SSL_VERIFYPEER')) {
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
	}
	$body = curl_exec($ch);
	if ($body !== false) {
		$httpCode = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
	}
	curl_close($ch);
}

if ($body === false && ini_get('allow_url_fopen')) {
	$ctx = stream_context_create(array(
		'http' => array(
			'timeout' => 120,
			'header'  => "Accept: application/xml, text/xml\r\n",
		),
		'ssl' => array(
			'verify_peer'      => true,
			'verify_peer_name' => true,
		),
	));
	$body = @file_get_contents($url, false, $ctx);
	if ($body !== false && isset($http_response_header[0])) {
		if (preg_match('/\s(\d{3})\s/', $http_response_header[0], $m)) {
			$httpCode = (int) $m[1];
		}
	}
}

if ($body === false) {
	header('HTTP/1.1 503 Service Unavailable');
	header('Content-Type: text/plain; charset=UTF-8');
	echo 'Sitemap temporarily unavailable.';
	exit;
}

if ($httpCode === 0) {
	$httpCode = 200;
}

if ($httpCode >= 400) {
	header('HTTP/1.1 ' . ($httpCode === 404 ? '404 Not Found' : '503 Service Unavailable'));
	header('Content-Type: text/plain; charset=UTF-8');
	exit;
}

header('Content-Type: text/xml; charset=UTF-8');
echo $body;
