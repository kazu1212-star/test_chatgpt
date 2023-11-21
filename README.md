# Rails ✖️ ChatGPT　アプリケーション
## 食材を入力したら、レシピを作成するデモアプリ


#### 入力フォーム
<img width="1455" alt="スクリーンショット 2023-11-20 13 50 54" src="https://github.com/kazu1212-star/test_chatgpt/assets/115007915/6bf8c17d-1995-44f6-8b08-f4bda90aec04">

#### 出力結果
<img width="958" alt="スクリーンショット 2023-11-20 13 50 19" src="https://github.com/kazu1212-star/test_chatgpt/assets/115007915/d7b72677-3491-4a2e-8145-d6f50d15bcc7">

## セットアップ
##### 1.development.envを作成
```
┣ Dockerfile
┣ docker-compose.yml
┣ development.env
```
##### 2..env_templateの内容をコピーして、development.envに貼り付け
　コメントに従って、環境変数を追加してください
```.env_template
# OpenAIのAPIキーを設定してください
OPENAI_API_KEY=<APIKey>

# 使用するデータベース名を設定してください（例: myapp_development）
MYSQL_DATABASE=アプリ名_development

# MySQLのrootユーザーのパスワードを設定してください
MYSQL_ROOT_PASSWORD=<YourRootPassword>

# MySQLのユーザーのパスワードを設定してください
MYSQL_PASSWORD=<YourDbPassword>
```
##### 3.APIキー作成、取得
Get your [API key](https://platform.openai.com/account/api-keys
)  
##### 2.development.env　に１のAPIキーを記述
```development.env
  OPENAI_API_KEY=ここにキーを記述
```
##### 3.Open AI APIへ課金
無料枠だと
`Faraday::ClientError (the server responded with status 429):`となります。
そのため課金する必要があります。
有料には最低でも$5かかります。
[Billing settings](https://platform.openai.com/account/billing/overview)

##### 4.プロンプトをカスタマイズ
　messageのcontentに任意の指示を記述。
```app/mode/open_ai.rb
class OpenAi
  require 'ruby/openai'

  def self.generate(text)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
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

```
