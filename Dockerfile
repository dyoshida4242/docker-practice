FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# コンテナ内のルート直下にdocker-practiceというディレクトリを作成
RUN mkdir /docker-practice
# 作成した、docker-practiceを作業ディレクトリに指定
WORKDIR /docker-practice

# ホストのGemfileをコンテナ内のディレクトリにコピ-
COPY Gemfile /docker-practice/Gemfile
# Gemfile.lockも同様
COPY Gemfile.lock /docker-practice/Gemfile.lock

RUN bundle install
# 全てのファイルをコンテナのディレクトリへコピーする
COPY . /docker-practice
