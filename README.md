# Ruby Async Practice

Rubyでバックグラウンドジョブ処理をSidekiq、Resque、ActiveJobを使って実行してみるためのプロジェクトです。

## プロジェクト構成

```
ruby-async-practice/
├── Gemfile                   # Gem依存関係
├── Gemfile.lock              # Gemロックファイル
├── compose.yml               # Docker Compose設定（Redis用）
├── sidekiq/
│   ├── configuration.rb      # Sidekiq設定
│   ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
│   └── sample_job.rb         # Sidekiqジョブクラス定義
├── resque/
│   ├── configuration.rb      # Resque設定
│   ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
│   └── sample_job.rb         # Resqueジョブクラス定義
└── activejob/
    ├── configuration.rb      # ActiveJob設定（Sidekiqアダプター使用）
    ├── enqueue_job.rb        # ジョブをキューに追加するスクリプト
    └── sample_job.rb         # ActiveJobジョブクラス定義
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
2025-09-15T05:34:43.411Z pid=28080 tid=k5w class=SidekiqPractice::SampleJob jid=6e5fac0666f80c2afbbd2566 INFO: start
{"message"=>"Hello Sidekiq!"}
2025-09-15T05:34:43.415Z pid=28080 tid=k5w class=SidekiqPractice::SampleJob jid=6e5fac0666f80c2afbbd2566 elapsed=0.004 INFO: done
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

### ActiveJobを使ってジョブを実行する場合
現在はActiveJobのアダプターとしてSidekiqを使うように指定しています。

#### Sidekiqワーカーを立ち上げる
```bash
bundle exec sidekiq -r ./activejob/configuration.rb
```

#### ジョブをキューに追加する
別のターミナルで以下を実行：

```bash
bundle exec ruby activejob/enqueue_job.rb
```

#### 動作確認
ワーカー側で以下のような出力が表示されることを確認：

```
2025-09-15T05:39:30.618Z pid=28318 tid=k1q class=ActiveJobPractice::SampleJob jid=7eab37a6629fdf7693f90e67 INFO: start
[ActiveJob] [ActiveJobPractice::SampleJob] [4a959905-7c0c-4705-ba74-89c4a751af09] Performing ActiveJobPractice::SampleJob (Job ID: 4a959905-7c0c-4705-ba74-89c4a751af09) from Sidekiq(default) enqueued at 2025-09-15T05:39:30.610898000Z with arguments: {"message"=>"Hello ActiveJob!"}
{"message"=>"Hello ActiveJob!"}
[ActiveJob] [ActiveJobPractice::SampleJob] [4a959905-7c0c-4705-ba74-89c4a751af09] Performed ActiveJobPractice::SampleJob (Job ID: 4a959905-7c0c-4705-ba74-89c4a751af09) from Sidekiq(default) in 12.21ms
2025-09-15T05:39:30.632Z pid=28318 tid=k1q class=ActiveJobPractice::SampleJob jid=7eab37a6629fdf7693f90e67 elapsed=0.013 INFO: done
```

#### Resqueアダプターに変更する場合

`activejob/configuration.rb`の以下の箇所を変更：

```ruby
# 2行目を変更
require_relative '../resque/configuration'  # sidekiq -> resque

# 6行目を変更
ActiveJob::Base.queue_adapter = :resque     # :sidekiq -> :resque
```

##### Resqueワーカーを立ち上げる

```bash
bundle exec ruby resque/configuration.rb
```

##### ジョブをキューに追加する

別のターミナルで以下を実行：

```bash
bundle exec ruby activejob/enqueue_job.rb
```

##### 動作確認

ワーカー側で以下のような出力が表示されることを確認：

```
[ActiveJob] [SampleJob] [job-id] Performing SampleJob from Resque(default) with arguments: {"company"=>"ga technologies"}
{"company"=>"ga technologies"}
[ActiveJob] [SampleJob] [job-id] Performed SampleJob from Resque(default) in XXms
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
