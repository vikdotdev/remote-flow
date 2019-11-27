module DeviceHelper
  def status_badge(device)
    badge_text = device.active ? 'Active' : 'Inactive'
    badge_class = device.active ? 'success' : 'danger'
    "<div class='badge badge-light-#{badge_class}'>#{badge_text}</div>".html_safe
  end
end
