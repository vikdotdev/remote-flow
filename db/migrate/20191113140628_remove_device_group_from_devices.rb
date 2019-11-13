class RemoveDeviceGroupFromDevices < ActiveRecord::Migration[6.0]
  def change
    remove_column :devices, :device_group, foreign_key: true
  end
end
