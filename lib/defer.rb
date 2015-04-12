require "defer/version"

# Class to defer execution of a block
class Defer

  # Initialize with the block for deferred execution
  def initialize(interval=0.1, &block)
    throw ArgumentError.new("Defer must be initialized with a block") if block.nil?
    throw ArgumentError.new("Polling interval must be a number.") unless interval.is_a? Numeric
    throw ArgumentError.new("Polling interval must be positive.") unless interval > 0

    @interval = interval
    @deferred_block = block
  end

  # Defer execution until the provided block is satisfied
  def until(&conditional)
    throw ArgumentError.new("A conditional block is required") if conditional.nil?
    conditional_proc = Proc.new { not conditional.call }
    self.while(&conditional_proc)
  end

  # Defer execution of the @deferred_block while the provided block is satisfied
  def while(&conditional)
    throw ArgumentError.new("A conditional block is required") if conditional.nil?
    Thread.new {
      # Lower the priority for the polling thread
      Thread.current.priority = -2

      while yield do
        sleep @interval
      end
      @deferred_block.call
    }
  end
end
