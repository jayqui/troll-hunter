class AddCombinedScoreToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :combined_score, :integer
  	add_index :reviews, :combined_score
  end
end
