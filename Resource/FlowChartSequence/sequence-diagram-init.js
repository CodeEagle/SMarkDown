(function () {
	var ids = ["code.language-seq", "code.language-sequence"]
	var len = ids.length;
	for (var i = 0; i < len; i++) {
	    var id = ids[i]
	    var seqs = document.querySelectorAll(id);
	    var i;
	    for (i = 0; i < seqs.length; i++) {
	        var item = seqs[i];
	        var code = item.textContent;
	        var id = "x-seq-" + i;
	        item.parentNode.setAttribute("id", id);
	        item.parentNode.style.textAlign = "center";
	        item.parentNode.removeChild(item);
	        var diagram = Diagram.parse(code);
	        diagram.drawSVG(id, {
	            theme: 'simple'
	        });
	    }
	}
})();
