Feature: Pruebas API PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def petId = 987654

  Scenario: Añadir una mascota a la tienda
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Bobby",
      "status": "available"
    }
    """
    When method post
    Then status 200
    And match response.name == "Bobby"

  Scenario: Consultar mascota por ID
    Given path '/pet', petId
    When method get
    Then status 200
    And match response.id == petId

  Scenario: Actualizar nombre y estatus a sold
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "Bobby Updated",
      "status": "sold"
    }
    """
    When method put
    Then status 200
    And match response.status == "sold"

  Scenario: Consultar mascota por estatus sold
    Given path '/pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
