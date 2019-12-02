module ApplicationHelper
  def flash_messages
    return if flash.empty?
    type_translate = {notice: :info, danger: :error, alert: :warning}.with_indifferent_access
    html = ""
    flash.each do |type, message|
      type = type_translate[type] if type_translate[type]
      html << '<script>
      window.onload = function(){
        toastr.' + type.to_s + '("' + message + '", { positionClass: "toast-top-right", containerId: "toast-top-right" });
      };
      </script>'
    end
    html.html_safe
  end

  def button_text
    action_name == 'new' ? 'Create' : 'Update'
  end

  def sidebar_button(options = {})
    return if options.empty?

    render 'shared/sidebar_button', options: options
  end

  def breadcrumbs(links = [])
    return if links.empty?

    content_for :breadcrumbs do
      render 'account/shared/breadcrumbs', links: links
    end
  end
end
