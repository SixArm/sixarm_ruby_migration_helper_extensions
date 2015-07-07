# Ruby » <br> Migration Helper Extensions for Ruby On Rails ActiveRecord

* Doc: <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_migration_helper_extensions>
* Repo: <http://github.com/sixarm/sixarm_ruby_migration_helper_extensions>
* Email: Joel Parker Henderson, <joel@sixarm.com>


## Introduction

Ruby On Rails ActiveRecord MigrationHelper extensions

For docs go to <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>

Want to help? We're happy to get pull requests.


## Install quickstart

Install:

    gem install sixarm_ruby_migration_helper_extensions

Bundler:

    gem "sixarm_ruby_migration_helper_extensions", "~>1.0.8"

Require:

    require "sixarm_ruby_migration_helper_extensions"


## Install with security (optional)

To enable high security for all our gems:

    wget http://sixarm.com/sixarm.pem
    gem cert --add sixarm.pem
    gem sources --add http://sixarm.com

To install with high security:

    gem install sixarm_ruby_migration_helper_extensions --trust-policy HighSecurity


## Examples

Migration:

    require "sixarm_ruby_migration_helper_extensions"
    class CreateItems < ActiveRecord::Migration

      def self.up
         create_table 'items' do |t|
           t.timestamps
           t.column :title, :string
           t.latitude
           t.longitude
           t.email
           t.freebase
           t.height
           t.weight
         end
       end

      def self.down
        drop_table 'items'
      end

    end

The result is an item class with fields of the various data types:

    i = Item.new
    i.title = "Statue Of Liberty"
    i.latitude = 40.68913
    i.longitude = -74.0446
    i.email = "statue.of.liberty@example.com"
    i.freebase = "9202a8c04000641f8000000000000687"
    i.height = 46.50  # meters
    i.weight = 204116566  # grams
    i.save
