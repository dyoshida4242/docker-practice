FROM ruby:2.7.1

# rails6 からyarnが必要なのでインストール *****************
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs
# ****************************************************

# RUNはコマンド実行
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# コンテナ内のルート直下にappというディレクトリを作成
RUN mkdir /app
# 作成した、appを作業ディレクトリに指定
WORKDIR /app

# ホストのGemfileをコンテナ内のディレクトリにコピ-
COPY Gemfile /app/Gemfile
# Gemfile.lockも同様
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
# 全てのファイルをコンテナのディレクトリへコピーする
COPY . /app
