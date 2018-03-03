FROM rails:latest
MAINTAINER akira

ENV RAILS_ENV=production RACK_ENV=production
WORKDIR /usr/src/engenius
COPY ./engenius/Gemfile* ./
RUN bundle install
COPY ./engenius ./

CMD ["./script/entrypoint.sh"]
