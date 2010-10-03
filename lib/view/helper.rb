module View

  module Helper

    def view(value, options = {}, &block)
      ::View.to_s(value, options, self, &block)
    end

  end

end
