require_relative 'configuration'

params = { 'message' => 'Hello ActiveJob!' }
ActiveJobPractice::SampleJob.perform_later(params)

puts "ActiveJob enqueued with params: #{params}"
