module View

  class Nil < Formatter

    def to_s
      ::I18n.t(:nil, :scope => :view, :default => "")
    end

  end

end
