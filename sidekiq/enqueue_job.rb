require_relative 'configuration'

Sidekiq::SampleJob.perform_async({ 'name' => 'bar' })
