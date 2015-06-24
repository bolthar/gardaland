
var data = null;
var selectedAttraction = null;

var timeIntervals = null;
var chart = null;

var saltasu = new Audio('assets/saltasu.mp3');
var buttagiu = new Audio('assets/buttagiu.mp3');

function setTimeIntervals(opening_time) {
  var from = opening_time.from;
  var to = opening_time.to;
  timeIntervals = [];
  for(var i = from; i < to; i++) {
    timeIntervals.push(i + ":00");
    timeIntervals.push(i + ":30");
  }

  var canvas = $("#chart").get(0).getContext("2d");
  chart = new Chart(canvas).Line({ 
          labels: timeIntervals, 
          datasets: [
              {
                fillColor : "rgba(151,187,205,0.5)",
                strokeColor : "rgba(151,187,205,1)",
                pointColor : "rgba(151,187,205,1)",
                pointStrokeColor : "#fff",
                data : $.map(timeIntervals, function (v, i) { return 0 })
              } 
          ]});
}

function getDataForSelectedDay() {
  var currentDate = $("#datepicker").datepicker("getDate");
  $.getJSON("/api/opening_time/" + $("#datepicker").datepicker("getDate"), function(res) {
    setTimeIntervals(res);
    $.getJSON("/api/date/" + currentDate, function(res) {
      data = res;
      updateGraph();
    });
  });
  $("#dataLabel").html(currentDate);
  saltasu.play();
}

function menuItemFrom(item) {
  var menuItemTemplate = "<li><a href='#' class='menuItem' data-attraction='?attraction_id'>?name</a></li>"
  return menuItemTemplate.replace("?attraction_id", item.id).replace("?name", item.name);
}

function updateGraph() {
  if(data === null || data.length == 0 || selectedAttraction === null)
    return;

  var dataPoints = data.filter(function (o) { return o.attraction_id == selectedAttraction })[0].values;

  var waitingTimes = [];
  $.each(timeIntervals, function(i, time) {
    var targetWaitTime = dataPoints.filter(function (d) { return time == d.time.hour + ":" + (d.time.minute == 30 ? "30" : "00") });
    if(targetWaitTime.length == 1)
    {
      waitingTimes.push(targetWaitTime[0].wait_time);
    } else {
      waitingTimes.push(null);
    }
  });

  for(var i = 0; i < waitingTimes.length;i++)
  {
    chart.datasets[0].points[i].value = waitingTimes[i];
  }

  chart.update();
}

$(function() {
  $("#datepicker").datepicker(
	{
           dateFormat: "dd-mm-yy",
           onSelect: getDataForSelectedDay
  });
  
  getDataForSelectedDay();

  $.getJSON("/api/attractions", function(res) {
    $.each(res, function(i, att) {
      $("#menu").append(menuItemFrom(att));
    });
    $(".menuItem").click(function() {
      selectedAttraction = $(this).attr('data-attraction');
      updateGraph();
      buttagiu.play();
    });
  });


});
