module View

  class Railtie < ::Rails::Railtie

    ActiveSupport.on_load(:after_initialize) do
      ActiveSupport.on_load(:action_view) do
        include Helper
      end
    end

  end

end
