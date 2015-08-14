class Restaurant < ActiveRecord::Base
	has_many  :reviews

  def full_name
    self.name[2..-3]
  end

  def reviews_by_score
    self.reviews.order(combined_score: :desc)
  end

end
