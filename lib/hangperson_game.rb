class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    throw :inputError unless letter =~ /\w/
    nletter = letter.downcase
    if @guesses.include?(nletter) || @wrong_guesses.include?(nletter) 
      return false
    elsif
      @word.include?(nletter) && !(@guesses.include?(nletter))
      @guesses += nletter
      return true
    elsif !(@wrong_guesses.include?(nletter))
      @wrong_guesses += nletter
      return true
    end
  end
  
  def word_with_guesses
    word_arr = @word.split(//)
    gword = ""
    word_arr.each do |letter|
      if @guesses.include?(letter)
        gword+=letter
      else
        gword+="-"
      end
    end
    return gword
  end
  
  def check_win_or_lose
    if @wrong_guesses.length > 6
      return :lose
    elsif word_with_guesses == @word
      return :win
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
