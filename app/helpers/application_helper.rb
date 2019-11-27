module ApplicationHelper
  def flash_messages
    return if flash.empty?
    type_translate = {notice: :info, danger: :error, alert: :warning}.with_indifferent_access
    html = ""
    flash.each do |type, message|
      type = type_translate[type] if type_translate[type]
      html << '<script>
      window.onload = function(){
        toastr.' + type.to_s + '("' + message + '", "' + message + '", { positionClass: "toast-top-right", containerId: "toast-top-right" });
      };
      </script>'
    end
    html.html_safe
  end
end
