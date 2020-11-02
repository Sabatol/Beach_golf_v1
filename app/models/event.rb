class Event < ApplicationRecord
  validates :start_date, :location,
  presence: true


  validate :is_future?
  validate :is_multiple_5
  validates :duration, presence: true, numericality: {only_integer: true}
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: 1..1000

  belongs_to :user
  has_many :participations
  has_many :users, through: :participations

  def is_future?
    start_date > Time.now
  end

  def is_multiple_5
    errors.add(:start_date, "shouldn't be 0 and shouldn't be multiple of 5") unless
      duration % 5 == 0 && duration > 0
  end
end
