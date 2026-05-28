class Owner < ApplicationRecord
  belongs_to :user, optional: true

  has_many :pets, dependent: :destroy

  # CALLBACKS
  before_validation :normalize_email
  before_validation :strip_phone

  # VALIDATIONS
  validates :first_name, :last_name, :phone, presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # FULL NAME
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def strip_phone
    self.phone = phone.to_s.strip
  end
end