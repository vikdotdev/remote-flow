class CreateJoinTableDeviceGroupsDevices < ActiveRecord::Migration[6.0]
  def change
    create_join_table :device_groups, :devices do |t|
      t.index [:device_group_id, :device_id]
      t.index [:device_id, :device_group_id]
    end
  end
end
