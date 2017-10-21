# Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.txt in the project root for license information.

require 'test_helper'
require 'rx/subscriptions/helpers/await_helpers'

class TestDefaultScheduler < Minitest::Test
  include AwaitHelpers

  def setup
    @scheduler = Rx::DefaultScheduler.instance
  end

  INTERVAL = 0.05

  def test_schedule_with_state
    state = []
    task  = ->(_, s) { s << 1 }
    @scheduler.schedule_with_state(state, task)
    await_array_length(state, 1, INTERVAL)

    assert_equal([1], state)
  end

  def test_schedule_relative_with_state
    state = []
    task  = ->(_, s) { s << 1 }
    @scheduler.schedule_relative_with_state(state, 0.05, task)
    await_array_length(state, 1, INTERVAL)

    assert_equal([1], state)
  end

  def test_default_schedule_runs_in_its_own_thread
    state = []
    id = Thread.current.object_id
    @scheduler.schedule -> { state << Thread.current.object_id }
    await_array_length(state, 1, INTERVAL)

    refute_equal([id], state)
  end

  def test_schedule_action_cancel
    task = -> { flunk "This should not run." }
    subscription = @scheduler.schedule_relative(0.05, task)
    subscription.unsubscribe
    sleep 0.1
  end
end
