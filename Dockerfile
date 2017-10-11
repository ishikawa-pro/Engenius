FROM rails:latest
MAINTAINER akira

WORKDIR /usr/src/engenius
COPY ./engenius/Gemfile* ./
RUN bundle install
COPY ./engenius/* /usr/src/engenius/
COPY ./script/entrypoint.sh /usr/src/engenius/

ENTRYPOINT ["./script/entrypoint.sh"]
