AnyLogin.setup do |config|
  config.name_method = proc { |e| [[e.email, e.role].join(' || '), e.id] }
  config.enabled = true unless Rails.env == 'test'
end
