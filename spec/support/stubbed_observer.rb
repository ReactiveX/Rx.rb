require 'rx/observer'

class StubbedObserver < RX::Observer
  attr_reader :next, :exception, :done

  def initialize
    @done = false
    
    with_on_next { |next_value| @next = next_value }
    with_on_error { |exception| @exception = exception }
    with_on_completed { |exception| @done = true }
  end
end