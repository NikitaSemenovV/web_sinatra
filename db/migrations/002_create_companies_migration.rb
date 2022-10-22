Sequel.migration do
  change do
    create_table(:companies, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :null => false
      String :location, :null => false

      DateTime :created_at
      DateTime :upated_at

      index :id
    end
  end
end

