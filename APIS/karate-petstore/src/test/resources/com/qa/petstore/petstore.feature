Feature: PetStore API - Pruebas parametrizadas con CSV y JSON

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario Outline: Flujo completo de mascota usando datos externos
    * def petId = <petId>
    * def petName = '<petName>'
    * def updatedName = '<updatedName>'

    Given path 'pet'
    And request read('classpath:data/pet-create.json')
    When method post
    Then status 200

    Given path 'pet', petId
    When method get
    Then status 200
    And match response.name == petName

    Given path 'pet'
    And request read('classpath:data/pet-update.json')
    When method put
    Then status 200
    And match response.status == 'sold'

    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response[*].status contains 'sold'

    Examples:
      | read('classpath:data/pets.csv') |
