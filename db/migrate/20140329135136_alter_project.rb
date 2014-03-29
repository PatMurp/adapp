class AlterProject < ActiveRecord::Migration
  def change
  	add_column("projects", "user_id", :integer, :after => "name")
  	add_index("projects", "user_id")
  end
end
