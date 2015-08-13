class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant

  validate :worthy?

  SEXY_WORDS = %(sexy sex sexual voluptuous penis masturbation masturbate erotic come-hither sensuous suggestive titillating seductive racy inviting provacative)

  DRAMATIC_WORDS = %w(breathtaking vivid tragic emotional climatic farcical dramatic histrionic tragicomic striking powerful sensational startling thrilling powerful profound)

  def worthy?
      sexual? || dramatic?
      # errors.add(:worthy,"Sorry. Not worthy enough?")
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
