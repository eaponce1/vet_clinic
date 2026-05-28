class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments, dependent: :destroy

  # ACTIVE STORAGE
  has_one_attached :photo

  # CALLBACKS
  before_save :uppercase_name

  # VALIDATIONS
  validates :name, presence: true

  validates :species,
            presence: true,
            inclusion: { in: %w[dog cat rabbit bird reptile other] }

  validates :date_of_birth, presence: true
  validate :birth_not_in_future

  validates :weight,
            presence: true,
            numericality: { greater_than: 0 }

  # IMAGE VALIDATION
  validate :photo_validation

  # SCOPES
  scope :by_species, ->(species) { where(species: species) }

  private

  def uppercase_name
    self.name = name.to_s.strip.upcase
  end

  def birth_not_in_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "cannot be in the future")
    end
  end

  def photo_validation
    return unless photo.attached?

    unless photo.content_type.start_with?("image/")
      errors.add(:photo, "must be an image")
    end

    if photo.byte_size > 5.megabytes
      errors.add(:photo, "is too big (max 5MB)")
    end
  end
end