class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable

  before_save :ensure_authentication_token

  validates :email, presence: true
end
