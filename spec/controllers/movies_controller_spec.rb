require 'rails_helper'

describe MoviesController do
    before :each do
       @movie_1 = {:title => 'Star Wars', :director => 'George Lucas', :rating => 'PG', :release_date => '1977-05-25'}
       @movie_2 = {:title => 'Alien', :rating => 'PG', :release_date => '1979-05-25'}
    end  
    
    describe 'find movies with same director ' do
        context "when the specified movie has a director" do
            let(:movie_with_dir) { instance_double(Movie, @movie_1) }
            it " should find movies by the same director" do 
                expect(Movie).to receive(:find).with('1').and_return(movie_with_dir)
                expect(movie_with_dir).to receive(:director).and_return('George Lucas')
                expect(Movie).to receive(:with_director).with('George Lucas')
                get :with_same_director,  :movie_id => 1
                expect(response).to render_template(:with_same_director)
            end
        end
        context "when movie has no director" do
            let(:movie_without_dir) { instance_double(Movie, @movie_2) }
            it "should redirect to home page" do
                expect(Movie).to receive(:find).with('2').and_return(movie_without_dir)
                expect(movie_without_dir).to receive(:director).and_return(nil)
                get :with_same_director, :movie_id => 2
                expect(response).to redirect_to(movies_path)
            end
        end
    end
    
    describe 'create movie' do
        let(:new_movie) { instance_double(Movie, @movie_1) } 
        it 'creates a movie' do
            expect(Movie).to receive(:create!).with(@movie_1).and_return(new_movie)
            post :create, {:movie => @movie_1}
        end
    end
    
    describe 'edit movie' do
        let(:current_movie) { instance_double(Movie,  @movie_1) }
        it 'edit a movie' do
            allow(Movie).to receive(:find).with('1').and_return(current_movie)
            expect(current_movie).to receive(:update_attributes!).with(@movie_1)
            put :update, {:id => 1, :movie => @movie_1}
        end
    end
    
    describe 'destroy movie' do
        let(:current_movie) { instance_double(Movie, @movie_1) }
        it 'destroy a movie' do
            allow(Movie).to receive(:find).with('1').and_return(current_movie)
            expect(current_movie).to receive(:destroy)
            delete :destroy, {:id => 1}
        end
    end
    
    describe 'show index' do
        it 'sort by title' do
            get :index, {:sort => 'title'}
            expect(assigns(:title_header)).to eq 'hilite'
        end   
        it 'sort by release_date' do
            get :index, {:sort => 'release_date'}
            expect(assigns(:date_header)).to eq 'hilite'
        end  
    end
    
    describe 'show movie' do
        let(:current_movie) { instance_double(Movie,  @movie_1) }
        it 'find a movie' do
            expect(Movie).to receive(:find).with('1').and_return(current_movie)
            get :show, {:id => 1}
        end   
    end

  
end