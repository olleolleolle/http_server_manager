** 0.5.1 **

Misc:
* Dependency update

** 0.5.0 **

New:
* `HttpServerManager::Server` optionally supports `ping_uri` argument
  * A GET request is used to this uri to determine the availability of the server 

** 0.4.15 **

Misc:
* `rake` is no longer a hard dependency, is only required if rake tasks are in use

** 0.4.14 **

Breaking:
* Dropped Ruby 1.9.3 support (encouraged by `json` gem)

Misc:
* Dependency update

** 0.4.13 **

Misc:
* Dependency update: ```wait_until``` 0.3

** 0.4.12 **

Misc:
* Minor Rake task readability improvements
* Dependency update: ```rspec``` 3.3
