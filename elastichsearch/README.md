# ElasticSearch (ES) tutorial

This Maven project contains a basic ElasticSearch CRUD using the Java driver.<br>
In the `test` folder you can find unit tests and integration tests (tests that go to ES).

## Dependencies

In order to run the integration tests **please install ES in your localhost**.<br>
You can follow this guide to do it: https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html

## Installation

1. In a terminal run: `mvn install`

## Testing

1. Run ES in your localhost
2. In a terminal run: `mvn test`

## Project structure

### Source Code

in the package `co.je.tutorials.es.movies` you will find the following classes:

1. Movie: defines the Movie object.
1. MovieController: has a MoviePersistence object as field.
1. MoviePersistence: handles the interaction with ES.

### Tests

In the `test` folder you will find the following classes:

1. MovieFactory: used to created Movie objects used in the tests.
1. MovieControllerTest: contains unit tests.
1. MoviePersistenceTest: containts integration tests with ES.
