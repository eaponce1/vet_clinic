class User < ApplicationRecord
  # ENUMS
  enum :role, {
    owner: 0,
    vet: 1,
    admin: 2
  }

  # ASSOCIATIONS
  has_one :owner, dependent: :nullify
  has_one :vet, dependent: :nullify

  # DEVISE MODULES
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  # VALIDATIONS
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  # METHODS
  def full_name
    "#{first_name} #{last_name}"
  end
end