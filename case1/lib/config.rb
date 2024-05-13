class Config
  def self.configure(&block)
    new.tap(&block)
  end

  %w[client role prompt].each { attr_accessor _1.to_sym }
end

if __FILE__ == $0
  require 'dotenv/load'
  require 'langchain'
  require 'openai'

  config = Config.configure do |config|
    config.client = Langchain::LLM::OpenAI.new(api_key: ENV.fetch('OPENAI_ACCESS_TOKEN'))
    config.role = 'user'
    config.prompt = 'Hello.'
  end

  pp config.client
  pp config.role
  pp config.prompt
end
