module DeviceHelper
  def status_badge(active)
    badge_text = active ? 'Active' : 'Inactive'
    badge_class = active ? 'success' : 'danger'
    "<div class='badge badge-light-#{badge_class}'>#{badge_text}</div>".html_safe
  end
end
