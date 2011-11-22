# Setup

* rails new <name>
* rails server
* show site -> http://localhost:3000
* follow instructions

# Git

git init
git add .
git commit -m "initial commit"

# Personalization for Me

add 'rspec-rails' to gemfile
rm -rf test/
rails generate rspec:install

# add a model
rails generate scaffold ratings summary:string rating:integer
comments:text name:string


# make it look pretty
add gem 'bootstrap-sass' to Gemfile
change application.css to 'require bootstrap'
add <div class="container"> to body


