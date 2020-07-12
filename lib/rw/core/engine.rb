module Rw
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Rw

      config.autoload_paths << File.expand_path('../app/interactors/rw', __FILE__)
      config.autoload_paths << File.expand_path('../app/decorators/ruby', __FILE__)
      config.autoload_paths << File.expand_path('../db/seeds', __FILE__)

      initializer :append_migrations do |app|
        unless app.root.to_s.match(root.to_s)
          config.paths["db/migrate"].expanded.each do |p|
            app.config.paths["db/migrate"] << p
          end
        end
      end

      initializer :assets do |_config|
        Rails.application.config.assets.paths << root.join('app', 'assets', 'images', 'rw')
      end

      config.to_prepare do
        Rails.application.config.assets.precompile += %w(rw/1.jpg rw/3.jpg rw/4.jpg rw/5.jpg rw/6.jpg rw/pep_logo.gif)
        Rails.application.config.assets.precompile << 'bg-white-lock.png'
      end

      I18n.available_locales = [ :fa ]
      I18n.default_locale = :fa
    end
  end
end
