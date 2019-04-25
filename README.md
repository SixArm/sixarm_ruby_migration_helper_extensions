# SixArm.com → Ruby → <br> Migration Helper Extensions for Ruby On Rails ActiveRecord

<!--header-open-->

[![Gem Version](https://badge.fury.io/rb/sixarm_ruby_migration_helper_extensions.svg)](http://badge.fury.io/rb/sixarm_ruby_migration_helper_extensions)
[![Build Status](https://travis-ci.org/SixArm/sixarm_ruby_migration_helper_extensions.png)](https://travis-ci.org/SixArm/sixarm_ruby_migration_helper_extensions)
[![Code Climate](https://api.codeclimate.com/v1/badges/c0c87ef7543e0da158f5/maintainability)](https://codeclimate.com/github/SixArm/sixarm_ruby_migration_helper_extensions/maintainability)

* Git: <https://github.com/SixArm/sixarm_ruby_migration_helper_extensions>
* Doc: <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>
* Gem: <https://rubygems.org/gems/sixarm_ruby_migration_helper_extensions>
* Contact: Joel Parker Henderson, <joel@sixarm.com>
* Project: [changes](CHANGES.md), [license](LICENSE.md), [contributing](CONTRIBUTING.md).

<!--header-shut-->


## Introduction

Ruby On Rails ActiveRecord MigrationHelper extensions

For docs go to <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>

Want to help? We're happy to get pull requests.


<!--install-open-->

## Install

### Gem

To install this gem in your shell or terminal:

    gem install sixarm_ruby_migration_helper_extensions

### Gemfile

To add this gem to your Gemfile:

    gem 'sixarm_ruby_migration_helper_extensions'

### Require

To require the gem in your code:

    require 'sixarm_ruby_migration_helper_extensions'

<!--install-shut-->


## Examples

Migration:

    require "sixarm_ruby_migration_helper_extensions"
    class CreateItems < ActiveRecord::Migration

      def self.up
         create_table 'items' do |t|
           t.timestamps
           t.name
           t.email
           t.phone
           t.height
           t.weight
           t.latitude
           t.longitude
         end
       end

      def self.down
        drop_table 'items'
      end

    end

The result is an item class with fields of the various data types:

    item = Item.new
    item.name = "Statue Of Liberty"
    item.email = "liberty@example.com"
    item.phone = "+1-212-363-3200"
    item.height = 46.50
    item.weight = 204116566
    item.latitude = 40.68913
    item.longitude = -74.0446
    item.save
