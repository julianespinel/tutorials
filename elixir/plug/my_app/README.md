# MyApp

Plug tutorial: https://hexdocs.pm/plug/readme.html

## Code structure

All the source files are in lib/<br>
All the test files are in tests/

### lib

We find 2 files in the lib folder:

1. `my_app.ex`<br>
Starts a supervisor with a router as a child to be supervised.
1. `my_routes.ex`<br>
Defines the routes supported and the response for each route.

### test

We find 2 files in the tests folder:

1. `my_app_test.exs`<br>
Test the routes and the response for each route.
1. `test_helper.exs`<br>
Contains the code common to all tests. [ExUnit and Mix](http://elixir-lang.org/docs/stable/ex_unit/ExUnit.html#module-integration-with-mix)

## How to run?

Please follow this steps:

1. `git clone https://github.com/julianespinel/tutorials.git`
1. `cd tutorials/elixir/plug/my_app`
1. `mix run --no-halt`

Open a new browser and go to: [http://localhost:4001/hello](http://localhost:4001/hello)

You should see: `world` in your browser.

# Testing

Run the tests with: `mix test`
