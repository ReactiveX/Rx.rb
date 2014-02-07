# Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.txt in the project root for license information.

require 'thread'
require_relative 'test_helper'

class TestImmediateScheduler < MiniTest::Unit::TestCase
  def test_now
    s = RX::ImmediateScheduler.instance
    assert (s.now - Time.new < 1)
  end

  def test_immediate_schedule
    s = RX::ImmediateScheduler.instance
    id = Thread.current.object_id
    ran = false
    s.schedule lambda {
        assert_equal id, Thread.current.object_id
        ran = true
    }

    assert ran
  end

  def test_schedule_error
    s = RX::ImmediateScheduler.instance
    e = Exception.new

    begin
      s.schedule lambda {
          raise e
          assert false
      }
    rescue Exception => ex
      assert_same e, ex
    end
  end

  def test_schedule_with_state_simple
    s = RX::ImmediateScheduler.instance
    x = 0

    s.schedule_with_state(42, lambda {|sched, xx|
      x = xx
      RX::Subscription.empty
    })

    assert_equal 42, x
  end

  def test_schedule_with_state_simple_relative
    s = RX::ImmediateScheduler.instance
    x = 0

    s.schedule_relative_with_state(42, 0, lambda {|sched, xx|
      x = xx
      RX::Subscription.empty
    })

    assert_equal 42, x
  end

  def test_schedule_with_state_simple_absolute
    s = RX::ImmediateScheduler.instance
    x = 0

    s.schedule_absolute_with_state(42, Time.new, lambda {|sched, xx|
        x = xx
        RX::Subscription.empty
    })

    assert_equal 42, x
  end

  def test_schedule_recursive_with_state_simple
    s = RX::ImmediateScheduler.instance
    x = 0
    y = 0

    s.schedule_with_state(42, lambda {|sched, xx|
      x = xx
      sched.schedule_with_state(43, lambda {|sched1, yy|
        y = yy
        RX::Subscription.empty
      })
    })
  end

  def test_schedule_recursive_relative_with_state_simple
    s = RX::ImmediateScheduler.instance
    x = 0
    y = 0

    s.schedule_with_state(42, lambda {|sched, xx|
      x = xx
      sched.schedule_relative_with_state(43, 1, lambda {|sched1, yy|
        y = yy
        RX::Subscription.empty
      })
    })
  end

  def test_schedule_recursive_absolute_with_state_simple
    s = RX::ImmediateScheduler.instance
    x = 0
    y = 0

    s.schedule_with_state(42, lambda { |sched, xx|
      x = xx
      sched.schedule_absolute_with_state(43, Time.new(), lambda { |sched1, yy|
        y = yy
        RX::Subscription.empty
      })
    })
  end
end
