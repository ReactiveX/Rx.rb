require 'rx'
require 'support/stubbed_observer'

describe RX::Observable do
  before {
    @observer = StubbedObserver.new
  }

  describe '#empty' do
    let(:empty_observable) { RX::Observable.empty }

    before { empty_observable.subscribe(@observer) }

    specify { @observer.next.should == nil }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#return' do
    let(:static_observable) { RX::Observable.return(42) }

    before { static_observable.subscribe(@observer) }

    specify { @observer.next.should == 42 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#throw' do
    let(:error) { Exception.new("oops!") }
    let(:observable_throws) { RX::Observable.throw(error) }

    before { observable_throws.subscribe(@observer) }

    specify { @observer.next.should == nil }
    specify { @observer.error.should == error }
    specify { @observer.completed.should == false }
  end

  describe '#generate' do
    let(:generated_observable_range) { RX::Observable.generate(0, lambda {|x| x < 10}, lambda {|x| x}, lambda {|x| x + 1}) }

    before { generated_observable_range.subscribe(@observer) }

    specify { @observer.next.should == 9 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#range' do
    let(:explicit_observable_range) { RX::Observable.range(0, 10) }

    before { explicit_observable_range.subscribe(@observer) }

    specify { @observer.next.should == 9 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  pending '#to_observable' do
    let(:range_to_observable) { (1..10).to_observable }

    before { range_to_observable.subscribe(@observer) }

    specify { @observer.next.should == 9 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#where' do
    let(:observable_range) { RX::Observable.range(0, 10) }
    let(:observable_range_where) { observable_range.where {|x| x % 2 == 0} }

    before { observable_range_where.subscribe(@observer) }

    specify { @observer.next.should == 8 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#select' do
    let(:observable_range) { RX::Observable.range(0, 10) }
    let(:observable_range_where) { observable_range.where {|x| x % 2 == 0} }
    let(:observable_range_where_select) { observable_range_where.select {|x| x * x + x} }

    before { observable_range_where_select.subscribe(@observer) }

    specify { @observer.next.should == 72 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  pending '#select_many' do
    let(:basic_range) { RX::Observable.range(0, 2) }
    let(:merged_range_observables) { basic_range.select_many { |x| RX::Observable.range(x * 25, 2) } }

    before { merged_range_observables.subscribe(@observer) }

    specify { @observer.next.should == 1 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
  end

  describe '#finally' do
    let(:obervable_with_finally) { RX::Observable.return(42).finally { @finally_called = true } }

    before { @finally_called = false }
    before { obervable_with_finally.subscribe(@observer) }

    specify { @observer.next.should == 42 }
    specify { @observer.error.should == nil }
    specify { @observer.completed.should == true }
    specify { @finally_called.should == true }
  end
end