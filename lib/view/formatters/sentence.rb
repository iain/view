module View

  # This formatter is for arrays and stuff into a sentence.
  #
  # You can pass the options for sentence and, like any other array formatter,
  # you can pass an each option, that contains the options for every element in
  # the array.
  #
  # If you don't pass any options in each, it will autoformat every element.
  #
  # @example
  #
  #   View.format @dates, :as => :sentence,
  #     :each => { :as => :date, :format => :short }
  #
  # @see View::Array
  # @see http://rubydoc.info/docs/rails/3.0.0/Array:to_sentence
  class Sentence < Array

    self.allowed_options = [ :words_connector, :two_words_connector, :last_word_connector ]

    def format
      formatted_values.to_sentence(options)
    end

  end

end
