module View

  module Helper

    def view(value, options = {}, &block)
      ::View.format(value, options, self, &block)
    end

  end

end
