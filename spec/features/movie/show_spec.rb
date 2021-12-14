require 'rails_helper'

RSpec.describe "Movie Show Page" do

  xit 'can show a movies title, creation year, and genre' do
    disney = Studio.create!(name: 'Walt Disney Pictures', location: 'Burbank')
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')
    dory = disney.movies.create!(title: 'Finding Dory', creation_year: 2016 , genre: 'Family' )
    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )
    ellen = Actor.create!(name: "Ellen DeGeneres", age: 63 )

    MovieActors.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: jon.id )
    MovieActors.create!(movie_id: dory.id, actor_id: ellen.id )

    visit "/movies/#{@transformers.id}"

    expect(page).to have_content('Transformers')
    expect(page).to have_content(2007)
    expect(page).to have_content('Action')
    expect(page).to_not have_content('Finding Dory')
    expect(page).to_not have_content(2016)
    expect(page).to_not have_content('Family')
  end

  xit 'can list the actors in order from youngest to oldest' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    jon = Actor.create!(name: "Jon Voight", age: 82 )
    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)

    MovieActors.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{@transformers.id}"

    expect(page).to have_content("Megan Fox")
    expect(page).to have_content("Shia LaBeouf")
    expect(page).to have_content("Jon Voight")
    expect("Megan Fox").to appear_before("Shia LaBeouf")
    expect("Shia LaBeouf").to appear_before("Jon Voight")
    expect("Shia LaBeouf").to_not appear_before("Megan Fox")
    expect("Jon Voight").to_not appear_before("Megan Fox")
  end

  xit 'can show the average age of all of its actors' do
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')

    megan = Actor.create!(name: "Megan Fox", age: 35)
    shia = Actor.create!(name: "Shia LaBeouf", age: 37)
    jon = Actor.create!(name: "Jon Voight", age: 82 )

    MovieActors.create!(movie_id: transformers.id, actor_id: megan.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: shia.id )
    MovieActors.create!(movie_id: transformers.id, actor_id: jon.id )

    visit "/movies/#{@transformers.id}"

    expect(page).to have_content("Average age of actors: 51")
  end
end
