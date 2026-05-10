<?php
class ModelToolImage extends Model {
	public function resize($filename, $width, $height) {
		if (!is_file(DIR_IMAGE . $filename) || substr(str_replace('\\', '/', realpath(DIR_IMAGE . $filename)), 0, strlen(DIR_IMAGE)) != DIR_IMAGE) {
			return;
		}

		$extension = strtolower(pathinfo($filename, PATHINFO_EXTENSION));

		// SVG в витрине: без ресайза GD
		if ($extension == 'svg') {
			$image_new = str_replace(' ', '%20', $filename);
			if (!empty($this->request->server['HTTPS'])) {
				return $this->config->get('config_ssl') . 'image/' . $image_new;
			}
			return $this->config->get('config_url') . 'image/' . $image_new;
		}

		$image_old = $filename;
		$webp_supported = function_exists('imagewebp') && function_exists('imagecreatefromwebp');
		$try_webp = $webp_supported;

		while (true) {
			$cache_extension = $try_webp ? 'webp' : $extension;
			$image_new = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . (int) $width . 'x' . (int) $height . '.' . $cache_extension;

			if (!is_file(DIR_IMAGE . $image_new) || (filectime(DIR_IMAGE . $image_old) > filectime(DIR_IMAGE . $image_new))) {
				$image_info = @getimagesize(DIR_IMAGE . $image_old);
				if ($image_info === false) {
					return;
				}

				list($width_orig, $height_orig, $image_type) = $image_info;

				$allowed = array(IMAGETYPE_PNG, IMAGETYPE_JPEG, IMAGETYPE_GIF);
				if (defined('IMAGETYPE_WEBP') && function_exists('imagecreatefromwebp')) {
					$allowed[] = IMAGETYPE_WEBP;
				}

				if (!in_array($image_type, $allowed)) {
					return;
				}

				$path = '';

				$directories = explode('/', dirname($image_new));

				foreach ($directories as $directory) {
					$path = $path . '/' . $directory;

					if (!is_dir(DIR_IMAGE . $path)) {
						@mkdir(DIR_IMAGE . $path, 0777);
					}
				}

				if ($width_orig != $width || $height_orig != $height) {
					$image = new Image(DIR_IMAGE . $image_old);
					$image->resize($width, $height);
					if ($try_webp) {
						$image->save(DIR_IMAGE . $image_new, 85);
					} else {
						$image->save(DIR_IMAGE . $image_new);
					}
				} else {
					if ($try_webp && $extension === 'webp') {
						copy(DIR_IMAGE . $image_old, DIR_IMAGE . $image_new);
					} elseif ($try_webp) {
						$image = new Image(DIR_IMAGE . $image_old);
						$image->save(DIR_IMAGE . $image_new, 85);
					} else {
						copy(DIR_IMAGE . $image_old, DIR_IMAGE . $image_new);
					}
				}
			}

			if ($try_webp && $webp_supported && (!is_file(DIR_IMAGE . $image_new) || filesize(DIR_IMAGE . $image_new) < 50)) {
				if (is_file(DIR_IMAGE . $image_new)) {
					@unlink(DIR_IMAGE . $image_new);
				}
				$try_webp = false;
				continue;
			}

			break;
		}

		$image_new = str_replace(' ', '%20', $image_new);

		if (!empty($this->request->server['HTTPS'])) {
			return $this->config->get('config_ssl') . 'image/' . $image_new;
		} else {
			return $this->config->get('config_url') . 'image/' . $image_new;
		}
	}
}
