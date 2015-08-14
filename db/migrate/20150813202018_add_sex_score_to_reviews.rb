class AddSexScoreToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :sex_score, :integer
  end
end
