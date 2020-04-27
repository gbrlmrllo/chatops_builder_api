class Credential < ApplicationRecord
  belongs_to :app

  before_create :token_init

  def token_init
    self.token = SecureRandom.base64(30)
  end
end
