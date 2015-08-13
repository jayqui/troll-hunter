class CreateRestaurants < ActiveRecord::Migration
  def change
  	create_table :restaurants do |t|
  		t.string :name
  		t.integer :stars_average
  		t.string :business_type
  		t.timestamps
  	end
  end
end
