module View

  # This formatter is the fallback formatter for auto. It figures out which
  # method will be called to get a proper version to render.
  #
  # @see View.guessing_methods
  class Guess < Formatter

    def format
      View.guessing_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
      value
    end

  end

end
