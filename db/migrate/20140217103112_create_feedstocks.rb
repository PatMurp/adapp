class CreateFeedstocks < ActiveRecord::Migration
  def change
    create_table :feedstocks do |t|
    	t.string :type
    	t.decimal :tonnes
    	t.decimal :biogas_per_tonne
    	t.decimal :methane_percent
    	t.decimal :digestate_percent
      t.timestamps
    end
  end
end
