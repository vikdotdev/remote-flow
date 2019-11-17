class CreateGalleryImages < ActiveRecord::Migration[6.0]
  def change
    create_table :gallery_images do |t|
      t.belongs_to :gallery
      t.string :image

      t.timestamps
    end
  end
end
