=begin rdoc

= SixArm Ruby Gem: Migration Helper Extensions for Ruby On Rails ActiveRecord

Author:: Joel Parker Henderson, joelparkerhenderson@gmail.com
Copyright:: Copyright (c) 2009-2010 Joel Parker Henderson
License:: CreativeCommons License, Non-commercial Share Alike
License:: LGPL, GNU Lesser General Public License

Ruby On Rails ActiveRecord MigrationHelper extensions

==Example Migration

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


==Example Use
    i = Item.new
    i.title = "Statue Of Liberty"
    i.latitude = 40.68913
    i.longitude = -74.0446
    i.email = "statue.of.liberty@example.com"
    i.freebase = "9202a8c04000641f8000000000000687"
    i.height = 46.50  #meters
    i.weight = 204116566  #grams
    i.save

=end


module Ddb
  module SixArm

    module MigrationHelper

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def active    (column_name=:active)     column(column_name, :boolean, :default=>true) end
        def email     (column_name=:email)      column(column_name, :string)     end
        def freebase  (column_name=:freebase)   column(column_name, :string)     end
        def height    (column_name=:height)     column(column_name, :float)      end
        def latitude  (column_name=:latitude)   column(column_name, :float)      end
        def length    (column_name=:length)     column(column_name, :float)      end
        def longitude (column_name=:longitude)  column(column_name, :float)      end
        def name      (column_name=:name)       column(column_name, :string)     end
        def parent_id (column_name=:parent_id)  column(column_name, :integer)    end
        def phone     (column_name=:phone)      column(column_name, :string)     end
        def position  (column_name=:position)   column(column_name, :integer)    end
        def status    (column_name=:status)     column(column_name, :integer)    end
        def thickness (column_name=:thickness)  column(column_name, :float)      end
        def uri       (column_name=:uri)        column(column_name, :string)     end
        def weight    (column_name=:weight)     column(column_name, :float)      end
        def width     (column_name=:width)      column(column_name, :float)      end

      end
    end
  end
end

require 'activerecord'
if defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
   ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Ddb::SixArm::MigrationHelper)
end

