# Zsearch

A simple command line application to search for users, tickets or organizations.

## Installation

Bulid the gem

```ruby
$ gem build zsearch.gemspec
```

And then install it by executing:

    $ gem install ./zsearch-0.1.0.gem

You can remove the installed gem once you have finished using the application by executing

    $ gem uninstall zsearch

## Usage

    $ zsearch entity field [value]
    $ zsearch help [entity]
    
for example you can search for active users
    
    $ zsearch users active true
    
or search for pending tickets

    $ zsearch tickets status pending
    
to list all the search fields of "users" run

    $ zseacrh help users