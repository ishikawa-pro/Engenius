FROM ruby
MAINTAINER akira

RUN apt-get update -y &&\
    apt-get install -y postgresql libpq-dev node.js
RUN gem install pg &&\
    gem install rails

WORKDIR /usr/src/engenius
COPY ./engenius/Gemfile* ./
RUN bundle install
COPY ./engenius ./

ENTRYPOINT ["rails", "s", "-b", "0.0.0.0"]
