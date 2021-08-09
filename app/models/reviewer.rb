class Reviewer < ActiveRecord::Base
    
    has_many :movie_reviews
    has_many :movies, through: :movie_reviews

    def total_likes
        self.movie_reviews.sum(:likes)
    end
end