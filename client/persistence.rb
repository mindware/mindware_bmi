require 'sqlite3'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-validations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/mindware.sqlite3")

class NeuralData
  include DataMapper::Resource

  property :id,         Serial
  property :attention,  Integer
  property :meditation, Integer
  property :created_at, DateTime
end

DataMapper.auto_upgrade!

class Persistence
  def create(attention, meditation)
    NeuralData.new(attention: attention, meditation: meditation).save
  end
end