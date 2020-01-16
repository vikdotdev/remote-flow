class FixRecordProblem < ActiveRecord::Migration[6.0]
  def change
    Organization.where(token: nil).find_in_batches do |organizations|
      organizations.each do |organization|
        organization.send(:generate_token)
        organization.save
      end
    end
  end
end
