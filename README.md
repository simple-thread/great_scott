# Great Scott

A practical guide to timing attacks for the every day web dev.

## Guide

Read the full blog post that accompanies this repo here:
https://www.simplethread.com/great-scott-timing-attack-demo/

## Setup

```
docker build -t great_scott .
docker run -d -p 3000:3000 --name great_scott great_scott
docker exec -i -t great_scott /bin/bash
# Cleanup when done
docker stop great_scott && docker rm great_scott
```
Access web server on localhost:3000

---------------------------------------------------------------------------

OR install dependencies directly...

* Install ruby 2.5.1.  If using [rbenv](https://github.com/rbenv/rbenv) then `rbenv install 2.5.1`
* Install [bundler](https://bundler.io/). `gem install bundler`
* Install dependencies for this application: `bundle install`
* Run server and access it on localhost:3000
```
bundle exec rails s
```

###

Credentials to sign in as admin:
Username: admin@account.com
Password: Password123!

## Run Timing Attacks

These scripts are setup around the starting seed data:

```
bundle exec rake db:drop db:create db:migrate db:setup
```

```
bundle exec ruby hackz0r/basic_compare.rb
```

```
bundle exec ruby hackz0r/find_digits.rb
```

```
bundle exec ruby hackz0r/coup_de_grace.rb
```
