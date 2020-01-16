class CreateBackgrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :backgrounds do |t|
      t.integer :organization_id
      t.string :image

      t.timestamps
    end

    add_index :backgrounds, :organization_id
  end
end
