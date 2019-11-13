class AddOrganizationIdToDevices < ActiveRecord::Migration[6.0]
  def change
    add_reference :devices, :organization, null: false, foreign_key: true
  end
end
