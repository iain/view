module View

  class Nil < Formatter

    def format
      ::I18n.t(:nil, :scope => :view, :default => "")
    end

  end

end
