class MovieReview < ActiveRecord::Base
    belongs_to :movie
    belongs_to :reviewer
end