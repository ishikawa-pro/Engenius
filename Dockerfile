FROM rails:latest
MAINTAINER akira

WORKDIR /usr/src/engenius
COPY ./engenius/Gemfile* ./
RUN bundle install
COPY ./engenius ./

ENTRYPOINT ["./script/entrypoint.sh"]
