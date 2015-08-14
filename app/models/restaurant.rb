class Restaurant < ActiveRecord::Base
	has_many  :reviews

  def full_name
    self.name[2..-3]
  end

  def reviews_by_score
    self.reviews.sort { |x,y| y.combined_score <=> x.combined_score }
  end

end
