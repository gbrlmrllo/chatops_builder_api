class App < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_one :credential

  before_create ->{ build_credential }
end
