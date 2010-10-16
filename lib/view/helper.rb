module View

  module Helper

    # Use the formatter straight from the view
    def view(value, options = {}, &block)
      ::View.format(value, options, self, &block)
    end

    # Shortcut for rendering tables
    def table_for(value, options = {}, &block)
      view(value, options.merge(:as => :table), &block)
    end

    # If you're using something like InheritedResource, this will automatically
    # set the table for the current collection, so you'll only need to do:
    #
    #   = table
    def table(options = {}, &block)
      table_for(collection, options.merge(:class => resource_class), &block)
    end

    # Shortcut for definition_lists
    def definition_list_for(value, options = {}, &block)
      view(value, options.merge(:as => :definition_list), &block)
    end

    # If you're using something like InheritedResource, this will automatically
    # set the definition_list for the current resource, so you'll only need to do:
    #
    #   = definition_list
    def definition_list(options = {}, &block)
      definition_list_for(resource, options, &block)
    end

  end

end
