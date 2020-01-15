class AddIconToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :icon, :string
  end
end
