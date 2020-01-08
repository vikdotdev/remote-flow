FactoryBot.define do
  factory :notification do
    notification_type { Notification::NOTIFICATION_TYPES.sample }
    user
    association :notificable, factory: :user
  end

  trait :user_added do
    notification_type { Notification::USER_ADDED }
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
