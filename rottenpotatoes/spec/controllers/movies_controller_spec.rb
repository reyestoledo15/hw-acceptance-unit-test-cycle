require 'rails_helper'
include MoviesHelper

describe MoviesController do

  describe 'find movies with same director' do
    
    it 'should call Movie.similar_movies' do
    expect(Movie).to receive(:similar_movies).with('Star Wars')
    get :search, { title: 'Star Wars' }
    end
    
    it 'should assign similar movies exists' do
    movies = ['Blade Runner','The Social Network']
    Movie.stub(:similar_movies).with('Blade Runner').and_return(movies)
    get :search, {title: 'Blade Runner'}
    expect(assigns(:similar_movies)).to eql(movies)
    end
    
    it 'should redirect to home page if there is no director info ' do
    Movie.stub(:similar_movies).with('No name').and_return(nil)
    get :search, {title: 'No name'}
    expect(response).to redirect_to(root_url)
    end
    
  end
  
  describe 'GET index' do
    #Might delete
    #movie7 = Movie.create(title: 'Haikyuu', director: 'Goku')
    
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
    
    it 'should assign instance variable for the title header' do
      get :index, {sort: 'title'}
      expect(assigns(:title_header)) == ('hilite')
    end
    
    it 'should assign instance variable for release_date header' do
      get :index, {sort: 'release_date'}
      expect(assigns(:date_header)) == ('hilite')
    end
  end

  describe 'create a movie' do
    #it 'should flash a message on a successful save' do
    #  post :create
    #  assigns(:movie).should_not be_new_record
    #  flash[:notice].should_not be_nil
    #  response.should redirect_to movies_path
    #end
  
    it 'should pass params to Movie' do
      post :create, :movie => {:title => 'fake'}
      assigns(:movie).title.should == 'fake'
    end
  
  end
  
  describe 'DELETE #destroy' do
    let!(:movie1) { FactoryGirl.create(:movie) }
    #movie1 = Movie.create(:movie)
    it 'destroys a movie' do
      expect { delete :destroy, id: movie1.id
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to movies#index after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end 
  end
  
  describe 'odness' do

    it 'should be even' do
      oddness(Movie.count).should == "even"
      #expect(Movie.count.odd?) == ("even")
    end
    
    it 'should not be odd' do
       oddness(Movie.count).should_not == "odd"
    end
    
  end
end