FactoryBot.define do
  factory :notification do
    before(:create) { FactoryBot.create(:organization) }
    notification_type { Notification::ORGANIZATION_CREATED }
    user
    association :notificable, factory: :user

    trait :user_added do
      notification_type { Notification::USER_ADDED }
      notifiable { manager } unless notifiable
    end

    trait :user_deleted do
      notification_type { Notification::USER_DELETED }
    end

    trait :organization_created do
      notification_type { Notification::ORGANIZATION_CREATED }
    end

    trait :organization_deleted do
      notification_type { Notification::ORGANIZATION_DELETED }
    end
  end
end
