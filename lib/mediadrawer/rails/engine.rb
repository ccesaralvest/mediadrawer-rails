module Mediadrawer
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Mediadrawer

      initializer 'initialize Mediadrawer' do |app|
        Mediadrawer.load_config!
      end
    end
  end
end
