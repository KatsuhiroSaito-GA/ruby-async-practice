require_relative 'configuration'

params = { 'company' => 'ga technologies' }
SampleJob.perform_later(params)

puts "ActiveJob enqueued with params: #{params}"
