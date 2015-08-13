class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant

  validate :worthy?

  SEXY_WORDS = %w(sexy sex sexual voluptuous penis masturbation masturbate erotic come-hither sensuous suggestive titillating seductive racy inviting provacative mistress dick)

  DRAMATIC_WORDS = %w(breathtaking vivid tragic emotional climatic farcical dramatic histrionic tragicomic striking powerful sensational startling thrilling powerful profound ex-husband ex-wife ex-partner ex-boyfriend ex-girlfriend fuck damn shit cock bitch asshole asshat twerk)

  def worthy?
    unless self.sexual? || self.dramatic?
      errors.add(:worthy, "please")
    end
  end

  def self.too_sexual
    Review.all.select {|review| review.sexual?}
  end

  def sexual?
    total_words = self.body.split(" ")
    total_words.any?{|word| SEXY_WORDS.include?(word)}
  end

  def self.too_dramatic
    Review.all.select{|review| review.dramatic?}
  end

  def dramatic?
    total_words = self.body.split(" ")
    total_words.any?{|word| DRAMATIC_WORDS.include?(word)}
  end


end
