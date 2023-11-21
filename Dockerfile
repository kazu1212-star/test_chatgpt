FROM node:20.9.0 as node
FROM ruby:3.0.5

COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

# Rails
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    default-mysql-client

WORKDIR /rails-docker-mysql

COPY Gemfile Gemfile.lock /rails-docker-mysql/
RUN bundle install

COPY entrypoint.sh /rails-docker-mysql/entrypoint.sh
RUN chmod +x /rails-docker-mysql/entrypoint.sh
ENTRYPOINT ["/rails-docker-mysql/entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]