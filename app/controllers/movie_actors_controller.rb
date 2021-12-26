class MovieActorsController < ApplicationController
  def create
    actor = Actor.find_by(name: params[:name])
    movie_actor = MovieActor.new(movie_id: params[:id] , actor_id: actor.id )
    
    movie_actor.save

    redirect_to "/movies/#{params[:id]}"
  end
end
