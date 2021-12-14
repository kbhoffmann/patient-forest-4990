class MovieActorsController < ApplicationController
  def create

    movie_actor = MovieActor.new(movie_id: params[:movie], actor_id: params[:actor])

    movie_actor.save

    redirect_to "/movies/#{params[:movie]}
  end
end
