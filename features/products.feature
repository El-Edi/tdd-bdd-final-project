Feature: The product store service back-end
    As a Product Store Owner
    I need a RESTful catalog service
    So that I can keep track of all my products

Background:
    Given the following products
        | name       | description     | price   | available | category   |
        | Hat        | A red fedora    | 59.95   | True      | CLOTHS     |
        | Shoes      | Blue shoes      | 120.50  | False     | CLOTHS     |
        | Big Mac    | 1/4 lb burger   | 5.99    | True      | FOOD       |
        | Sheets     | Full bed sheets | 87.00   | True      | HOUSEWARES |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Product Catalog Administration" in the title
    And I should not see "404 Not Found"

Scenario: Create a Product
    When I visit the "Home Page"
    And I set the "Name" to "Hammer"
    And I set the "Description" to "Claw hammer"
    And I select "True" in the "Available" dropdown
    And I select "Tools" in the "Category" dropdown
    And I set the "Price" to "34.95"
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Clear" button
    Then the "Id" field should be empty
    And the "Name" field should be empty
    And the "Description" field should be empty
    When I paste the "Id" field
    And I press the "Retrieve" button
    Then I should see the message "Success"
    And I should see "Hammer" in the "Name" field
    And I should see "Claw hammer" in the "Description" field


    Scenario: Update a Product
    When I visit the "Home Page"
    And I set the "Name" to "Laptop"
    And I set the "Description" to "Gaming laptop"
    And I select "True" in the "Available" dropdown
    And I select "Electronics" in the "Category" dropdown
    And I set the "Price" to "1499.99"
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I set the "Name" to "Updated Laptop"
    And I set the "Description" to "Updated gaming laptop"
    And I set the "Price" to "1399.99"
    And I press the "Update" button
    Then I should see the message "Success"
    And I should see "Updated Laptop" in the "Name" field
    And I should see "1399.99" in the "Price" field

Scenario: Delete a Product
    When I visit the "Home Page"
    And I set the "Name" to "Mouse"
    And I set the "Description" to "Wireless mouse"
    And I select "True" in the "Available" dropdown
    And I select "Electronics" in the "Category" dropdown
    And I set the "Price" to "29.99"
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Delete" button
    Then I should see the message "Product has been Deleted!"

Scenario: List All Products
    When I visit the "Home Page"
    And I press the "List All" button
    Then I should see "Hat" in the results
    And I should see "Shoes" in the results
    And I should see "Big Mac" in the results
    And I should see "Sheets" in the results

Scenario: Search Products by Category
    When I visit the "Home Page"
    And I select "CLOTHS" in the "Category" dropdown
    And I press the "Search Category" button
    Then I should see "Hat" in the results
    And I should see "Shoes" in the results
    And I should not see "Big Mac" in the results

Scenario: Search Products by Availability
    When I visit the "Home Page"
    And I select "True" in the "Available" dropdown
    And I press the "Search Availability" button
    Then I should see "Hat" in the results
    And I should see "Big Mac" in the results
    And I should see "Sheets" in the results
    And I should not see "Shoes" in the results

Scenario: Search Products by Name
    When I visit the "Home Page"
    And I set the "Name" to "Shoes"
    And I press the "Search Name" button
    Then I should see "Shoes" in the results
    And I should not see "Hat" in the results

    And I should see "True" in the "Available" dropdown
    And I should see "Tools" in the "Category" dropdown
    And I should see "34.95" in the "Price" field
