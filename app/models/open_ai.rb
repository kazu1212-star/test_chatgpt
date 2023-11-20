# frozen_string_literal: true

# OpenAI APIを叩く
class OpenAi
  require 'ruby/openai'

  def self.generate(text)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY']) # API keyを記述
    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user',
                     # contentにプロンプトの詳細を記述。
                     content: "「材料は#{text}」です。レシピを作成してください" }]
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
