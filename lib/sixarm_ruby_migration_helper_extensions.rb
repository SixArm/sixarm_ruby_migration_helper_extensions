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

