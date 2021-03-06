require 'minitest/autorun'
require 'defer_proc'

class TestDeferProc < Minitest::Test
  def test_that_defer_proc_has_a_version_number
    refute_nil ::DeferProc::VERSION
  end

  def test_defer_until_works
    canary = false
    trigger = false
    DeferProc.new { canary = true }.until { trigger == true }

    # trigger the deferred statement
    trigger = true

    # Give the deferred statement time to trigger
    sleep(0.2)
    assert(canary, "The deferred statement should trigger")
  end

  def test_defer_while_works
    canary = false
    trigger = false
    DeferProc.new { canary = true }.while { trigger == false }

    # trigger the deferred statement
    trigger = true

    # Give the deferred statement time to trigger
    sleep(0.2)
    assert(canary, "The deferred statement should trigger")
  end

  def test_defer_until_class_creation
    canary = false
    DeferProc.new { canary = true }.until { defined?(Trigger) }

    # Mock class creation by populating a constant
    Object.const_set(:Trigger, Struct.new(:a, :b))

    # Give the deferred statement time to trigger
    sleep(0.2)
    assert(canary, "The deferred statement should trigger")
  end

  def test_defer_wont_trigger
    canary = false
    trigger = false
    deferred_thread = DeferProc.new { canary = true }.until { trigger == true }

    # Give the deferred statement time to ensure it won't trigger
    sleep(0.2)
    assert(not(canary), "The deferred statement shouldn't trigger")

    # Kill the deferred thread, just in case.
    deferred_thread.kill
  end
end
