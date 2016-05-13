require 'set'
require 'byebug'
class WordChainer

  attr_reader :dictionary, :all_seen_words, :current_words

  def initialize(filename = 'dictionary.txt')
    @dictionary = Set.new(File.readlines(filename).map(&:chomp))
    @all_seen_words = []
    @current_words = {}
  end

  def adjacent_words(given_word)
    @dictionary.find_all {|dict_word| one_letter_off?(given_word, dict_word)}
  end

  def one_letter_off?(word1, word2)
    return false unless word1.length == word2.length
    off_counts = 0
    word1.each_char.with_index do |letter, i|
      off_counts += 1 unless letter == word2[i]
    end
    off_counts == 1
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty? || @all_seen_words.key?(target)
      @current_words = explore_current_words
    end
    puts build_path(target) || "The chain cannot be made!"
    end

  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|

        unless @all_seen_words.key?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end

      end
    end
    new_current_words
  end

  def build_path(target)
    return false unless @all_seen_words.key?(target)
    path = [target]
    while true
      prev_word = @all_seen_words[target]
      break unless prev_word
      path.unshift(prev_word)
      target = prev_word
    end
    path
  end


end
