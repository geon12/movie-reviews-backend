class AddColumnsDirectorDuration < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :director, :string
    add_column :movies, :duration, :integer
  end
end
