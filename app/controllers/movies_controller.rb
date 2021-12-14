class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors.order_youngest_to_oldest
    @age = @movie.actors.average_age
  end
end
