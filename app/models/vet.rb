class Vet < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user, optional: true

  has_many :appointments, dependent: :destroy

  # CALLBACK
  before_validation :normalize_email

  # VALIDATIONS
  validates :first_name, :last_name, :specialization, presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # SCOPES
  scope :by_specialization, ->(spec) { where(specialization: spec) }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end