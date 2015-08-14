class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :restaurant

  validate :worthy?

  SEXY_WORDS = %w(sexy sex sexual voluptuous penis vagina pussy masturbation masturbate erotic come-hither sensuous suggestive titillating seductive racy inviting provacative mistress dick orgy orgasm)

  DRAMATIC_WORDS = %w(gross pathetic miserable tacky Kardashian jesus Jesus Christ God god ex-husband ex-wife ex-partner ex-boyfriend ex-girlfriend fuck fucking motherfucking motherfucker damn goddamn shit shitty crap crappy cock bitch cunt asshole asshat twerk terrible horrible 9/11 scum vile fecle fecal)

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

  def highlighted_review
    #SEXY_WORDS.each {|word| body.gsub }
    self.body.split(" ").map do |word|
      if SEXY_WORDS.include?(word) || DRAMATIC_WORDS.include?(word)
        "<span class='flag-word'> #{word}</span>"
      else
        word
      end
    end.join(" ")
  end


end
