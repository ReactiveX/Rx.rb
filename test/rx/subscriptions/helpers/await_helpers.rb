module AwaitHelpers
  def await_array_length(array, expected, interval)
    sleep (expected * interval) * 0.9
    deadline = Time.now + interval * (expected + 1)
    while Time.now < deadline
      break if array.length == expected
      sleep interval / 10
    end
  end
end
