# frozen_string_literal: true

class Credential < ApplicationRecord
  belongs_to :app, required: true

  before_create :regenerate_token

  def regenerate_token!
  	update!(token: SecureRandom.base64(30))
  end

  def regenerate_token
    self.token = SecureRandom.base64(30)
  end
end
