<?php
class ControllerProductCategoryDekorStenovyePaneli extends Controller {
    public function index() {
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('product/category_dekor_stenovye_paneli', $data));
    }
}