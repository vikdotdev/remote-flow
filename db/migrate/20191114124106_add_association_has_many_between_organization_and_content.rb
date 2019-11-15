class AddAssociationHasManyBetweenOrganizationAndContent < ActiveRecord::Migration[6.0]
  def change
    add_reference :contents, :organization, foreign_key: true
  end
end
