FactoryBot.define do
  factory :notification do
    notification_type { Notification::USER_ADDED }
    user
    association :notificable, factory: :user

    trait :user_added do
      notification_type { Notification::USER_ADDED }
    end

    trait :user_deleted do
      notification_type { Notification::USER_DELETED }
    end

    trait :organization_created do
      notification_type { Notification::ORGANIZATION_CREATED }
      notificable { FactoryBot.create(:organization) }
    end

    trait :organization_deleted do
      notificable { FactoryBot.create(:organization) }
      notification_type { Notification::ORGANIZATION_DELETED }
    end
  end
end
