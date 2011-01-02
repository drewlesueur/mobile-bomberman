(function() {
  $(document).ready(function() {
    window.ws = new WebSocket("ws://bomber.the.tl:9998/");
    ws.onopen = function() {
      console.log("open");
      return ws.send("hahaha");
    };
    ws.onmessage = function(e) {
      var data;
      console.log("data is", e.data);
      data = JSON.parse(e.data);
      console.log(data);
      return app[data[0]](data[1]);
    };
    ws.onclose = function(e) {
      return console.log("closed!!");
    };
    return ws.onerror = function(e) {
      return console.log("error");
    };
  });
  window.app = {};
  app.addField = function() {
    app.field = document.createElement("div");
    $(app.field).css({
      height: "320px",
      width: "320px"
    });
    $(app.field).attr("id", "field");
    return $('#wrapper').append(app.field);
  };
  app.log = function(str) {
    return console.log(str);
  };
  app.tileWidth = 32;
  app.tileHeight = 32;
  app.renderScreen = function(tiles) {
    var cell, row, str, tile, x, y, _i, _j, _len, _len2, _results;
    app.addField();
    console.log("rendering screen");
    x = 0;
    y = 0;
    if (_.isString(tiles)) {
      tiles = tiles.split("\n");
    }
    _results = [];
    for (_i = 0, _len = tiles.length; _i < _len; _i++) {
      row = tiles[_i];
      if (_.isString(row)) {
        row = row.split("");
      }
      for (_j = 0, _len2 = row.length; _j < _len2; _j++) {
        cell = row[_j];
        if (_.isString(cell)) {
          str = cell;
          cell = {};
          if (str === "-") {
            cell.color = "green";
          } else if (str === "o") {
            cell.color = "#aaaaaa";
          }
        }
        tile = document.createElement("div");
        if ("color" in cell) {
          $(tile).css({
            "background-color": cell.color
          });
        }
        $(tile).attr("data-pos", "" + x + "," + y).css({
          position: "absolute",
          left: app.tileWidth * x + "px",
          top: app.tileHeight * y + "px",
          width: app.tileWidth + "px",
          height: app.tileHeight + "px"
        });
        $('#field').append(tile);
        x++;
      }
      x = 0;
      _results.push(y++);
    }
    return _results;
  };
}).call(this);
