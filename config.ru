require 'rack'

class Redirector
  class << self
    def call(env)
      redirects = ENV.select { |k,v| k.start_with? 'REDIRECT' }
        .values
        .map { |val| val.split('==') }
        .sort.to_h

      host = env['SERVER_NAME']
      match = redirects.select { |key, _value| host =~ /#{key}/ }.first

      if match
        code, target = 302, match[1]

        if target[0] == '!'
          code = 301
          target = target[1..-1]
        end
        
        [code, {'Location' => target}, []]
      
      else
        [404, {'Content-Type' => 'text/plan'}, ['Not Found']]
      
      end
    end
  end
end

run Redirector
