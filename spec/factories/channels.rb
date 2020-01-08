FactoryBot.define do
  factory :channel do
    name { Faker::App.name }
    organization
  end

  trait :with_contents do
    contents { [create(:video), create(:gallery), create(:page)] }
  end
end
