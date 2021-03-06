require 'rails_helper'

RSpec.describe Account::UsersController, type: :report do
  let!(:super_admin) { create(:super_admin) }
  let!(:admin) { create(:admin) }

  context 'when regular admin' do
    it 'raises an exception on report creation' do
      expect { OrganizationReport.new(admin) }.not_to raise_error
    end

    it 'raises an exception on collection method' do
      expect { OrganizationReport.new(admin).collection }.to raise_error NoMethodError
    end

    it 'raises an exception on count method' do
      expect { OrganizationReport.new(admin).count }.to raise_error NoMethodError
    end

    it 'raises an exception on trends method' do
      expect { OrganizationReport.new(admin).trends }.to raise_error NoMethodError
    end
  end

  context 'when regular admin' do
    it 'does not raise an exception on report creation' do
      expect { OrganizationReport.new(super_admin) }.not_to raise_error
    end

    it 'does not raise an exception on collection method' do
      expect { OrganizationReport.new(super_admin).collection }.not_to raise_error
    end

    it 'does not raise an exception on count method' do
      expect { OrganizationReport.new(super_admin).count }.not_to raise_error
    end

    it 'does not raise an exception on trends method' do
      expect { OrganizationReport.new(super_admin).trends }.not_to raise_error
    end

    it 'returns correct collection length' do
      expect(OrganizationReport.new(super_admin).count).to eq(Organization.count)
    end

    it 'returns correct trends array lengths' do
      trends = OrganizationReport.new(super_admin).trends
      expect(trends[:series_data].length).to eq(trends[:dates].length + 2)
    end
  end
end

