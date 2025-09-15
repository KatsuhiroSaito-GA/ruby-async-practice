require 'resque'
require_relative 'sample_job'

Resque.redis = 'redis://localhost:6379/1'
