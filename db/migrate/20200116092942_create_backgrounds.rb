class CreateBackgrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :backgrounds do |t|
      t.references :organization
      t.string :image

      t.timestamps
    end
  end
end
