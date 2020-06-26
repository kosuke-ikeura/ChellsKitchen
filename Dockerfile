FROM ruby:2.5.1

# リポジトリを更新し依存モジュールをインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    vim \
    locales \
    locales-all \
    mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /chells-kitchen
WORKDIR /chells-kitchen

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /chells-kitchen/Gemfile
ADD Gemfile.lock /chells-kitchen/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /chells-kitchen

RUN yarn install --check-files

RUN export SECRET_KEY_BASE=`bundle exec rake secret`

RUN RAILS_ENV=production SECRET_KEY_BASE='bin/rake secret' bin/rails assets:precompile

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

