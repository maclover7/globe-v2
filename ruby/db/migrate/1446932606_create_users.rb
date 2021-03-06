Sequel.migration do
  change do
    create_table(:users) do
      text         :email, null: false
      text         :name, null: false
      #---
      uuid         :id, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at, default: Sequel.function(:now), null: false
    end
  end
end
