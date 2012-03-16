require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'sixarm_ruby_active_record_migration_mock'
require 'sixarm_ruby_migration_helper_extensions'

class Testing < Test::Unit::TestCase

 
 def test_columns
  CreateFoos.up
  for col in [:email,:freebase,:height,:latitude,:length,:longitude,:phone,:thickness,:uri,:weight,:width] do
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
      t.freebase
      t.height
      t.latitude
      t.latitude
      t.length
      t.longitude
      t.phone
      t.thickness
      t.uri
      t.weight
      t.width
    end
  end

end
