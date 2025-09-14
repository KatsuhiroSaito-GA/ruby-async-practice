# Ruby Async Practice

Rubyでバックグラウンドジョブ処理をさまざまなアダプタで練習するためのプロジェクトです。

## プロジェクト構成

```
ruby-async-practice/
├── Gemfile                    # Gem依存関係
├── Gemfile.lock              # Gemロックファイル
├── compose.yml               # Docker Compose設定（Redis用）
└── sidekiq/
    ├── configuration.rb      # Sidekiq設定
    ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
    └── sample_job.rb         # Sidekiqジョブクラス定義
```

## 1. 環境構築

### 必要な環境
- Ruby 3.x
- Docker & Docker Compose
- Bundler

### セットアップ
#### Gemをインストール
```bash
# Gemをインストール
bundle install
```

#### Redisサーバーを立ち上げる

```bash
docker compose up
```

#### Sidekiqサーバーを立ち上げる

```bash
bundle exec sidekiq -r ./sidekiq/configuration.rb
```

## 5. ジョブをキューに追加する

```bash
bundle exec ruby sidekiq/enqueue_job.rb
```

## 停止方法

```bash
docker compose down
```

## tips
### Redis CLIを実行する
- 以下を実行することでRedis CLIを起動できます。実際にredisに保存されているデータを確認したり、操作したりできます。

```bash
# Docker ComposeのRedisコンテナに接続
docker compose exec redis redis-cli
```

```bash
# redisに保存されているデータを確認
keys *
```

```bash
# queueの一覧を確認（sidekiqの場合）
smembers queues
```
