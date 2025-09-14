require 'resque'
require_relative 'sample_job'

Resque.redis = 'redis://localhost:6379/1'

# このファイルが直接実行された場合のみワーカーを起動
if __FILE__ == $0
  worker = Resque::Worker.new('*')
  worker.work
end
