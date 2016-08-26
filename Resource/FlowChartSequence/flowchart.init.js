(function () {
var flows = document.querySelectorAll("code.language-flow");
var i;
for (i = 0; i < flows.length; i++) {
    var item = flows[i];
    var code = item.textContent;
    var id = "x-flow-"+i;
    item.parentNode.setAttribute("id", id);
    item.parentNode.style.textAlign="center";
    item.parentNode.removeChild(item);
    var diagram = flowchart.parse(code);
  	diagram.drawSVG(id);
}
})();
