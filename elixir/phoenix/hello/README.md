# Hello

------------------------------------------------
After installing PostgreSQL

1. `sudo -i -u postgres` # Enter to terminal session as user `postgres`
1. `psql` # Enter to psql
1. `SELECT usename FROM pg_user;` # Check there is a user with username `postgres`
1. `ALTER USER postgres WITH PASSWORD 'postgres';` # Change postgres user password to `postgres`
1. `\q` # log out of psql
1. `exit` # Log out of the postgres terminal session
------------------------------------------------

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
