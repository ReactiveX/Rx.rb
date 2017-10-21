# Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.txt in the project root for license information.

require 'test_helper'

class TestBehaviorSubject < Minitest::Test
  def test_subscriber_notified_on_change
    value = 0
    subject = Rx::BehaviorSubject.new 0
    subject.as_observable.subscribe { |update| value = update }
    subject.on_next 1
    assert_equal 1, value
  end

  def test_multiple_observers_notified_on_change
    value1 = 0
    value2 = 0
    subject = Rx::BehaviorSubject.new 0
    subject.as_observable.subscribe { |update| value1 = update }
    subject.as_observable.subscribe { |update| value2 = update }
    subject.on_next 1
    assert_equal 1, value1
    assert_equal 1, value2
  end

  def test_errors_on_next_when_unsubscribed
    subject = Rx::BehaviorSubject.new 0
    subject.as_observable.subscribe { }
    subject.unsubscribe
    assert_raises(RuntimeError) { subject.on_next 1 }
  end
end
