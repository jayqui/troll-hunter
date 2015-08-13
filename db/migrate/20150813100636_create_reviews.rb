class CreateReviews < ActiveRecord::Migration
  def change
  	create_table :reviews do |t|
  		t.string :body
  		t.string :url
  		t.references :restaurant
  		t.references :user
  		t.timestamps
  	end
  end
end
