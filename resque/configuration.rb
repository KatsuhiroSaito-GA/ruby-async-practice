require 'resque'
require_relative 'sample_job'

Resque.redis = 'redis://redis:6379/1'
