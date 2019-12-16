# Description
__Reflow__ is a project that allows you to upload and update contents to display on remote clients with the ability to change them in real time. Project uses [frest template](https://www.pixinvent.com/demo/frest-clean-bootstrap-admin-dashboard-template/html/ltr/vertical-menu-template/dashboard-ecommerce.html) as a front-end.

# Prerequisites
To run the project you'll need ruby version 2.6.5p, postgresql 12.1, nodejs 10.16.0 and Yarn 1.21.0 to be installed. It may work on older versions but it wasn't tested.

# Setup
To setup a project you need to run following commands:
```
git clone https://github.com/vikdotdev/remote-flow.git
cd remote-flow
bundle install
rails db:migrate
rails s
```
Running server should appear at `localhost:3000`.

To run tests use `rspec` command.

# Troubleshooting
You may encounter an error during migration `PG:UndefinedTable: ERROR: relation "devices" does not exist`, to fix that run following commands:
```
rails db:environment:set RAILS_ENV=development
rails db:reset
```

# Running specs in parallel

Create additional database(s):
```
rake parallel:create
```
Copy development schema (repeat after migrations):
```
rake parallel:prepare
```
Setup environment from scratch (create db and loads schema, useful for CI):
```
rake parallel:setup
```
Run
```
rake parallel:spec          # RSpec
```
