function buildMetadata(sample) {

  // @TODO: Complete the following function that builds the metadata panel

  // Use `d3.json` to fetch the metadata for a sample
  var metadata = `/metadata/${sample}`;
    // Use d3 to select the panel with id of `#sample-metadata`
    d3.json(metadata).then(function(sample){
      var sampledata = d3.select(`#sample-metadata`);
    // Use `.html("") to clear any existing metadata
    sampledata.html("");
    // Use `Object.entries` to add each key and value pair to the panel
    // Hint: Inside the loop, you will need to use d3 to append new
    // tags for each key-value in the metadata.
    Object.entries(sample).forEach(function([key,value]){
        var row = sampledata.append("h6");
        row.text(`${key}:${value}`)
      })
    });
    // BONUS: Build the Gauge Chart
    // buildGauge(data.WFREQ);
}

function buildCharts(sample) {

  // @TODO: Use `d3.json` to fetch the sample data for the plots
var plot = `/samples/${sample}`;
    // @TODO: Build a Bubble Chart using the sample data
 d3.json(plot).then(function(data){
    var x_axis = data.otu_ids;
    var y_axis = data.sample_values;
    var sample_values = data.sample_values;
    var otu_ids = data.otu_ids;
    var otu_labels = data.otu_labels;
  
    var bubble = {
      x: x_axis,
      y: y_axis,
      text: otu_labels,
      mode: `markers`,
      marker: {
        size: sample_values,
        color: otu_ids
        colorscale:"earth"
      }
    };

    var data = [bubble];
    var layout = {
      title: "Belly Button Biodiversity",
      xaxis: {title: "OTU ID"},
      hovermode: "closest"
    };
    Plotly.newPlot("bubble", data, layout);
    // @TODO: Build a Pie Chart
    d3.json(plot).then(function(data){
      var sample_values = data.sample_values.slice(0,10);
      var otu_ids = data.otu_ids.slice(0,10);
      var otu_labels = data.otu_labels.slice(0,10);

      var piechart = [{
        values: sample_values,
        labels: otu_ids,
        hovertext: otu_labels,
        type: "pie"
      }];
      Plotly.newPlot('pie',piechart);
    });
  });
};
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
