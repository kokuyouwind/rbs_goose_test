require_relative 'config'

class Runner
  def initialize(config)
    @config = config
  end

  def run
    config.client.chat(messages: [{ role: config.role, content: config.prompt}]).chat_completion
  end

  private

  attr_reader :config
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
  runner = Runner.new(config)
  pp runner.run
end
