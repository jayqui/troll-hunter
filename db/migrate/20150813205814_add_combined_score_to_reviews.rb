class AddCombinedScoreToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :combined_score, :integer
  end
end
