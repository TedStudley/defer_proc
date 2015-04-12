require "defer/version"

class Defer

  def initialize(timestep, &block)
    @timestep = timestep
    @deferred_block = block
  end

  def until(&block)
    deferral_proc = Proc.new { not block.call }
    self.while(&deferral_proc)
  end

  def while(&block)
    Thread.new {
      # Lower the priority for the polling thread
      Thread.current.priority = -2

      while yield do
        sleep @timestep
      end
      @deferred_block.call
    }
  end
end
