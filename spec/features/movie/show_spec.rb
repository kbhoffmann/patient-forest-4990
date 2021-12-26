require 'rails_helper'

RSpec.describe "Movie Show Page" do

  it 'can show a movies title, creation year, and genre' do
    disney = Studio.create!(name: 'Walt Disney Pictures', location: 'Burbank')
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')
    dory = disney.movies.create!(title: 'Finding Dory', creation_year: 2016 , genre: 'Family' )
    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    visit "/movies/#{transformers.id}"

    expect(page).to have_content('Transformers')
    expect(page).to have_content(transformers.title)
    expect(page).to have_content(2007)
    expect(page).to have_content('Action')
    expect(page).to_not have_content('Finding Dory')
    expect(page).to_not have_content(2016)
    expect(page).to_not have_content('Family')
  end

  it 'can list the actors in order from youngest to oldest' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )
    gump = paramount.movies.create!(title: 'Forrest Gump', creation_year: 1994 , genre: 'Drama')

    jon = Actor.create!(name: "Jon Voight", age: 82 )
    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    tom = Actor.create!(name: "Tom Hanks", age: 65)

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )
    MovieActor.create!(movie_id: gump.id, actor_id: tom.id)

    visit "/movies/#{transformers.id}"

    expect(page).to have_content("Megan Fox")
    expect(page).to have_content("Shia LaBeouf")
    expect(page).to have_content("Jon Voight")
    expect(page).to_not have_content("Tom Hanks")
    expect(megan.name).to appear_before(jon.name)
    expect(shia.name).to appear_before(jon.name)
    expect(jon.name).to_not appear_before(megan.name)
  end

  it 'can show the average age of all of its actors' do
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

  it 'can add an existing actor to a movie' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )
    tyrese = Actor.create!(name: "Tyrese", age: 42)

    MovieActor.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActor.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{transformers.id}"

    expect(page).to_not have_content(tyrese.name)

    fill_in "Name", with: tyrese.name
    click_button "Submit"

    expect(current_path).to eq("/movies/#{transformers.id}")
    expect(page).to have_content(tyrese.name)
  end
end
