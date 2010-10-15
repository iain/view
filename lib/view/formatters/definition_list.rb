module View
  class DefinitionList < Formatter

    def format
      fields.inject("".html_safe) do |html, field|
        html << show(field)
      end
    end

    def fields
      value_class.respond_to?(:column_names) ? value_class.column_names : []
    end

    def show(attribute, options = {}, &block)
      tag = Attribute.new(value, attribute, block, template, options)
      tag.dt + tag.dd
    end

    def format!
      template.content_tag(:dl, super, options)
    end

    private

    def value_class
      value.class
    end

    class Attribute < Struct.new(:resource, :attribute, :block, :template, :options)

      def dt
        template.content_tag(:dt, name, html_options)
      end

      def dd
        template.content_tag(:dd, value, html_options)
      end

      def name
        if klass.respond_to?(:human_attribute_name)
          human
        else
          attribute.to_s.titleize
        end
      end

      def human
        klass.human_attribute_name(attribute)
      end

      def klass
        resource.class
      end

      def value
        View.format(original_value, options, template, &block)
      end

      def original_value
        resource.send(attribute)
      end

      def html_options
        { :class => attribute }
      end

    end

  end
end
