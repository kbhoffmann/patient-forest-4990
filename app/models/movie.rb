class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def order_youngest_to_oldest
    actors.order(:age)
  end

  def average_age
    actors.average(:age)
  end
end
