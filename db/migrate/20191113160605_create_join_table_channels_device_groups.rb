class CreateJoinTableChannelsDeviceGroups < ActiveRecord::Migration[6.0]
  def change
    create_join_table :channels, :device_groups do |t|
      t.index [:channel_id, :device_group_id]
      t.index [:device_group_id, :channel_id]
    end
  end
end
