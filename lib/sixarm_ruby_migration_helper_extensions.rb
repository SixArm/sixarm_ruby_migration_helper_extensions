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
        # email: string limit is 320 because the email spec has pieces
        # that total to 320, though then trims the limit to 254.
        #
        def email(column_name=:email)
          column(column_name, :string, limit: 320)
        end

        ##
        # phone: string limit is 75 because that's our arbitrary limit,
        # and long enough for international numbers and extensions.
        #
        def phone(column_name=:phone)
          column(column_name, :string)
        end

        ##
        # uri: string is unlimited.
        #
        def uri(column_name=:uri)
          column(column_name, :string)
        end

        ##
        # hostname: POSIX standard is not to exceed 255 bytes.
        #
        def hostname(column_name=:hostname)
          column(column_name, :string, limit: 255)
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

        def latitude(column_name=:latitude)     column(column_name, :decimal, precision: 13, scale: 10); end
        def longitude(column_name=:longitude)   column(column_name, :decimal, precision: 13, scale: 10); end
        def altitude(column_name=:altitude)     column(column_name, :decimal, precision: 13, scale: 10); end
        def elevation(column_name=:elevation)   column(column_name, :decimal, precision: 13, scale: 10); end

        def geolocation
          latitude
          longitude
          altitude
          elevation
        end

        ##
        #
        # Places
        #
        ##

        # ISO 3166-1 alpha-2 - two-letter country codes which are also used to create the ISO 3166-2 country subdivision codes and the Internet country code top-level domains.
        def iso_3166_1_alpha_2(column_name=:iso_3166_1_alpha_2)
          column(column_name, :string, limit: 2)
        end

        # ISO 3166-1 alpha-3 – three-letter country codes which may allow a better visual association between the codes and the country names than the 3166-1 alpha-2 codes.
        def iso_3166_1_alpha_3(column_name=:iso_3166_1_alpha_3)
          column(column_name, :string, limit: 3)
        end

        # ISO 3166-1 numeric – three-digit country codes which are identical to those developed and maintained by the United Nations Statistics Division, with the advantage of script (writing system) independence, and hence useful for people or systems using non-Latin scripts.
        def iso_3166_1_numeric(column_name=:iso_3166_1_numeric)
          column(column_name, :string, limit: 3)
        end

        ##
        #
        # Administration
        #
        ##

        ##
        # timestamp_string: timestamp strings are good for e.g. log reports;
        # our format has a max length of  "YYYY-DD-MMTHH:MM:SS.NNNNNNNNN+HH:MM".
        #
        def timestamp_string(column_name=:timestamp_string)
          column(column_name, :string, limit: 35)
        end

        ##
        # uuid_string: we sometimes like to use UUID strings;
        # for efficiency, we suggest using a database-native format.
        #
        def uuid_string(column_name=:uuid_string)
          column(column_name, :string, limit: 36)
        end

        ##
        # zid_string: we sometimes like to use ZID strings, similar to UUID stings;
        # for efficiency, we suggest using a database-native format.
        #
        def zid_string(column_name=:zid_string)
          column(column_name, :string, limit: 36)
        end

        ##
        # parent_id: we sometimes use parent-child relationships,
        # where `parent_id` points to the parent row.
        #
        def parent_id(column_name=:parent_id)
          column(column_name, :integer)
        end

        ##
        # position: we sometimes like to use ordered lists,
        # where the `position` is the list position.
        #
        def position(column_name=:position)
          column(column_name, :integer)
        end

        ##
        # state: we sometimes like to use state machines,
        # where the `state` is an integer enumeration.
        #
        def state(column_name=:state)
          column(column_name, :integer)
        end

        ##
        # lock_version: Rails row locking using either
        # optimistic locking or pessimistic locking.
        #
        def lock_version(column_name=:lock_version)
          column(column_name, :integer)
        end

        ##
        # type: Rails single table inheritance (STI)
        # uses a magic field name `type`.
        #
        def type(column_name=:type)
          column(column_name, :string)
        end

        ##
        # auditstamps: we like to track what's happening to a row,
        # by using typical Rails timestamps and then some more.
        #
        def auditstamps
          column(:created_at, :datetime); column(:created_by, :integer);
          column(:updated_at, :datetime); column(:updated_by, :integer);
          column(:proofed_at, :datetime); column(:proofed_by, :integer);
          column(:retired_at, :datetime); column(:retired_by, :integer);
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

        ##
        #
        # Vendor
        #
        ##

        def freebase(column_name=:freebase)
          column(column_name, :string)
        end

      end
    end
  end
end

require "active_record"
if defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
   ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Ddb::SixArm::MigrationHelper)
end
