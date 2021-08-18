class GamesController < ApplicationController
    def new
      vocals = %w[A E I O U]
      consonants = ('A'..'Z').to_a
  
      @letters = Array.new(5) { vocals.sample }
      @letters += Array.new(5) { consonants.sample }
      @letters.shuffle
    end
  
    def score
        @letters = params[:letters].split
        @word = (params[:word] || "").upcase
        @included = included?(@word, @letters)
        @english_word = english_word?(@word)
      end
    
      private
    
      def included?(word, letters)
        word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      end
    
      def english_word?(word)
        response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        json['found']
      end
    end
    
