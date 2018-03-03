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

        ## Common        
        def name          (column_name=:name)       column(column_name, :string)     end

        ## Contact
        def email         (column_name=:email)      column(column_name, :string, limit: 320); t.index(column_name); end
        def phone         (column_name=:phone)      column(column_name, :string)     end
        def uri           (column_name=:uri)        column(column_name, :string)     end

        ## Size
        def height        (column_name=:height)     column(column_name, :decimal, precision: 13, scale: 10) end
        def length        (column_name=:length)     column(column_name, :decimal, precision: 13, scale: 10) end
        def width         (column_name=:width)      column(column_name, :decimal, precision: 13, scale: 10) end
        def depth         (column_name=:depth)      column(column_name, :decimal, precision: 13, scale: 10) end
        def mass          (column_name=:mass)       column(column_name, :decimal, precision: 13, scale: 10) end

        ## Geolocation
        def latitude      (column_name=:latitude)   column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def longitude     (column_name=:longitude)  column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def altitude      (column_name=:altitude)   column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def elevation     (column_name=:altitude)   column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end

        ## Administration
        def parent_id     (column_name=:parent_id)  column(column_name, :integer) end
        def position      (column_name=:position)   column(column_name, :integer) end
        def state         (column_name=:state)      column(column_name, :integer); index(column_name); end
        def uuid_string   (column_name=:uuid)       column(column_name, :string, limit: 36); index(column_name, unique: true);  end

        ## Vendors
        def freebase      (column_name=:freebase)   column(column_name, :string)     end

        ## Database administration
        def dba
          t.string :uuid, :limit => 36; t.index :uuid, unique: true
          t.datetime :created_on; t.index :created_on; t.integer :created_by; t.index :created_by
          t.datetime :updated_on; t.index :updated_on; t.integer :updated_by; t.index :updated_by
          t.datetime :proofed_on; t.index :proofed_on; t.integer :proofed_by; t.index :proofed_by
          t.datetime :retired_on; t.index :retired_on; t.integer :retired_by; t.index :retired_by
          t.integer :state; t.index :state  # State machine enumeration (optional)
          t.integer :lock_version  # Lock version for optimistic/pessimistic locking (optional)
          t.integer :parent_id; t.index :parent_id  # Parent id for parent-child relationship (optional)
          t.integer :position; t.index :position  # Position for list ordering (optional)
          t.string :type; t.index :type  # Single table inheritance magic field name (optional)
        end

        def geolocation
          latitude
          longitude
          altitude
        end

      end
    end
  end
end

require "active_record"
if defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
   ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Ddb::SixArm::MigrationHelper)
end

