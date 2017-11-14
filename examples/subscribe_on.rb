require 'rx'

def in_a_second(n)
  Rx::Observable.create do |observer|
    sleep(1)
    observer.on_next(n)
    observer.on_completed
  end
end

# subscribe_on will schedule ancestry on given scheduler; each sleep happens in a separate thread
source = Rx::Observable.of(
  in_a_second(1)
    .map {|v| v + 1 }
    .subscribe_on(Rx::DefaultScheduler.instance),
  in_a_second(2)
    .map {|v| v + 1 }
    .subscribe_on(Rx::DefaultScheduler.instance)
).merge_all
.time_interval

subscription = source.subscribe(
    lambda {|x|
        puts 'Next: ' + x.to_s
    },
    lambda {|err|
        puts 'Error: ' + err.to_s
    },
    lambda {
        puts 'Completed'
    })

# => Next: (3)@(1.004153)
# => Next: (2)@(0.000251)

while Thread.list.size > 1
  (Thread.list - [Thread.current]).each &:join
end
