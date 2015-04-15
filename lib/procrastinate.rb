require "procrastinate/version"

# Class to defer execution of a block
class Procrastinate

  # Initialize with the block for deferred execution
  def initialize(interval=0.1, &block)
    # `Procrastinate` requires a block be passed to initialization
    throw ArgumentError.new("Procrastinate must be initialized with a block") if block.nil?
    # Interval must be a positive number
    throw ArgumentError.new("Polling interval must be a number.") unless interval.is_a? Numeric
    throw ArgumentError.new("Polling interval must be positive.") unless interval > 0

    @interval = interval
    @deferred_block = block
  end

  # Defer execution until the provided block is satisfied
  def until(&conditional)
    # `Procrastinate#until` must be passed a conditional block
    throw ArgumentError.new("A conditional block is required") if conditional.nil?

    # forward the (negated) block to `Procrastinate#while`
    conditional_proc = Proc.new { not conditional.call }
    self.while(&conditional_proc)
  end

  # Defer execution of the @deferred_block while the provided block is satisfied
  def while(&conditional)
    # `Procrastinate#while` must be passed a conditional block
    throw ArgumentError.new("A conditional block is required") if conditional.nil?

    Thread.new {
      # Lower the priority for the polling thread
      Thread.current.priority = -2

      while yield do
        # Poll ever `@interval` seconds until the conditional block is satisfied.
        sleep @interval
      end
      # Call the deferred block
      @deferred_block.call
    }
  end
end
