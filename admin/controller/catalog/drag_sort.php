<?php
class ControllerCatalogDragSort extends Controller {

    public function updateSort() {
        $json = array();

        $this->load->model('catalog/drag_sort');

        if (isset($this->request->post['attribute_sort']) && $this->request->post['attribute_sort']) {
            $this->model_catalog_drag_sort->updateAttributeSort($this->request->post['attribute_sort']);
        }

        if (isset($this->request->post['attribute_group_sort']) && $this->request->post['attribute_group_sort']) {
            $this->model_catalog_drag_sort->updateAttributeGroupSort($this->request->post['attribute_group_sort']);
        }

        if (isset($this->request->post['manufacturer_sort']) && $this->request->post['manufacturer_sort']) {
            $this->model_catalog_drag_sort->updateManufacturerSort($this->request->post['manufacturer_sort']);
        }

        if (isset($this->request->post['product_sort']) && $this->request->post['product_sort']) {
            $this->model_catalog_drag_sort->updateProductSort($this->request->post['product_sort']);
        }

        if (isset($this->request->post['option_sort']) && $this->request->post['option_sort']) {
            $this->model_catalog_drag_sort->updateOptionSort($this->request->post['option_sort']);
        }

        if (isset($this->request->post['information_sort']) && $this->request->post['information_sort']) {
            $this->model_catalog_drag_sort->updateInformationSort($this->request->post['information_sort']);
        }

        if (isset($this->request->post['category_sort']) && $this->request->post['category_sort']) {
            $this->model_catalog_drag_sort->updateCategorySort($this->request->post['category_sort']);
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function makeOrder() {
        $json = array();

        if (isset($this->request->post['order']) && $this->request->post['order']) {
            $this->load->model('catalog/drag_sort');

            if ($this->request->post['order'] == 'products') {
                $this->model_catalog_drag_sort->makeOrderInProducts();
            }

            if ($this->request->post['order'] == 'manufacturers') {
                $this->model_catalog_drag_sort->makeOrderInManufacturers();
            }

            if ($this->request->post['order'] == 'attributes') {
                $this->model_catalog_drag_sort->makeOrderInAttributes();
            }

            if ($this->request->post['order'] == 'attribute_groups') {
                $this->model_catalog_drag_sort->makeOrderInAttributeGroups();
            }

            if ($this->request->post['order'] == 'options') {
                $this->model_catalog_drag_sort->makeOrderInOptions();
            }

            if ($this->request->post['order'] == 'informations') {
                $this->model_catalog_drag_sort->makeOrderInInformations();
            }

            if ($this->request->post['order'] == 'categories' && isset($this->request->post['category_id'])) {
                $this->model_catalog_drag_sort->makeOrderInCategories($this->request->post['category_id']);

                $json['asd'] = $this->request->post;
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
