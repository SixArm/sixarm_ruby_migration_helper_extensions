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
    ## Contact
    :email,
    :phone,
    :uri,
    :hostname,
    ## Size
    :height,
    :length,
    :width,
    :depth,
    :mass,
    ## Geolocation
    :latitude,
    :longitude,
    :altitude,
    :elevation,
    ## Place
    :iso_3166_1_alpha_2,
    :iso_3166_1_alpha_3,
    :iso_3166_1_numeric,
    ## Admin
    :timestamp_string,
    :uuid_string,
    :zid_string,
    ## Vendor
    :freebase,
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
      ## Contact
      t.name
      t.email
      t.phone
      t.uri
      t.hostname
      ## Size
      t.height
      t.length
      t.width
      t.depth
      t.mass
      ## Geolocation
      t.latitude
      t.longitude
      t.altitude
      t.elevation
      ## Place
      t.iso_3166_1_alpha_2
      t.iso_3166_1_alpha_3
      t.iso_3166_1_numeric
      ## Admin
      t.timestamp_string
      t.uuid_string
      t.zid_string
      ## Vendor
      t.freebase
    end
  end

end
