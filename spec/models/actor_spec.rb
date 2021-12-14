require 'rails_helper'

RSpec.describe Actor do
  describe "relationships" do
    it {should have_many :movie_actors}

    it {should have_many(:movies).through(:movie_actors)}
  end

  describe 'class methods' do
    it 'can order actors from youngest to oldest' do
      megan = Actor.create!(name: "Megan Fox", age: 35)
      shia = Actor.create!(name: "Shia LaBeouf", age: 37)
      jon = Actor.create!(name: "Jon Voight", age: 82 )

      expect(Actor.order_youngest_to_oldest).to eq([megan, shia, jon])
      expect(Actor.order_youngest_to_oldest).to_not eq([jon, shia, megan])
    end

    it 'can find the average age of all the actors' do
      megan = Actor.create!(name: "Megan Fox", age: 35)
      shia = Actor.create!(name: "Shia LaBeouf", age: 37)
      jon = Actor.create!(name: "Jon Voight", age: 82 )

      expect(Actor.average_age).to eq(51)
    end
  end
end
