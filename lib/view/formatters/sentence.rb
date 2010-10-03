module View

  class Sentence < Formatter

    self.allowed_options = [ :words_connector, :two_words_connector, :last_word_connector ]

    def to_s
      if all_safe?
        sentence.html_safe
      else
        sentence
      end
    end

    def all_safe?
      formatted_values.all? { |element| element.html_safe? }
    end

    def formatted_values
      value.map { |element| View.to_s(element, each, template, &block) }
    end

    def sentence
      formatted_values.to_sentence if value.present?
    end

    def each
      all_options[:each] || { :as => View.default_formatter }
    end

  end

end
