# Hello

------------------------------------------------

## Non auto-generated content

### After installing PostgreSQL

1. `sudo -i -u postgres` # Enter to terminal session as user `postgres`
1. `psql` # Enter to psql
1. `SELECT usename FROM pg_user;` # Check there is a user with username `postgres`
1. `ALTER USER postgres WITH PASSWORD 'postgres';` # Change postgres user password to `postgres`
1. `\q` # log out of psql
1. `exit` # Log out of the postgres terminal session

### Notes

#### controllers

1. Use action fallback to handle errors: https://hexdocs.pm/phoenix/controllers.html#action-fallback

#### Views

1. From: https://hexdocs.pm/phoenix/views.html

> LayoutView actually does the rendering. In fact, “templates” in Phoenix are really just function definitions on their view module.

> At compile-time, Phoenix precompiles all \*.html.eex templates and turns them into render/2 function clauses on their respective view modules. At runtime, all templates are already loaded in memory. There’s no disk reads, complex file caching, or template engine computation involved. This is also why we were able to define functions like title/0 in our LayoutView and they were immediately available inside the layout’s app.html.eex – the call to title/0 was just a local function call!

------------------------------------------------

## Auto-generated content

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
