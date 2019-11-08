class AddOrganizationIdToDeviceGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :device_groups, :organization, null: false, foreign_key: true
  end
end
