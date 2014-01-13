# The Reactive Extensions for Ruby... #
*...is a set of libraries to compose asynchronous and event-based programs using observable collections and LINQ-style query operators in Ruby*

This is an implementation of the Reactive Extensions for Ruby.  Note that this is an early prototype and contributions are welcome.

This project is a mirror of the [CodePlex](http://rxrb.codeplex.com/) repository.

## About the Reactive Extensions ##

The Reactive Extensions for Ruby (Rx.rb) is a set of libraries for composing asynchronous and event-based programs using observable sequences and fluent query operators modeled after Language Integrated Queries ([LINQ](http://en.wikipedia.org/wiki/LINQ)). Using Rx.rb, developers represent asynchronous data streams with Observables, query asynchronous data streams using LINQ operators, and parameterize the concurrency in the asynchronous data streams using Schedulers. Simply put, Rx.rb = Observables + LINQ + Schedulers.

Using Rx.rb, you can represent multiple asynchronous data streams (that come from diverse sources, e.g., stock quote, tweets, computer events, web service requests, etc.), and subscribe to the event stream using the Observer object. The Observable notifies the subscribed Observer instance whenever an event occurs.

Because observable sequences are data streams, you can query them using standard LINQ query operators implemented by the Observable type. Thus you can filter, project, aggregate, compose and perform time-based operations on multiple events easily by using these static LINQ operators. In addition, there are a number of other reactive stream specific operators that allow powerful queries to be written. Cancellation, exceptions, and synchronization are also handled gracefully by using the methods on the Observable object.

## Contributing ##

There are lots of ways to [contribute](https://github.com/Reactive-Extensions/Rx.rb/wiki/Contributing) to the project, and we appreciate our [contributors](https://github.com/Reactive-Extensions/Rx.rb/wiki/Contributors).

You can contribute by reviewing and sending feedback on code checkins, suggesting and trying out new features as they are implemented, submit bugs and help us verify fixes as they are checked in, as well as submit code fixes or code contributions of your own. Note that all code submissions will be rigorously reviewed and tested by the Rx Team, and only those that meet an extremely high bar for both quality and design/roadmap appropriateness will be merged into the source.

## License ##

Copyright (c) Microsoft Open Technologies, Inc.  All rights reserved.
Microsoft Open Technologies would like to thank its contributors, a list
of whom are at http://rx.codeplex.com/wikipage?title=Contributors.

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License. You may
obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing permissions
and limitations under the License.
