# frozen_string_literal: true

require 'rack'

class Redirector
  class << self
    def call(env)
      host = env['SERVER_NAME']
      match = redirects.select { |key, _value| host =~ /#{key}/ }.first

      if match
        code = 302
        target = match[1]

        if target[0] == '!'
          code = 301
          target = target[1..]
        end

        [code, { 'location' => target }, []]

      else
        [404, { 'content-type' => 'text/plain' }, ['Not Found']]

      end
    end

    def redirects
      ENV.select { |k, _v| k.start_with? 'REDIRECT' }
         .sort_by { |k, _v| k }.to_h
         .values.map { |val| val.split('==') }.to_h
    end
  end
end

run Redirector
