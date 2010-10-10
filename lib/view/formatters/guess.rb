module View

  class Guess < Formatter

    def format
      View.guessing_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
      value
    end

  end

end
