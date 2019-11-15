class RemoveColumnChannelIdFromContent < ActiveRecord::Migration[6.0]
  def change
    remove_column :contents, :channel_id
  end
end
