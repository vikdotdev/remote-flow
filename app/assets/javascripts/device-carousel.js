$(document).ready(function(){
  $(".owl-carousel").owlCarousel({
    center: true,
    loop: true,
    responsive: {
      0: {
        items: 2,
      },
      480: {
        items: 3,
      },
      768: {
        items: 4,
      },
      1024: {
        items: 6,
      },
      1200: {
        items: 8,
      }
    }
  });
});

