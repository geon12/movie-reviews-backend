class CreateMovieReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_reviews do |t|
      t.integer :rating
      t.string :review
      t.integer :likes
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :reviewer, foreign_key: true
    end
  end
end
