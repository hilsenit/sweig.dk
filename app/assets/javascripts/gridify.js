/**
 * Added a line 83 !!! So i can use visibility and the items aren't width 100% before being columned
 * Created by khanhnh on 13/09/2014.
 */

'use strict';


Element.prototype.imagesLoaded = function (cb){
    var images = this.querySelectorAll('img');
    var count = images.length;
    if (count == 0) cb();
    for (var i= 0, length = images.length; i < length; i++)
    {
        var image = new Image();
        image.onload = image.onerror = function(e){
            count --;
            if (count == 0) cb()
        }
        image.src = images[i].getAttribute('src');
    }
}

Element.prototype.gridify = function (options)
{
    var self = this,
        options = options || {},
        indexOfSmallest = function (a) {
            var lowest = 0;
            for (var i = 1, length = a.length; i < length; i++) {
                if (a[i] < a[lowest]) lowest = i;
            }
            return lowest;
        },
        highestColumn = function (cols) {
            var highest = 0;
            for (var i = 0, length = cols.length; i < length; i++) {
                if (cols[i] > highest) highest = cols[i];
            }
            return highest;
        },
        attachEvent = function(node, event, cb)
        {
            if (node.attachEvent)
                node.attachEvent('on'+event, cb);
            else if (node.addEventListener)
                node.addEventListener(event, cb);
        },
        detachEvent = function(node, event, cb)
        {
            if(node.detachEvent) {
                node.detachEvent('on'+event, cb);
            }
            else if(node.removeEventListener) {
                node.removeEventListener(event, render);
            }
        },
        render = function()
        {
            self.style.position = 'relative';
            var items = self.querySelectorAll(options.srcNode),
                transition = (options.transition || 'all 0.5s ease'),
                width = self.clientWidth,
                item_margin = parseInt(options.margin || 0),
                item_width = parseInt(options.max_width || options.width || 220),
                column_count = Math.max(Math.floor(width/(item_width + item_margin)),1),
                left = column_count == 1 ? item_margin/2 : (width % (item_width + item_margin)) / 2,
                columns = [];
            if (options.max_width)
            {
                column_count = Math.ceil(width/(item_width + item_margin));
                item_width = (width - column_count * item_margin - item_margin)/column_count;
                left = item_margin/2;
            }
            for (var i = 0; i < column_count; i++)
            {
                columns.push(0);
            }
            for (var i= 0, length = items.length; i < length; i++)
            {
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
            self.style.height = highestColumn(columns)+'px';
        };
    this.imagesLoaded(render);
    if (options.resizable)
    {
        attachEvent(window, 'resize', render);
        attachEvent(self, 'DOMNodeRemoved', function(){
            detachEvent(window, 'resize', render);
        });
    }
};


window.onload = function(){
  var options =
  {
srcNode: '.item',             // grid items (class, node)
         margin: '20px',             // margin in pixel, default: 0px
         width: '250px',             // grid item width in pixel, default: 220px
         max_width: '250px',              // dynamic gird item width if specified, (pixel)
         resizable: true,            // re-layout if window resize
         transition: 'opacity 0.5s ease' // support transition for CSS3, default: all 0.5s ease
  }
  document.querySelector('.read-grid').gridify(options);

  var one_row_btn = document.getElementById('oneRow');
  one_row_btn.addEventListener('click', function() {
    var width = window.innerWidth / 2;
    var read_grid = document.querySelector('.read-grid');
    read_grid.style.margin = "0 auto";
    read_grid.style.width = width + "px";
    options.width, options.max_width = width;
    read_grid.gridify(options);
  });

};

