# frozen_string_literal: true

class Chat < ApplicationRecord
  validates :text, presence: true
end
