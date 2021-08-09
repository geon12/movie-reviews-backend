class Movie < ActiveRecord::Base
    has_many :movie_reviews
    has_many :reviewers, through: :movie_reviews
    def average_rating
        self.movie_reviews.average(:rating)
    end

end