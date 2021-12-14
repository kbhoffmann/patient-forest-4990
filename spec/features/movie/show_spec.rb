require 'rails_helper'

RSpec.describe "Movie Show Page" do

  it 'can show a movies title, creation year, and genre' do
    disney = Studio.create!(name: 'Walt Disney Pictures', location: 'Burbank')
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')
    dory = disney.movies.create!(title: 'Finding Dory', creation_year: 2016 , genre: 'Family' )
    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )
    ellen = Actor.create!(name: "Ellen DeGeneres", age: 63 )

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )
    MovieActor.create!(movie_id: dory.id, actor_id: ellen.id )

    visit "/movies/#{transformers.id}"

    expect(page).to have_content('Transformers')
    expect(page).to have_content(2007)
    expect(page).to have_content('Action')
    expect(page).to_not have_content('Finding Dory')
    expect(page).to_not have_content(2016)
    expect(page).to_not have_content('Family')
  end

  it 'can list the actors in order from youngest to oldest' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    jon = Actor.create!(name: "Jon Voight", age: 82 )
    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{transformers.id}"

    expect(page).to have_content("Megan Fox")
    expect(page).to have_content("Shia LaBeouf")
    expect(page).to have_content("Jon Voight")
  #wasn't sure how to test for order, need orderly??
  end

  xit 'can show the average age of all of its actors' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{transformers.id}"

    expect(page).to have_content("Average age of actors: 51")
  end

  xit 'has a form to add an actor to the movie' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{transformers.id}"
    expect(page).to_not have_content("Tyrese")
    expect(page).to have_content("Add an actor to this movie")
  end

  xit 'can search for an actor' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )
    tyrese = Actor.create!(name: "Tyrese", age: 42 )

    visit "/movies/#{transformers.id}"

    fill_in 'search', with('Tyrese')
    click_on("Search")

    expect(current_path).to eq("/movies/#{transformers.id}")
    expect(page).to have_content('Tyrese')
  end

  xit 'has a button to add the actor to the movie' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )
    tyrese = Actor.create!(name: "Tyrese", age: 42 )

    MovieActor.create!(movie_id: transformers.id, actor_id: tyrese.id )

    visit "/movies/#{transformers.id}"

    fill_in 'search', with('Tyrese')
    click_on("Search")

    expect(current_path).to eq("/movies/#{transformers.id}")
    expect(page).to have_content('Tyrese')

    click_on("Submit")

    expect(current_path).to eq("/movies/#{transformers.id}")
    expect(page).to have_content('Tyrese')
  end
end
