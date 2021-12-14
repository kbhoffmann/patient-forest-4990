class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.order_youngest_to_oldest
    Actor.order(:age)
  end

  def self.average_age
    Actor.average(:age).round
  end
end
