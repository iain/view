module View

  class Guess < Formatter

    def to_s
      View.guessing_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
      value
    end

  end

end
