"use strict";Element.prototype.imagesLoaded=function(t){var e=this.querySelectorAll("img"),n=e.length;0==n&&t();for(var i=0,r=e.length;r>i;i++){var o=new Image;o.onload=o.onerror=function(){n--,0==n&&t()},o.src=e[i].getAttribute("src")}},Element.prototype.gridify=function(t){var e=this,t=t||{},n=function(t){for(var e=0,n=1,i=t.length;i>n;n++)t[n]<t[e]&&(e=n);return e},i=function(t,e,n){t.attachEvent?t.attachEvent("on"+e,n):t.addEventListener&&t.addEventListener(e,n)},r=function(t,e,n){t.detachEvent?t.detachEvent("on"+e,n):t.removeEventListener&&t.removeEventListener(e,o)},o=function(){e.style.position="relative";var i=e.querySelectorAll(t.srcNode),r=(t.transition||"all 0.5s ease"),o=e.clientWidth,a=parseInt(t.margin||0),s=parseInt(t.max_width||t.width||220),l=Math.max(Math.floor(o/(s+a)),1),h=1==l?a/2:o%(s+a)/2,d=[];t.max_width&&(l=Math.ceil(o/(s+a)),s=(o-l*a-a)/l,h=a/2);for(var c=0;l>c;c++)d.push(0);for(var c=0,v=i.length;v>c;c++){var u=n(d);i[c].setAttribute("style","width: "+s+"px; position: absolute; margin: "+a/2+"px; top: "+(d[u]+a/2)+"px; left: "+((s+a)*u+h)+"px; transition: "+r),d[u]+=i[c].clientHeight+a}};this.imagesLoaded(o),t.resizable&&(i(window,"resize",o),i(e,"DOMNodeRemoved",function(){r(window,"resize",o)}))};


window.onload = function(){
  var options =
  {
srcNode: '.item',             // grid items (class, node)
         margin: '20px',             // margin in pixel, default: 0px
         width: '250px',             // grid item width in pixel, default: 220px
         max_width: '250px',              // dynamic gird item width if specified, (pixel)
         resizable: true,            // re-layout if window resize
         transition: 'all 0.5s ease' // support transition for CSS3, default: all 0.5s ease
  }
  document.querySelector('.read-grid').gridify(options);
  var items = document.querySelectorAll('.item');
  Array.from(items).forEach(function(item) {
      item.style.visibility = "visible";
      })
}
