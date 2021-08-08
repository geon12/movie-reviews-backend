class Movie < ActiveRecord::Base
    has_many :movie_reviews
    has_many :reviewers, through: :movie_reviews
end