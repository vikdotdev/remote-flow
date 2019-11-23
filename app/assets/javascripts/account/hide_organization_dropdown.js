(function() {
  var userRole = document.getElementById('user_role');
  var userOrganization = document.getElementById('user_organization_id');
  var userOrganizationForm = document.querySelector('.user_organization');

  var fn = function() {
    if (userRole.value == 'super_admin') {
      userOrganizationForm.addClass("d-none");
    } else {
      userOrganizationForm.removeClass("d-none");
    }
  }

  userRole.addEventListener('change', fn);
  userRole.addEventListener('DOMContentLoaded', fn);
}());
