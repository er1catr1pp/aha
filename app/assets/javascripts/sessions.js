var SessionsLib = {};

$(document).on('turbolinks:load', function() {

  if ($('body.sessions.show').length) { 
    google.charts.setOnLoadCallback(SessionsLib.drawFunnelChart);  
  }
  
});


// the funnel chart is drawn as a stacked bar chart
// with an invisible first series serving as a 
// spacer to center the funnel value
SessionsLib.spacerValue = function(category_value) {

  var spacer = (100.0 - category_value) / 2.0;

  return spacer;

}

SessionsLib.drawFunnelChart = function() {

  // read in the data
  var funnelData = $("#funnel-chart-container").data("idea-status-funnel");
  var needsReview = funnelData.needs_review;
  var futureConsideration = funnelData.future_consideration;
  var planned = funnelData.planned;
  var shipped = funnelData.shipped;

  // set up the chart
  var data = google.visualization.arrayToDataTable([
    ['Status', '', '', { role: 'annotation' }, { role: 'annotation' } ],
    ['Needs Review', SessionsLib.spacerValue(needsReview), needsReview, '', needsReview.toFixed(1) + '%' ],
    ['Future Consideration', SessionsLib.spacerValue(futureConsideration), futureConsideration, '', futureConsideration.toFixed(1) + '%' ],
    ['Planned', SessionsLib.spacerValue(planned), planned, '', planned.toFixed(1) + '%' ],
    ['Shipped', SessionsLib.spacerValue(shipped), shipped, '', shipped.toFixed(1) + '%' ]
  ]);
   
  // add chart options
  var options = {
    'title':'Funnel Chart of Ideas by Status',
    'isStacked': true,
    'enableInteractivity': false,
    'colors': ['#FFFFFF','#00AD97'],
    'vAxis': {
      title: "Status", 
      textStyle: {fontSize: 10}
    },
    'hAxis': {title: "Percentage", gridlineColor : 'ffffff'},
    'width':800,
    'height':400,
    'legend': { position: "none" }
 };
  
  // draw the chart
  var chart = new google.visualization.BarChart(document.getElementById('funnel-chart-container'));
  chart.draw(data, options);

}
