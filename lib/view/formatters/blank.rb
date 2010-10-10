module View

  class Blank < Formatter

    def format
      ::I18n.t(:blank, :scope => :view, :default => "")
    end

  end

end
