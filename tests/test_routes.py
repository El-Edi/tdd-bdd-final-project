# ... [Cabecera del archivo sin cambios]

    #
    # ADD YOUR TEST CASES HERE
    #

    def test_get_product(self):
        """It should Get a single Product"""
        test_product = self._create_products(1)[0]
        response = self.client.get(f"{BASE_URL}/{test_product.id}")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertEqual(data["name"], test_product.name)

    def test_get_product_not_found(self):
        """It should not Get a Product thats not found"""
        response = self.client.get(f"{BASE_URL}/0")
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
        data = response.get_json()
        self.assertIn("was not found", data["message"])

    def test_update_product(self):
        """It should Update an existing Product"""
        test_product = self._create_products(1)[0]
        updated_product = test_product.serialize()
        updated_product["name"] = "Updated Name"
        response = self.client.put(f"{BASE_URL}/{test_product.id}", json=updated_product)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertEqual(data["name"], "Updated Name")

    def test_update_product_not_found(self):
        """It should not Update a Product that's not found"""
        updated_product = ProductFactory().serialize()
        response = self.client.put(f"{BASE_URL}/0", json=updated_product)
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

    def test_delete_product(self):
        """It should Delete a Product"""
        test_product = self._create_products(1)[0]
        response = self.client.delete(f"{BASE_URL}/{test_product.id}")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

    def test_delete_product_not_found(self):
        """It should not Delete a Product that's not found"""
        response = self.client.delete(f"{BASE_URL}/0")
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

    def test_list_all_products(self):
        """It should List all Products"""
        self._create_products(3)
        response = self.client.get(BASE_URL)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertGreaterEqual(len(data), 3)

    def test_query_product_by_name(self):
        """It should Find a Product by name"""
        test_product = self._create_products(1)[0]
        response = self.client.get(BASE_URL, query_string=f"name={test_product.name}")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertEqual(data[0]["name"], test_product.name)

    def test_query_product_by_category(self):
        """It should Find Products by category"""
        test_product = self._create_products(1)[0]
        response = self.client.get(BASE_URL, query_string=f"category={test_product.category.name}")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertTrue(any(p["id"] == test_product.id for p in data))

    def test_query_product_by_availability(self):
        """It should Find Products by availability"""
        test_product = self._create_products(1)[0]
        response = self.client.get(BASE_URL, query_string=f"available={test_product.available}")
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.get_json()
        self.assertTrue(any(p["id"] == test_product.id for p in data))
