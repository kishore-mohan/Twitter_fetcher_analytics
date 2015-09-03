class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name, :nil => false
      t.timestamps
    end
  end
end
