<?php

require DIR_SYSTEM . "library/elFinder/autoload.php";

class ControllerExtensionModuleFileManager extends Controller
{

    public function index()
    {
        $this->load->language("extension/module/file_manager");
        $this->document->setTitle($this->language->get('heading_title2'));


        $data['breadcrumbs']    = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title2'),
            'href' => $this->url->link('extension/module/file_manager', 'token=' . $this->session->data['token'], true),
        );

        $data['token'] = $this->session->data['token'];

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $data['heading_title']  = $this->language->get('heading_title2');
        $data['text_edit']  = $this->language->get('text_edit');

        $this->response->setOutput($this->load->view("extension/module/file_manager", $data));
    }

    public function connector()
    {
        if ($this->request->server['HTTPS']) {
            $server = HTTPS_CATALOG;
        } else {
            $server = HTTP_CATALOG;
        }

        // Documentation for connector options:
        // https://github.com/Studio-42/elFinder/wiki/Connector-configuration-options
        $opts = array(
            // 'debug' => true,
            'roots' => array(
                // Items volume
                array(
                    'driver' => 'LocalFileSystem', // driver for accessing file system (REQUIRED)
                    /* 'path' => DIR_IMAGE . "catalog/", // path to files (REQUIRED) */
                    'path' => DIR_APPLICATION . '../', // path to files (REQUIRED)
                    /* 'URL' => $server . "image/catalog/", // URL to files (REQUIRED) */
                    'URL' => $server, // URL to files (REQUIRED)
                    'tmbPath' => DIR_IMAGE . "catalog/thumbnail",
                    'tmbURL' => $server . "image/catalog/thumbnail/",
                    'trashHash' => 't1_Lw', // elFinder's hash of trash folder
                    'winHashFix' => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
                    'uploadDeny' => array('all'), // All Mimetypes not allowed to upload
                    'uploadAllow' => array('image/x-ms-bmp', 'image/gif', 'image/jpeg', 'image/png', 'image/x-icon', 'text/plain', 'application/x-javascript', 'text/javascript', 'text/css', 'text/html', 'application/vnd.groove-tool-template', 'text/x-php', 'text/troff', 'application/x-zip-compressed', 'application/zip', 'application/x-sql', 'text/x-sql', 'text/x-Algol68', 'text/x-c++', 'text/xml', 'application/xml', 'image/svg+xml'), // Mimetype `image` and `text/plain` allowed to upload 
                    // SV добавил php, js, css, html, troff-(это css), application/x-zip-compressed, application/zip, application/x-sql, text/x-sql, text/x-Algol68-(это sql), application/vnd.groove-tool-template(это .tpl).
                    'uploadOrder' => array('deny', 'allow'), // allowed Mimetype `image` and `text/plain` only
                    'accessControl' => 'access', // disable and hide dot starting files (OPTIONAL)
                ),
                // Trash volume application/x-sql
                array(
                    'id' => '1',
                    'driver' => 'Trash',
                    'path' => DIR_IMAGE . "trash/",
                    'URL' => $server . "image/trash",
                    'tmbPath' => DIR_IMAGE . "trash/.thumb",
                    'tmbURL' => $server . "image/trash/.thumb",
                    'winHashFix' => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
                    'uploadDeny' => array('all'), // Recomend the same settings as the original volume that uses the trash
                    'uploadAllow' => array('image/x-ms-bmp', 'image/gif', 'image/jpeg', 'image/png', 'image/x-icon', 'text/plain', 'application/x-javascript', 'text/javascript', 'text/css', 'text/html', 'application/vnd.groove-tool-template', 'text/x-php', 'text/troff', 'application/x-zip-compressed', 'application/zip', 'application/x-sql', 'text/x-sql', 'text/x-Algol68', 'text/x-c++', 'text/xml', 'application/xml', 'image/svg+xml'), // Mimetype `image` and `text/plain` allowed to upload 
                    // SV добавил php, js, css, html, troff-(это css), application/x-zip-compressed, application/zip, application/x-sql, text/x-sql, text/x-Algol68-(это sql), application/vnd.groove-tool-template(это .tpl).
                    'uploadOrder' => array('deny', 'allow'), // Same as above
                    'accessControl' => 'access', // Same as above
                )
            ),
        );

        // run elFinder
        $connector = new elFinderConnector(new elFinder($opts));
        $connector->run();

    }
}