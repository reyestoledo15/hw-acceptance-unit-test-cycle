require 'rails_helper'


describe Movie do
    describe '.find_similar_movies' do
       movie1 = Movie.create(title: 'Star Wars', director: 'George Lucas')
       movie2 = Movie.create(title: 'Blade Runner', director: 'Ridley Scott') 
       movie3 = Movie.create(title: "THX-1138", director: 'George Lucas')
       movie4 = Movie.create(title: "Alien") 
       
       context 'director exists' do
           
           it 'finds similar movies'do
               expect(Movie.similar_movies(movie1.title)) == ([movie1.title,movie3.title])
               expect(Movie.similar_movies(movie1.title)).to_not include(['Blade Runner'])
               expect(Movie.similar_movies(movie2.title)) == (['Blade Runner'])
           end
       end
       
       context 'director does not exist' do
          it 'handles sad path' do
             expect(Movie.similar_movies(movie4.title)).to eql(nil)
          end
       end
    end
    
    describe '.all_ratings' do
      it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R)) 
      end
    end
   
end
