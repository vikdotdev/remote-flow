(function() {
  if (!$('#js-dashboard').length) return;

  function thinOut(acc, n, i) {
    if (i % 5 == 0) {
      return (acc.push(n), acc)
    }

    return (acc.push(''), acc)
  }

  var primary = '#5A8DEE';
  var danger = '#FF5B5C';
  var warning = '#FDAC41';
  var info = '#00CFDD';
  var secondary = '#828D99';
  var secondary_light = '#e7edf3';
  var light_primary = "#E2ECFF";

  var data = window.data

  var animations = {
    enabled: true,
    easing: 'easeout',
    speed: 1100,
    animateGradually: {
      enabled: true,
      delay: 550
    }
  };

  var dynamicsChartOptions = {
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
    colors: [primary, primary],
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
        gradientToColors: [light_primary, primary],
        opacityFrom: 0.7,
        opacityTo: 0.55,
        stops: [0, 80, 100]
      }
    },
    series: [{
      name: 'Organizations',
      data: (data.organization_trends ? data.organization_trends.series_data : []),
      type: 'area',
    }],

    xaxis: {
      offsetY: -50,
      categories: (data.organization_trends ? ['', ...data.organization_trends.dates].concat('').reduce(thinOut, []) : []),
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
      labels: {
        show: true,
        style: {
          colors: secondary
        }
      }
    },
    tooltip: {
      x: { show: false },
      y: {
        formatter: function(val) {
          return val;
        }
      }
    }
  };

  if (data.organization_trends) {
    new ApexCharts(document.querySelector("#organization-creation-dynamics"),
      dynamicsChartOptions
    ).render();
  }

  if (data.user_trends) {
    new ApexCharts(
      document.querySelector("#user-creation-dynamics"),
      Object.assign(
        dynamicsChartOptions,
        {
          series: [{
            name: 'Users',
            data: data.user_trends.series_data,
            type: 'area',
          }],
          xaxis: {
            offsetY: -50,
            categories: ['', ...data.user_trends.dates].concat('').reduce(thinOut, []),
            axisBorder: {
              show: false,
            },
            axisTicks: {
              show: false,
            },
            labels: {
              show: true,
              style: {
                colors: secondary
              }
            }
          }
        }
      )
    ).render();
  }

  (function() {
    if(!data || !data.role_distribution) return;

    var chartData = data.role_distribution || {};
    var series = Object.values(chartData).filter(value => !!value);
    var labels = Object.keys(chartData).filter(key => !!chartData[key])
      .map(r => r[0].toUpperCase() + r.slice(1));

    new ApexCharts(document.querySelector("#user-type-chart"), {
      chart: {
        height: 282,
        type: 'donut',
        animations: animations
      },
      series: series,
      labels: labels
    }).render();
  })();

  (function() {
    if(!data || !data.content_type_distribution) return;

    var chartData = data.content_type_distribution || {};
    var series = Object.values(chartData).filter(value => !!value);
    var labels = Object.keys(chartData).filter(key => !!chartData[key]);

    new ApexCharts(document.querySelector("#content-type-chart"), {
      chart: {
        type: 'pie',
        animations: animations,
        height: 282,
      },
      series: series,
      labels: labels
    }).render();
  })();

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
    colors: [info, secondary_light],
    series: [{
      name: 'Today',
      data: [50, 70, 100, 120, 140, 100, 70, 80, 90, 110, 50, 70, 35, 110, 100, 105, 125, 80]
    }, {
      name: 'Yesterday',
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
          colors: secondary
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

