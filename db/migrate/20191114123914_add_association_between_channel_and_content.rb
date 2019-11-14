class AddAssociationBetweenChannelAndContent < ActiveRecord::Migration[6.0]
  def change
    create_join_table :channels, :contents do |t|
      t.index [:channel_id, :content_id]
      t.index [:content_id, :channel_id]
    end
  end
end
