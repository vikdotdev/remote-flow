FactoryBot.define do
  factory :notification do
    notification_type { Notification::NOTIFICATION_TYPES.sample }
    user
    association :notificable, factory: :user
  end
end
