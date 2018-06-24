# -*- coding: utf-8 -*-
require "minitest/autorun"
require "simplecov"
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
])
SimpleCov.start

require "sixarm_ruby_active_record_migration_mock"
require "sixarm_ruby_migration_helper_extensions"

class Testing < Minitest::Test
 
 def test_columns
  CreateFoos.up
  for col in [
    :email,
    :freebase,
    :height,
    :length,
    :width,
    :depth,
    :mass,
    :latitude,
    :longitude,
    :altitude,
    :length,
    :longitude,
    :phone,
    :uri,
  ] do
    assert(ActiveRecordMigrationMock.tables['foos'].has_column?(col),"has_column?(:#{col})")
  end
 end

end


class ActiveRecordMigrationTableMock
  include Ddb::SixArm::MigrationHelper
end


class CreateFoos < ActiveRecordMigrationMock

  def self.up
    create_table 'foos', :force => true do |t|
      t.email
      t.height
      t.length
      t.width
      t.depth
      t.mass
      t.latitude
      t.longitude
      t.altitude
      t.phone
      t.uri
      t.freebase
    end
  end

end
