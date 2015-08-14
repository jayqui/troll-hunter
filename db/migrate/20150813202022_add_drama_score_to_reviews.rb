class AddDramaScoreToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :drama_score, :integer
  end
end
