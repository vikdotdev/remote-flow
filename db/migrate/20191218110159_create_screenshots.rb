class CreateScreenshots < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshots do |t|
      t.integer :presentation_id
      t.string :file

      t.timestamps
    end
  end
end
