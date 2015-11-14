class User < Sequel::Model
  plugin :single_table_inheritance, :type
  plugin :timestamps, update_on_create: true
end
