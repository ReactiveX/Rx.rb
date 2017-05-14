# Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.txt in the project root for license information.

$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
module RxRequireAll
  def self.require_all(path)
    glob = File.join(File.dirname(__FILE__), path, '*.rb')
    Dir[glob].sort.each do |f|
      require f
    end
  end
end

RxRequireAll.require_all 'rx/internal/'
RxRequireAll.require_all 'rx/concurrency/'
RxRequireAll.require_all 'rx/subscriptions/'
RxRequireAll.require_all 'rx/core/'
RxRequireAll.require_all 'rx/linq/'
RxRequireAll.require_all 'rx/linq/observable/'
RxRequireAll.require_all 'rx/operators/'
RxRequireAll.require_all 'rx/subjects/'
RxRequireAll.require_all 'rx/testing/'
RxRequireAll.require_all 'rx/joins/'
RxRequireAll.require_all 'rx/'
