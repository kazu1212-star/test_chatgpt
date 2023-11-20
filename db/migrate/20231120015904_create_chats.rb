# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :text, null: false
      t.text :response_message
      t.timestamps
    end
  end
end
