require_relative 'configuration'

params = { 'message' => 'Hello Resque!' }
Resque.enqueue(Resque::SampleJob, params)

puts "Job enqueued with params: #{params}"
