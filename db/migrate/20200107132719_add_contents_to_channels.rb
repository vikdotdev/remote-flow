class AddContentsToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :contents, :integer, array: true, default: []
  end
end
