require 'rails_helper'

RSpec.describe "Studio Index Page" do

  it 'can list all of the studios and their movies' do

    disney = Studio.create!(name: 'Walt Disney Pictures', location: 'Burbank')
    paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')
    dory = disney.movies.create!(title: 'Finding Dory', creation_year: 2016 , genre: 'Family' )
    transformers = paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )

    visit "/studios"

    expect(page).to have_content("Name: Walt Disney Pictures")
    # expect(page).to have_content(disney.name)
    expect(page).to have_content("Location: Burbank")
    expect(page).to have_content("Name: Paramount Pictures")
    expect(page).to have_content("Location: Los Angeles")
    expect(page).to have_content("Movies: Finding Dory")
    expect(page).to have_content("Movies: Transformers")
    #try within blocks to separate the 2 studios to show where they appear in the page
  end
end
