class CreateSubstrates < ActiveRecord::Migration
  def change
    create_table :substrates do |t|
    	t.string :type
    	t.decimal :biogas_per_tonne
    	t.decimal :methane_percent
    	t.decimal :digestate_percent
      t.timestamps
    end
  end
end
