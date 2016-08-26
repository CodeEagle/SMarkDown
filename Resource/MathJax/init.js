(function () {

MathJax.Hub.Config({
	'showProcessingMessages': false,
	'messageStyle': 'none'
});

if (typeof MathJaxListener !== 'undefined') {
	MathJax.Hub.Register.StartupHook('End', function () {
		MathJaxListener.invokeCallbackForKey_('End');
	});
}
 
// MathJax.Hub.Config({ tex2jax: { inlineMath: [['$','$'], ["\\(","\\)"]], processEscapes: true }, TeX: { equationNumbers: { autoNumber: "AMS" } }, messageStyle: "none", SVG: { blacker: 1 }});
// 
})();
