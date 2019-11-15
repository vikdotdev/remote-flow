class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :type
      t.string :video_url

      t.timestamps
    end
  end
end
