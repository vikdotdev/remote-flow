(function() {

  var $primary = '#5A8DEE';
  var $danger = '#FF5B5C';
  var $warning = '#FDAC41';
  var $info = '#00CFDD';
  var $secondary = '#828D99';
  var $secondary_light = '#e7edf3';
  var $light_primary = "#E2ECFF";

  var animations = {
    enabled: true,
    easing: 'easeout',
    speed: 1100,
    animateGradually: {
        enabled: true,
        delay: 550
    }
  }

  new ApexCharts(document.querySelector("#order-summary-chart"), {
    chart: {
      height: 284,
      type: 'line',
      stacked: false,
      toolbar: {
        show: false,
      },
      sparkline: {
        enabled: true
      },
      animations: animations
    },
    colors: [$primary, $primary],
    dataLabels: {
      enabled: false
    },
    stroke: {
      curve: 'smooth',
      width: 2.5,
      dashArray: [0, 8]
    },
    fill: {
      type: 'gradient',
      gradient: {
        inverseColors: false,
        shade: 'light',
        type: "vertical",
        gradientToColors: [$light_primary, $primary],
        opacityFrom: 0.7,
        opacityTo: 0.55,
        stops: [0, 80, 100]
      }
    },
    series: [{
      name: 'Weeks',
      data: [165, 175, 162, 173, 160, 195, 160, 170, 160, 190, 180],
      type: 'area',
    }, {
      name: 'Months',
      data: [168, 168, 155, 178, 155, 170, 190, 160, 150, 170, 140],
      type: 'line',
    }],

    xaxis: {
      offsetY: -50,
      categories: ['', 1, 2, 3, 4, 5, 6, 7, 8, 9, ''],
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
      labels: {
        show: true,
        style: {
          colors: $secondary
        }
      }
    },
    tooltip: {
      x: { show: false }
    },
  }).render();

  new ApexCharts(document.querySelector("#user-type-chart"), {
      chart: {
        height: 360,
        type: 'donut',
        animations: animations
      },
      series: [44, 55],
      labels: ['Admin', 'Manager']
    }).render();

  new ApexCharts(document.querySelector("#content-type-chart"), {
      chart: { type: 'pie', animations: animations, height: 360 },
      series: [20, 30, 44, 6],
      labels: ['Page', 'Video', 'Presentation', 'Gallery']
    }).render();

  new ApexCharts(document.querySelector("#logged-in-chart"), {
    chart: {
      height: 100,
      type: 'bar',
      stacked: true,
      animations: animations,
      toolbar: {
        show: false
      }
    },
    grid: {
      show: false,
      padding: {
        left: 0,
        right: 0,
        top: -20,
        bottom: -15
      }
    },
    plotOptions: {
      bar: {
        horizontal: false,
        columnWidth: '20%',
        endingShape: 'rounded'
      },
    },
    legend: {
      show: false
    },
    dataLabels: {
      enabled: false
    },
    colors: [$info, $secondary_light],
    series: [{
      name: '2019',
      data: [50, 70, 100, 120, 140, 100, 70, 80, 90, 110, 50, 70, 35, 110, 100, 105, 125, 80]
    }, {
      name: '2018',
      data: [70, 50, 20, 30, 20, 90, 90, 60, 50, 0, 50, 60, 140, 50, 20, 20, 10, 0]
    }],
    xaxis: {
      categories: ['0', '', '', '', '', "10", '', '', '', '', '', '15', '', '', '', '', '', '20'],
      axisBorder: {
        show: false
      },
      axisTicks: {
        show: false
      },
      labels: {
        style: {
          colors: $secondary
        },
        offsetY: -5
      }
    },
    yaxis: {
      show: false,
      floating: true,
    },
    tooltip: {
      x: {
        show: false,
      },
    }
  }).render();
})();

