# README

1. Install Ruby, Rails, Redis, Mysql Server
- Ruby 2.5.1
- Rails 5.2.x
- mysql 5.7.x

2. Clone project
```
git clone git@github.com:value-application/kindy-rw-back.git
```

3. Setting project

```
# Setting database.yml
cp config/database.yml.example config/database.yml

# Settings application.yml
cp config/application.yml.example config/application.yml
```

Edit database.yml, application.yml

4. Create database

```
rails db:create db:migrate db:seed
```

### Using docker environment

1. Docker environment setup
```
# If you have already installed docker, following commands boot rails server.
docker-compose run —rm app bundle
docker-compose run —rm app rails db:setup
docker-compose up -d
```

2. Use letter_opener_web on docker environment

`letter_opener` open browser tab when received a mail. But it work only on local machine, not on docker environment.
So use `letter_opener_web` instead of `letter_opener` if you use docker to develop. You can access mail inbox at http://localhost:3000/letter_opener
