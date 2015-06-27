/**
 * jQuery.parseQuerystring
 *
 * Utility to dissect the querysting and return a name/value pair object
 *
 * Copyright (c) 2011 Paul Gueller paul(dot)gueller(at)gmail(dot)com
 * Dual licensed under MIT and GPL.
 * Date: 26-April-2011
 *
 * @author Paul Gueller
 * @version 1.0.2
 *
 * @id jQuery.parseQuerystring
 * @param null
 * @return object name/value pairs
 *
 * @example
 *  url: http://somedomain.com/index.html?id=5&sort=asc
 *	- $.parseQuerystring().id == 5
 *  - var qs = $.parseQuerystring();
 *  - qs.sort == "asc"
 *
 */
;jQuery.extend({
	parseQuerystring: function(){
		var nvpair = {};
		var qs = window.location.search.replace('?', '');
		var pairs = qs.split('&');
		$.each(pairs, function(i, v){
			var pair = v.split('=');
			nvpair[pair[0]] = pair[1];
		});
		return nvpair;
	}
});