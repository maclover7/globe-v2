Sequel.migration do
  change do
    add_column :users, :token, :text
  end
end
