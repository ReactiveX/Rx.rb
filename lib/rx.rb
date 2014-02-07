# Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.txt in the project root for license information.

$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require_all 'RX/internal/'
require_all 'RX/concurrency/'
require_all 'RX/subscriptions/'
require_all 'RX/core/'
require_all 'RX/operators'
require_all 'RX/subjects'
require_all 'RX/testing'
