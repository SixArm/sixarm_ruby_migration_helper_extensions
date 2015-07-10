# Ruby » <br> Migration Helper Extensions for Ruby On Rails ActiveRecord

* Doc: <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_migration_helper_extensions>
* Repo: <http://github.com/sixarm/sixarm_ruby_migration_helper_extensions>
<!--HEADER-SHUT-->


## Introduction

Ruby On Rails ActiveRecord MigrationHelper extensions

For docs go to <http://sixarm.com/sixarm_ruby_migration_helper_extensions/doc>

Want to help? We're happy to get pull requests.


<!--INSTALL-OPEN-->

## Install

To install using a Gemfile, add this:

    gem "sixarm_ruby_migration_helper_extensions", ">= 1.0.9, < 2"

To install using the command line, run this:

    gem install sixarm_ruby_migration_helper_extensions -v ">= 1.0.9, < 2"

To install using the command with high security, run this:

    wget http://sixarm.com/sixarm.pem
    gem cert --add sixarm.pem && gem sources --add http://sixarm.com
    gem install sixarm_ruby_migration_helper_extensions -v ">= 1.0.9, < 2" --trust-policy HighSecurity

To require the gem in your code:

    require "sixarm_ruby_migration_helper_extensions"

<!--INSTALL-SHUT-->


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
