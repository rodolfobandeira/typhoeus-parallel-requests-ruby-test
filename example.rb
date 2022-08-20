# frozen_string_literal: true

require 'typhoeus'
hydra = Typhoeus::Hydra.hydra

timeout = 5
connecttimeout = 3

first_request = Typhoeus::Request.new(
  'https://icanhazdadjoke.com/',
  headers: { 'Accept' => 'text/plain' },
  timeout: timeout,
  connecttimeout: connecttimeout
)
first_request.on_complete do |response|
  # Do something when the first request completes

  # third_url = response.body
  # third_request = Typhoeus::Request.new(third_url)
  # hydra.queue third_request

  if response.success?
    # hell yeah
    puts 'First request success!'
    puts response.body
  elsif response.timed_out?
    # aw hell no
    puts 'got a time out'
  elsif response.code.zero?
    # Could not get an http response, something's wrong.
    puts response.return_message
  else
    # Received a non-successful http response.
    puts "HTTP request failed: #{response.code}"
  end
end

second_request = Typhoeus::Request.new(
  'https://icanhazdadjoke.com/',
  headers: { 'Accept' => 'text/plain' },
  timeout: timeout,
  connecttimeout: connecttimeout
)
second_request.on_complete do |response|
  # Do something when the first request completes

  # third_url = response.body
  # third_request = Typhoeus::Request.new(third_url)
  # hydra.queue third_request

  if response.success?
    # hell yeah
    puts 'second request success!'
    puts response.body
  elsif response.timed_out?
    # aw hell no
    puts 'got a time out'
  elsif response.code.zero?
    # Could not get an http response, something's wrong.
    puts response.return_message
  else
    # Received a non-successful http response.
    puts "HTTP request failed: #{response.code}"
  end
end

third_request = Typhoeus::Request.new(
  'https://www.brasil.gov.br/',
  timeout: timeout,
  connecttimeout: connecttimeout
)
third_request.on_complete do |response|
  # Do something when the first request completes

  # third_url = response.body
  # third_request = Typhoeus::Request.new(third_url)
  # hydra.queue third_request

  if response.success?
    # hell yeah
    puts 'third request success!'
    puts response.body
  elsif response.timed_out?
    # aw hell no
    puts 'got a time out'
  elsif response.code.zero?
    # Could not get an http response, something's wrong.
    puts response.return_message
  else
    # Received a non-successful http response.
    puts "HTTP request failed: #{response.code}"
  end
end

puts 'Enqueueing request 1'
hydra.queue first_request

puts 'Enqueueing request 2'
hydra.queue second_request

puts 'Enqueueing request 3'
hydra.queue third_request

puts 'hydra.run!'
# this is a blocking call that returns once all requests are complete
hydra.run

puts 'All done'
