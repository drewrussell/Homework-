// from data.js
var tableData = data;
var table = d3.select("tbody");
console.log(data);


data.forEach(function(UFODataset) {
  console.log(UFODataset);
  var row = table.append("tr");
  Object.entries(UFODataset).forEach(function([key, value]) {
    console.log(key, value);
    
    var cell = row.append("td");
    cell.text(value);
  });
});








