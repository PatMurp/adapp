class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
    	t.integer "feedstock_id"
    	t.integer "project_id"
    	t.decimal "tonnes" 
      t.timestamps
    end
    add_index("calculations", "feedstock_id")
    add_index("calculations", "project_id")
  end
end
