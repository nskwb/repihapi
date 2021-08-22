FROM ruby:3.0.0

RUN apt-get update -qq && \
  apt-get install -y nodejs

RUN apt-get update --allow-releaseinfo-change && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
  apt-get install -y nodejs imagemagick

WORKDIR /repihapi
COPY . /repihapi

RUN bundle config --local set path 'vendor/bundle' && \
  bundle install

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]
