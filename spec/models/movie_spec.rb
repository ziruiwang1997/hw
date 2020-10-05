require 'rails_helper'


describe Movie do
  
  before :each do
    @movie_1 = {:title => 'Star Wars', :director => 'George Lucas', :rating => 'PG', :release_date => '1977-05-25'}
    @movie_2 = {:title => 'Alien', :rating => 'PG', :release_date => '1979-05-25'}
    @movie_3 = {:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'}
    @movie_4 = {:title => 'THX-1138', :rating => 'PG', :director => 'George Lucas', :release_date => '1971-03-11'}
  end    
  
  describe 'finding movies with same director' do 
    context "it should find movies by the same director" do
      let(:current_movie) { instance_double(Movie, @movie_1) }
      let(:same_dir_movie) { instance_double(Movie, @movie_4) }
        it 'find movies whose director matches that of the current movie' do
          expect(Movie).to receive(:where).with(director: current_movie.director).and_return(same_dir_movie)
          Movie.with_director(current_movie.director)
      end 
    end
    
    context "should not find movies by different directors" do 
      let(:current_movie) { instance_double(Movie, @movie_1) }
      let(:different_dir_movie) { instance_double(Movie, @movie_3) }
        it 'find movies whose director matches that of the current movie' do
          expect(Movie.with_director(current_movie.director)).not_to include(different_dir_movie)
          Movie.with_director(current_movie.director)
      end 
    end
    
  end
end