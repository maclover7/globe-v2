unless ENV['TEST_LOGS'] == 'true'
  module Pliny::Log
    def log(_data, &block)
      block.call if block
    end
  end
end
