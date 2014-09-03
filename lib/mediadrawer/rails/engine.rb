module Mediadrawer
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Mediadrawer

      initializer 'initialize Mediadrawer' do |app|
        Mediadrawer.load_config!
      end

      def self.mounted_path
        route = ::Rails.application.routes.routes.detect do |route|
          route.app == self
        end
        route && route.path
      end
    end
  end
end
