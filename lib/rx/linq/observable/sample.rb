module Rx
  module Observable
    # Return the latest item from this observable when another observable
    # emits an item.
    def sample(intervalOrSampler, scheduler = DefaultScheduler.instance)
      sampler = if intervalOrSampler.is_a? Numeric
        Observable.interval(intervalOrSampler, scheduler)
      else
        intervalOrSampler
      end

      AnonymousObservable.new do |observer|
        latest = nil
        sample_subscription = sampler.subscribe(
          lambda { |x|
            observer.on_next latest unless latest.nil?
            latest = nil
          },
          lambda { |err| observer.on_error err },
          lambda { observer.on_completed }
        )

        self_observer = Rx::Observer.configure do |me|
          me.on_next do |value|
            latest = value
          end
          me.on_error(&observer.method(:on_error))
          me.on_completed(&observer.method(:on_completed))
        end

        self_subscription = subscribe self_observer

        CompositeSubscription.new [sample_subscription, self_subscription]
      end
    end
  end
end
