# Great Scott

A practical guide to timing attacks for the every day web dev.

# Guide

Read the full blog post that accompanies this repo here: 

### App Setup

* Install ruby 2.5.1.  If using [rbenv](https://github.com/rbenv/rbenv) then `rbenv install 2.5.1`
* Install [bundler](https://bundler.io/). `gem install bundler`
* Install dependencies for this application: `bundle install`
* Install Google Chrome which is used in the system tests


### Run Local Server

Create database and load demo data...
```
bundle exec rake db:drop db:create db:migrate db:setup
```

Run server and access it on localhost:3000

```
bundle exec rails s
```

### Run Timing Attack Hacks

```
ruby hackz0r/basic_compare.rb
```

```
ruby hackz0r/find_digits.rb
```

```
ruby hackz0r/coup_de_grace.rb
```

Note these are setup around the demo data first seeded in `db:setup`.
