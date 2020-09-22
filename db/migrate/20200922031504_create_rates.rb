class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.string :abbreviation, :length => 3
      t.integer :scale
      t.string :name
      t.float :rate

      t.timestamps      
    end

    add_index :rates, :name, unique: true
  end
end
