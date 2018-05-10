export class Gridify {
  options: any = { srcNode: '.item', margin: '20px', width: '250px', max_width: '250px', resizable: true, transition: 'all 0.5s ease' };

  createGrid(selector) {
      var self = selector,
          options = this.options || {},
          indexOfSmallest = function (a) {
              var lowest = 0;
              for (var i = 1, length = a.length; i < length; i++) {
                  if (a[i] < a[lowest]) lowest = i;
              }
              return lowest;
          },
          highestColumn = function (cols) {
              var highest = 0;
              for (var i = 0, length = cols.length; i < length; i++) { if (cols[i] > highest) highest = cols[i];
              }
              return highest;
          },
          attachEvent = function(node, event, cb) {
              if (node.attachEvent)
                  node.attachEvent('on'+event, cb);
              else if (node.addEventListener)
                  node.addEventListener(event, cb);
          },
          detachEvent = function(node, event, cb) {
              if(node.detachEvent) {
                  node.detachEvent('on'+event, cb);
              }
              else if(node.removeEventListener) {
                  node.removeEventListener(event, render);
              }
          },
          render = function() {
              self.style.position = 'relative';
              var items = self.querySelectorAll(options.srcNode),
                  transition = (options.transition || 'all 0.5s ease'),
                  width = self.clientWidth,
                  item_margin = parseInt(options.margin || 0),
                  item_width = parseInt(options.max_width || options.width || 220),
                  column_count = Math.max(Math.floor(width/(item_width + item_margin)),1),
                  left = column_count == 1 ? item_margin/2 : (width % (item_width + item_margin)) / 2,
                  columns = [];
              if (options.max_width) {
                  column_count = Math.ceil(width/(item_width + item_margin));
                  item_width = (width - column_count * item_margin - item_margin)/column_count;
                  left = item_margin/2;
              }
              for (var i = 0; i < column_count; i++) { // WHAT DOES THIS DO! 
                  columns.push(0);
              }
              for (var i= 0, length = items.length; i < length; i++) {
                  var idx = indexOfSmallest(columns);
                  items[i].setAttribute('style', 'width: ' + item_width + 'px; ' +
                      'position: absolute; ' +
                      'visibility: visible; ' + // ADDED THIS
                      'margin: ' + item_margin/2 + 'px; ' +
                      'top: ' + (columns[idx] + item_margin/2) +'px; ' +
                      'left: ' + ((item_width + item_margin) * idx + left) + 'px; ' +
                      'transition: ' + transition);

                  columns[idx] += items[i].clientHeight + item_margin;
              }
              // I've added the bottom margin (300) 
              self.style.height = (highestColumn(columns) + 300)+'px';
              console.log("Gridify rendered");
          };
      render();
      if (options.resizable) {
          attachEvent(window, 'resize', render);
          attachEvent(self, 'DOMNodeRemoved', function(){
              detachEvent(window, 'resize', render);
          });
      }
    };
}
