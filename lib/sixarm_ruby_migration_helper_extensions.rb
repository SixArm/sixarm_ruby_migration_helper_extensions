# -*- coding: utf-8 -*-
=begin rdoc
Please see README
=end

module Ddb
  module SixArm

    module MigrationHelper

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods

        ##
        #
        # Contact
        #
        ##

        ##
        # Name
        #
        def name(column_name=:name)
          column(column_name, :string)
          index(column_name)
        end

        ##
        # email: string limit is 320 because the email spec has pieces
        # that total to 320, though then trims the limit to 254.
        #
        def email(column_name=:email)
          column(column_name, :string, limit: 320)
          index(column_name)
        end

        ##
        # phone: string limit is 75 because that's our arbitrary limit,
        # and long enough for international numbers and extensions.
        #
        def phone(column_name=:phone)
          column(column_name, :string)
          index(column_name)
        end

        ##
        # uri: string is unlimited.
        #
        def uri(column_name=:uri)
          column(column_name, :string)
          index(column_name)
        end

        ##
        #
        # Size
        #
        ##

        def height(column_name=:height)     column(column_name, :decimal, precision: 13, scale: 10) end
        def length(column_name=:length)     column(column_name, :decimal, precision: 13, scale: 10) end
        def width(column_name=:width)       column(column_name, :decimal, precision: 13, scale: 10) end
        def depth(column_name=:depth)       column(column_name, :decimal, precision: 13, scale: 10) end
        def mass(column_name=:mass)         column(column_name, :decimal, precision: 13, scale: 10) end

        ##
        #
        # Geolocation
        #
        ##

        def latitude(column_name=:latitude)     column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def longitude(column_name=:longitude)   column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def altitude(column_name=:altitude)     column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end

        def geolocation
          latitude
          longitude
          altitude
        end

        ##
        #
        # Vendors
        #
        ##

        def freebase(column_name=:freebase)
          column(column_name, :string)
        end

        ##
        #
        # Administration
        #
        ##

        ##
        # uuid_string: we sometimes like to use UUID strings; 
        # for efficiency, we suggest using a database-native format.
        #
        def uuid_string(column_name=:uuid_string)
          column(column_name, :string, limit: 36)
          index(column_name, unique: true)
        end

        ##
        # parent_id: we sometimes use parent-child relationships,
        # where `parent_id` points to the parent row.
        #
        def parent_id(column_name=:parent_id)
          column(column_name, :integer)
          index(column_name)
        end

        ##
        # position: we sometimes like to use ordered lists, 
        # where the `position` is the list position.
        #
        def position(column_name=:position)
          column(column_name, :integer)
          index(column_name)
        end

        ##
        # state: we sometimes like to use state machines, 
        # where the `state` is an integer enumeration.
        #
        def state(column_name=:state)
          column(column_name, :integer)
          index(column_name)
        end

        ##
        # lock_version: Rails row locking using either
        # optimistic locking or pessimistic locking.
        #
        def lock_version(column_name=:lock_version)
          column(column_name, :integer)
          index(column_name)
        end

        ##
        # type: Rails single table inheritance (STI) 
        # uses a magic field name `type`.
        #
        def type(column_name=:type)
          column(column_name, :string)
          index(column_name)
        end  

        ##
        # auditstamps: we like to track what's happening to a row,
        # by using typical Rails timestamps and then some more.
        #
        def auditstamps
          column(:created_at, :datetime); index(:created_at); column(:created_by, :integer); index(:created_by)
          column(:updated_at, :datetime); index(:updated_at); column(:updated_by, :integer); index(:updated_by)
          column(:proofed_at, :datetime); index(:proofed_at); column(:proofed_by, :integer); index(:proofed_by)
          column(:retired_at, :datetime); index(:retired_at); column(:retired_by, :integer); index(:retired_by)
        end

        ##
        # Database administration
        #
        # We build many Rails apps and we like to add some columns
        # that help with database administration and easy growth.
        #
        # We like to add these columns during setup, even if we don't
        # use them, because they make syncronization easy, and they
        # work with some of our data auditing shared code.
        #
        # Use what you like, customize as you like, YMMV, etc.
        #
        def dba
          uuid_string
          auditstamps
          lock_version
          state
          parent_id
          position
          type
        end

      end
    end
  end
end

require "active_record"
if defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
   ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Ddb::SixArm::MigrationHelper)
end
