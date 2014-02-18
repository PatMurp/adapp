class CreateFeedstocks < ActiveRecord::Migration
  def change
    create_table :feedstocks do |t|
    	t.decimal :tonnes
      t.timestamps
    end
  end
end
