class Review < ActiveRecord::Base
  before_create :generate_scores
	belongs_to :user
	belongs_to :restaurant

  validate :worthy?

  SEXY_WORDS = %w(sexy sex sexual voluptuous penis vagina pussy masturbation masturbate erotic come-hither sensuous suggestive titillating seductive racy inviting provacative mistress dick orgy orgasm)

  DRAMATIC_WORDS = %w(gross pathetic miserable tacky kardashian jesus christ god ex-husband ex-wife ex-partner ex-boyfriend ex-girlfriend fuck fucking motherfucking motherfucker damn goddamn shit shitty crap crappy cock turd bitch cunt ass asshole asshat asshats twerk terrible horrible 9/11 scum vile fecle fecal douche douchebag stupid dickwad bastard cocksucker ??? !!! ?!? !?! ?? nazi)

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
    highlight_words(SEXY_WORDS,"flag-sexy")
    highlight_words(DRAMATIC_WORDS,"flag-dramatic")
  end

  def highlight_words(dictionary,flag_name)
    split_body = self.body.split(" ")
    dictionary.each do |entry|
      split_body.map! do |word|
        if word.downcase.include?(entry)
          "<span class='#{flag_name}'> #{word}</span>"
        else
          word
        end
      end
    end
    return split_body.join(" ")
  end

  def generate_scores
      self.generate_sex_score
      self.generate_drama_score
      self.combined_score = self.sex_score + self.drama_score
  end

  def self.sort_by_combined_score
    Review.all.sort { |x,y| y.combined_score <=> x.combined_score }
  end


  def generate_drama_score
    total_words = self.body.split(" ")
    found_one = false
    DRAMATIC_WORDS.each do |entry|
      total_words.each do |word|
        if word.downcase.include?(entry)
          found_one = true
          if self.drama_score
            self.drama_score += 1
          else
            self.drama_score = 1
          end
        end
      end
    end
    self.drama_score = 0 if !found_one
  end

  def generate_sex_score
    total_words = self.body.split(" ")
    found_one = false
    SEXY_WORDS.each do |entry|
      total_words.each do |word|
        if word.downcase.include?(entry)
          found_one = true
          if self.sex_score
            self.sex_score += 1
          else
            self.sex_score = 1
          end
        end
      end
    end
    self.sex_score = 0 if !found_one
  end


end
