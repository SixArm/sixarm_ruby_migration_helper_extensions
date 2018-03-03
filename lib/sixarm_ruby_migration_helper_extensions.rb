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
        def name          (column_name=:name)         column(column_name, :string); index(column_name); end

        ## Contact
        def email         (column_name=:email)        column(column_name, :string, limit: 320); index(column_name); end
        def phone         (column_name=:phone)        column(column_name, :string); index(column_name); end
        def uri           (column_name=:uri)          column(column_name, :string); index(column_name); end

        ## Size
        def height        (column_name=:height)       column(column_name, :decimal, precision: 13, scale: 10) end
        def length        (column_name=:length)       column(column_name, :decimal, precision: 13, scale: 10) end
        def width         (column_name=:width)        column(column_name, :decimal, precision: 13, scale: 10) end
        def depth         (column_name=:depth)        column(column_name, :decimal, precision: 13, scale: 10) end
        def mass          (column_name=:mass)         column(column_name, :decimal, precision: 13, scale: 10) end

        ## Geolocation
        def latitude      (column_name=:latitude)     column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def longitude     (column_name=:longitude)    column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def altitude      (column_name=:altitude)     column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end
        def elevation     (column_name=:altitude)     column(column_name, :decimal, precision: 13, scale: 10); index(column_name); end

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

        def freebase(column_name=:freebase) column(column_name, :string) end

        ##
        #
        # Administration
        #
        ##

        # We sometimes like to use UUID strings; for efficiency, we suggest using a database-native format.
        def uuid_string   (column_name=:uuid_string)  column(column_name, :string, limit: 36); index(column_name, unique: true);  end

        # We sometimes like to use parent-child relationships, where `parent_id` points to the parent row.
        def parent_id     (column_name=:parent_id)    column(column_name, :integer); index(column_name); end

        # We sometimes like to use ordered lists, where the `position` is the list position.
        def position      (column_name=:position)     column(column_name, :integer); index(column_name); end

        # We sometimes like to use state machines, where the `state` is an integer enumeration.
        def state         (column_name=:state)        column(column_name, :integer); index(column_name); end

        # Rails row locking using optimistic locking or pessimistic locking
        def lock_version  (column_name=:lock_version) column(column_name, :integer); index(column_name); end

        # Rails single table inheritance (STI) uses a magic field name `type`
        def type          (column_name=:type)         column(column_name, :string); index(column_name); end  

        # We like to track what's happening to a row, by using typical Rails timestamps and then some.
        def auditstamps
          column(:created_on, :datetime); index(:created_on); column(:created_by, :integer); index(:created_by)
          column(:updated_on, :datetime); index(:updated_on); column(:updated_by, :integer); index(:updated_by)
          column(:proofed_on, :datetime); index(:proofed_on); column(:proofed_by, :integer); index(:proofed_by)
          column(:retired_on, :datetime); index(:retired_on); column(:retired_by, :integer); index(:retired_by)
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
        ##

        def dba
          uuid_string
          state
          auditstamps
          lock_version
          parent_id
          position
          lock_version
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

