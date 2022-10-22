Sequel.migration do
  change do
    create_table(:jobs, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :null => false
      String :place, :null => false

      foreign_key :company_id, :companies

      DateTime :created_at
      DateTime :upated_at

      index :id
    end
  end
end

