# MatthewApi

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix



  === docker command:

  0) docker pull postgres
  1)  running a DB (postgres)
    docker run --name [db name] -p 5432:5432 -e POSTGRES_USER=[user_name] -e POSTGRES_PASSWORD=[password] -d postgres

  2) docker inspect [db name] 
    - to show information on the db


  === mix commands for phx framework 

  1) mix local.hex
    - install hex the deps manager locally

  2) mix archive.install hex phx_new
    - install phoenix framework
    
  3) mix phx.new name_of_our_project 
    - like mix new; to create a new phoenix project
    - arguments to only include dependencies for API development only:
        i. --no-install (stops hex from automatically installing all the dependencies)
        ii. --app name_of_our_app (app name; usually same as project name)
        iii. --database postgres (database of our app)
        iv. --no-live (comment out liveview socket setup and assets directory)
        v. --no-assets (no assets folder e.g. js files)
        vi. --no-html (not generate html views)
        vii. --no-dashboard (no phoenix live dashboard)
        viii. --no-mailer (no swoosh mailer files)
        ix. --binary-id (choose binary id over integer id for the database)
        
   4) mix deps.get - remember to get the dependencies after generating the app   4) mix deps.get - remember to get the dependencies after generating the app  4) mix deps.get - remember to get the dependencies after generating the app   4) mix deps.get - remember to get the dependencies after generating the app
        

