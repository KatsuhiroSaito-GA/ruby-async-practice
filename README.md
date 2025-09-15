# Ruby Async Practice

Rubyでバックグラウンドジョブ処理をSidekiq、Resque、ActiveJobを使って実行してみるためのプロジェクトです。

## プロジェクト構成

```
ruby-async-practice/
├── Gemfile                    # Gem依存関係
├── Gemfile.lock              # Gemロックファイル
├── compose.yml               # Docker Compose設定（Redis用）
├── sidekiq/
│   ├── configuration.rb      # Sidekiq設定
│   ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
│   └── sample_job.rb         # Sidekiqジョブクラス定義
└── resque/
    ├── configuration.rb      # Resque設定
    ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
    └── sample_job.rb         # Resqueジョブクラス定義
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

### Sidekiqを使ってジョブを実行する場合
#### Sidekiqサーバーを立ち上げる

```bash
bundle exec sidekiq -r ./sidekiq/configuration.rb
```

#### ジョブをキューに追加する

```bash
bundle exec ruby sidekiq/enqueue_job.rb
```

#### 動作確認
Sidekiqサーバー側で以下のような出力が表示されることを確認：

```
2025-09-15T03:15:03.112Z pid=18761 tid=cot class=Sidekiq::SampleJob jid=b3431057bb72e0fbe7ec137d INFO: start
{"name"=>"bar"}
2025-09-15T03:15:03.116Z pid=18761 tid=cot class=Sidekiq::SampleJob jid=b3431057bb72e0fbe7ec137d elapsed=0.004 INFO: done
```

### Resqueを使ってジョブを実行する場合
#### Resqueワーカーを立ち上げる

```bash
bundle exec ruby resque/configuration.rb
```

#### ジョブをキューに追加する

別のターミナルで以下を実行：

```bash
bundle exec ruby resque/enqueue_job.rb
```

#### 動作確認
ワーカー側で以下のような出力が表示されることを確認：

```
{"message"=>"Hello Resque!"}
```

## tips
### Redis CLIを実行する
以下を実行することでRedis CLIを起動できます。実際にredisに保存されているデータを確認したり、操作したりできます。

```bash
# Sidekiqの場合、データベース0に接続してキューを確認
docker compose exec redis redis-cli -n 0

# Resqueの場合、データベース1に接続してキューを確認
docker compose exec redis redis-cli -n 1
```

データベースに存在するすべてのキーの一覧を取得する。
```bash
keys *
```

queueの一覧を確認する
```bash
# Sidekiqの場合
smembers queues

# Resqueの場合
smembers resque:queues
```
