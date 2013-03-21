# Copyright (c) Microsoft Corporation. All rights reserved. See License.txt in the project root

$: << File.dirname(__FILE__)

require 'rx/observer'
require 'rx/observable'
require 'core_ext/enumerable'

observer = RX::Observer.new do |o|
	o.with_on_next {|next_value| puts "Next: #{next_value}" }
	o.with_on_error {|exception| puts "Exception: #{exception.message}"}
	o.with_on_completed { puts "done!" }	
end

#observable = Observable.generate(0, { :condition => proc {|i| i < 10}, :iterate => proc {|i| i+1}, :result_selector => proc {|i|i}}).
# observable = Observable.range(2,2, Scheduler.new_thread).select_many do |x|
	# Observable.range(x * 3, 3, Scheduler.new_thread)
# end

observable1 = RX::Observable.empty
observable2 = RX::Observable.return(42)
observable3 = RX::Observable.throw(Exception.new("oops!"))
observable4 = RX::Observable.generate(
	0,
	lambda {|x| x < 10},
	lambda {|x| x},
	lambda {|x| x + 1})
observable5 = RX::Observable.range(0, 10)
observable6 = (1..10).to_observable
observable7 = observable6.
	where {|x| x % 2 == 0}
observable8 = observable7.
	select {|x| x * x + x}
observable9 = RX::Observable.range(0, 2).select_many do |x|
	RX::Observable.range(x * 25, 2)
end
observable10 = RX::Observable.return(42).
	finally { puts 'finally doing something with my life' }

# observable1.subscribe(observer)
# observable2.subscribe(observer)
# observable3.subscribe(observer)
# observable4.subscribe(observer)
# observable5.subscribe(observer)
# observable6.subscribe(observer)
# (1..10).subscribe(observer)
# observable7.subscribe(observer)
# observable8.subscribe(observer)
# observable9.subscribe(observer)
observable10.subscribe(observer)

# bart = "erik"

# Observable.throw(Exception.new("woops!")).subscribe(Class.new(Observer) do
	# @@bart = bart

	# def on_next(el)
		# puts "#{@@bart} #{el}"
	# end
	
	# def on_error(exception)
		# puts "#{exception.message}"
	# end

# end.new)

gets
