require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should belong_to(:studio) }
    it { should have_many :movie_actors}
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe 'instance methods' do
    before (:each) do
      @paramount = Studio.create!(name: 'Paramount Pictures', location: 'Los Angeles')
      @transformers = @paramount.movies.create!(title: 'Transformers', creation_year: 2007 , genre: 'Action' )
      @megan = @transformers.actors.create!(name: "Megan Fox", age: 35)
      @shia = @transformers.actors.create!(name: "Shia LaBeouf", age: 37)
      @jon = @transformers.actors.create!(name: "Jon Voight", age: 82 )
    end

    it 'can order actors from youngest to oldest' do

      expect(@transformers.order_youngest_to_oldest).to eq([@megan, @shia, @jon])
      expect(@transformers.order_youngest_to_oldest).to_not eq([@jon, @shia, @megan])
    end

    it 'can find the average age of all the actors' do

      expect(@transformers.average_age.round).to eq(51)
    end
  end
end


  # describe 'instance variables' do
  #   it "order_youngest_to_oldest"
  #
  #   expect(movie_1.order_youngest_to_oldest).to eq([actor_1, actor_2, actor_3])
  # end

  # it 'average_age' do
  #   expect(movie_1.average_age).to eq(51)
  # end
