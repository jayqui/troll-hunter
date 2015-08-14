class Restaurant < ActiveRecord::Base
	has_many  :reviews

  def full_name
    self.name[2..-3]
  end
end
