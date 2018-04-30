import QtQuick 2.9
import "Rnd.js" as MathFn

Item {
    anchors.fill: parent

    Component.onCompleted: {
        delay(2000, function() {
            timr.running = true
          })
        }

        Timer {
               id: timer
        }

           function delay(delayTime, cb) {
                   timer.interval = delayTime;
                   timer.repeat = false;
                   timer.triggered.connect(cb);
                   timer.start();
        }

        Timer {
               id: timr
               interval: 100
               repeat: true
               running: false

               onTriggered: {
                    bgCanvas.requestAnimationFrame(bgCanvas.tick)
                }
              }

          Canvas {
            id: bgCanvas
            anchors.fill: parent
            renderStrategy: Canvas.Threaded
            property var w: bgCanvas.width
            property var h: bgCanvas.height
            property var ctx
            property var rows
            property var cols
            property var hexGrid
            property var hex
            property var nextT
            property var fadeT
            property var hue
            property var count
            property var grid: [];
            property var watchList: [];
            property var radius: 5;

            function init() {
              nextT = 0
              fadeT = 0
              hue = 0
              count = 0;
              grid = [];
              radius = Math.max(12,h/80);
              hexGrid = buildGrid(w, h, radius);
            }

            function buildGrid(w, h, r) {
               var rowh = r * Math.sin(Math.PI / 3);
               var colW = r * 2 * 1.5;
               rows = Math.ceil(h / rowh) + 1;
               cols = Math.ceil(w / colW) + 1;
               var grid = [];
               for (var row = 0; row < rows; row++) {
                 var y = row * rowh;
                 for (var col = 0; col < cols; col++) {
                   var x = col * colW + (row % 2) * colW / 2;
                   var hex = {col: col, row: row, tol: 1 + MathFn.rnd.float(2), pot: 0};
                   hex.color = Qt.hsla(MathFn.rnd.float(198, 204), 20, MathFn.rnd.float(75, 80), MathFn.rnd.float(0.01, 0.03));
                   hex.x = x;
                   hex.y = y;
                   grid.push(hex);
                 }
               }

               // neighbors:
               for (var i = 0, l = grid.length; i < l; i++) {
                 hex = grid[i];
                 var off = hex.row % 2;
                 col = hex.col;
                 hex.neighbors = [
                   grid[i - cols * 2],
                   col + off < cols ? grid[i - cols + off] : null,
                   col + off < cols ? grid[i + cols + off] : null,
                   grid[i + cols * 2],
                   col + off > 0 ? grid[i + cols - 1 + off] : null,
                   col + off > 0 ? grid[i - cols - 1 + off] : null
                 ];
               }

               return grid;
             }

             function drawGrid(ctx, grid) {
               for (var i = 0, l = grid.length; i < l; i++) {
                 var hex = grid[i];
                 if (!hex.clean) {
                   var m = MathFn.rnd(0.6,1);
                   drawHex(ctx, hex.x, hex.y, hex.color, m, MathFn.rnd(1,radius/6));
                   drawHex(ctx, hex.x, hex.y, hex.color, MathFn.rnd(0.2,m-0.1), MathFn.rnd(1,radius/4));
                   hex.clean = true;
                 }
               }
             }

             function tick() {
               //bgCanvas.requestPaint()
               var delta = (1000 / timr.interval), grid = hexGrid;
               var t = getTime();
               for (var i = watchList.length - 1; i >= 0; i--) {
               var hex = watchList[i];
                 if (!hex) { break; }
                 if (hex.t < t) {
                   removeFromWatch(hex);
                   trigger(hex, t);
                 }
               }

               if (fadeT < t) {
                 ctx.globalCompositeOperation = "destination-in";
                 ctx.fillStyle = Qt.hsla(0, 0, 100, 0.95);
                 ctx.fillRect(0, 0, w, h);
                 ctx.globalCompositeOperation = "lighter";
                 fadeT = t + 250;
               }

               if (t > nextT) {
                 hex = hexGrid[MathFn.rnd.integer(cols) - cols + cols * rows]
                 hex.t = getTime() + MathFn.rnd.float(100, 200);
                 hex.from = 4;//Math.random(6);
                 hex.hue = MathFn.rnd(360);
                 hex.lm = 0.7;
                 hex.chance = 1.2;
                 watchList.push(hex);
                 nextT = getTime() + 200;
               }
               drawGrid(ctx, hexGrid);
             }

             function trigger(hex, t) {
               hex.val = MathFn.rnd(400,900);
               hex.t = t + hex.val;
               hex.clean = false;
               var chance = hex.chance;
               while (MathFn.rnd.boolean(chance)) {
                 var turn = MathFn.rnd.bit(2.5) * MathFn.rnd.sign();
                 var dir = (hex.from + 3 + turn + 6) % 6;
                 var neighbor = hex.neighbors[dir];
                 chance *= 0.25;
                 if (!neighbor || neighbor.t >= t) {
                   continue;
                 }
                 neighbor.val = MathFn.rnd.float(0,1)*MathFn.rnd.float(0,1)*50+5;
                 neighbor.t = t;// + neighbor.val;
                 neighbor.from = (dir + 3) % 6;
                 neighbor.chance = hex.chance * 0.999;
                 neighbor.hue = hex.hue // + Math.random(-3,3)+(dir-3);
                 neighbor.color = Qt.hsla(neighbor.hue, 50, MathFn.rnd(10,35));
                 neighbor.lm = hex.lm;
                 watchList.push(neighbor);
               }
             }

             function removeFromWatch(hex) {
               // this could be improved by switching to a double linked list
               for (var i = watchList.length - 1; i >= 0; i--) {
                 if (hex === watchList[i]) {
                   watchList.splice(i,1);
                 }
               }
             }

             function getTime() {
               return (new Date()).getTime();
             }

             function drawHex(ctx, x, y, fill, m, s) {
               var r = radius-1-s/2;
               r *= m||1;
               r = Math.ceil(r);
               ctx.beginPath();
               var p = Math.PI / 6 * 2;
               for (var i = 0; i < 6; i++) {
                 var x1 = x + Math.cos(p * i) * r, y1 = y + Math.sin(p * i) * r;
                 if (i == 0) {
                   ctx.moveTo(x1, y1);
                 }
                 else {
                   ctx.lineTo(x1, y1);
                 }
               }
               ctx.closePath();
               ctx.strokeStyle = fill;
               ctx.lineWidth = s||1;
               ctx.stroke();
               return ctx;
             }

            onPaint: {
                 //console.log("here")
                 ctx = getContext("2d")
                 init()
               }
            onPainted: {
                bgCanvas.tick()
                }
            }
        }
