module View

  class Sentence < List

    self.allowed_options = [ :words_connector, :two_words_connector, :last_word_connector ]

    def format
      formatted_values.to_sentence(options) if value.present?
    end

  end

end
