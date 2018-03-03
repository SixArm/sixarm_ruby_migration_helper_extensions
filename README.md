# SixArm.com → Ruby → <br> Migration Helper Extensions for Ruby On Rails ActiveRecord

<!--header-open-->

* Doc: <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_migration_helper_extensions>
* Repo: <http://github.com/sixarm/sixarm_ruby_migration_helper_extensions>

<!--header-shut-->


## Introduction

Ruby On Rails ActiveRecord MigrationHelper extensions

For docs go to <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>

Want to help? We're happy to get pull requests.


<!--install-open-->

## Install

To install using a Gemfile, add this:

    gem "sixarm_ruby_migration_helper_extensions", ">= 1.0.9", "< 2"

To install using the command line, run this:

    gem install sixarm_ruby_migration_helper_extensions -v ">= 1.0.9, < 2"

To install using the command line with high security, run this:

    wget http://sixarm.com/sixarm.pem
    gem cert --add sixarm.pem && gem sources --add http://sixarm.com
    gem install sixarm_ruby_migration_helper_extensions -v ">= 1.0.9, < 2" --trust-policy HighSecurity

To require the gem in your code:

    require "sixarm_ruby_migration_helper_extensions"

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
    item.phone = "+1 (212) 363-3200"
    item.height = 46.50
    item.weight = 204116566
    item.latitude = 40.68913
    item.longitude = -74.0446
    item.save
