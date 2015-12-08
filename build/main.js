(function (console) { "use strict";
var bacon_Main = function() { };
bacon_Main.main = function() {
	var bus = new Bacon.Bus();
	bus.push(2);
	bus.onValue(function(i) {
		console.log(i);
	});
};
bacon_Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
