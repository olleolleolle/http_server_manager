http_server_manager
====================

Suspends execution until state changes via ```::Wait.until!``` methods.

An alternative to the ```wait``` gem with a focus on readability via:

* Requiring a description of the state change being observed, which is included in any raised timeout exception:

```ruby
    Wait.until_true!("service has started") { service.started? }
```

* Providing alternate ```until``` methods:

```ruby
   Wait.until!("an exception does not occur") { foo.re_try! }
   Wait.until_true!("true is returned") { foo.truthy? }
   Wait.until_false!("false is returned") { foo.falsey? }
```

Usage
-----

* ```gem install http_server_manager```

```ruby
    require 'http_server_manager'

    ::Wait.default_timeout_in_seconds = 5
```

Requirements
------------

* Ruby 1.9.3
