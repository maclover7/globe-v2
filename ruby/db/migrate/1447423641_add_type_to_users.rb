Sequel.migration do
  change do
    add_column :users, :type, :text
  end
end
