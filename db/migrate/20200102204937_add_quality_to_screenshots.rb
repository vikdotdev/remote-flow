class AddQualityToScreenshots < ActiveRecord::Migration[6.0]
  def change
    add_column :screenshots, :quality, :string
  end
end
