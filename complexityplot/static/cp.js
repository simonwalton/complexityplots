
(function() {

var cp_static_dir = ""; // to be set via django template
var cp_data_dir = "datasets";

var cp_classes = ["1","<i>ln</i> n","n","n <i>ln</i> n","n&sup2;","n&sup2;<i>ln</li> n","n&sup3","1.5&#8319;","2&#8319;","3&#8319;"];
var cp_classes_plain = ["1","lnN","n","n ln n","n^2","n^2 ln n","n^3","1.5^n","2^n","3^n"];
var cp_class_order = [0,1,2,3,4,5,6,7,8,9,10]; // currently unused
var cp_baseline_data = new Array();
var cp_eta = 20;
var cp_beta = 90; // in paper \beta, the signature baseline

var num_estimators = 3;

var cp_colors = [
	["#1B9E77","#D95F02","#7570B3","#E7298A","#66A61E","#E6AB02","#A6761D","#666666"],
	["#E41A1C","#377EB8","#4DAF4A","#984EA3","#FF7F00","#FFFF33","#A65628","#F781BF"],
	["#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99","#E31A1C","#FDBF6F","#FF7F00"],
	["#FBB4AE","#B3CDE3","#CCEBC5","#DECBE4","#FED9A6","#FFFFCC","#E5D8BD","#FDDAEC"]
];

util_gen_guid = function() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}

util_modulate_color = function(hex, opacity) {
	opacity = opacity < 0.3 ? 0.3 : opacity;
	rgb = util_hex_to_rgb(hex);
	for(var i=0;i<3;i++)
		rgb[i] = (1.0-opacity)*255 + (opacity*rgb[i]);
	return util_rgb_to_hex(rgb);
}

util_hex_to_rgb = function(hex) {
	function cutHex(h) {return (h.charAt(0)=="#") ? h.substring(1,7):h}
    var r = parseInt((cutHex(hex)).substring(0,2),16), g = parseInt((cutHex(hex)).substring(2,4),16), b = parseInt((cutHex(hex)).substring(4,6),16)
    return [r,g,b];
}

util_rgb_to_hex = function(rgb) {
	return "#" +
		("0" + parseInt(rgb[0],10).toString(16)).slice(-2) +
		("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
		("0" + parseInt(rgb[2],10).toString(16)).slice(-2);
};

cp_color_choices_html = function() {
	var html = '<div id="color_choices" class="btn-group btn-group-vertical" data-toggle="buttons">';
	for(var i in cp_colors) {
		html += '<label class="btn btn-colour-scheme cp_color_palette"><input type="radio" class="" name="btn-colour-scheme">';
		for(var j in cp_colors[i]) {
			html += '<div class="cp_color_palette_item" style="background-color:' + cp_colors[i][j] + '"></div>';
		}
		html += '</label>';
	}
	html += "</div>";
	return html;
};

cp_plot = function() {
	this.cp_svg = null;				// svg object
	this.cp_element_name = "#chart";		// element name
	this.cp_width = 800;
	this.cp_height= 600;
	this.cp_use_legend = true;
	this.cp_show_y_axis = true;
	this.cp_show_x_axis_label = true;
	this.cp_vertical_x_labels = false;
	this.cp_margins = {top:0,right:0,bottom:0,left:0};
	this.cp_input_files = [];
	this.cp_colour_scheme = 0;
	this.cp_line_width = 2;
	this.cp_readonly = true;
	this.cp_show_baseline = true;
	this.cp_use_sci_notation = false;
	this.cp_on_change = function() { console.log("Warning: cp_plot::cp_on_change unimplemented.")};
	this.cp_title = "";
	this.cp_enabled_classes = [];
	this.cp_desc = "";
	this.cp_public = false;
	this.cp_auto_zoom = false;

	this._redraw_in_progress = false;

	this.destruct = function() {
		d3.select(this.cp_element_name).select('svg').remove();
		this.cp_svg = null;
	}

	this.is_IE = function() {
		return Function('/*@cc_on return document.documentMode===10@*/')();
	}

	this.cp_class_names_html = function() {
		return cp_classes;
	}

	this.cp_defaults = function() {
		this.cp_style_defaults();
		this.cp_attr_defaults();
	}

	this.cp_style_defaults = function() {
		this.cp_show_baseline = true;
	    this.cp_use_sci_notation = false;
	    this.cp_line_width = 1;
		this.cp_colour_scheme = 0;
		this.cp_auto_zoom = false;
		this.cp_enabled_classes = [];
		for(var i=0;i<cp_classes.length;i++)
			this.cp_enabled_classes.push(i);
	}

	this.cp_attr_defaults = function() {
	    this.cp_title = "Untitled plot (name me!)";
		this.cp_desc = "This is a description of my new plot.";
	}

	this.cp_get_input_files = function() {
		return this.cp_input_files;
	};

	this.cp_set_input_files = function(arr) {
		this.cp_input_files = arr;
	}

	this.cp_add_blank_series = function() {
		this.cp_input_files.push(['Unnamed','Unnamed','Unnamed']);
	}

	this.cp_has_data = function() {
		return this.cp_input_files.length != 0;
	}

	this.cp_remove_series = function(idx) {
		if(this.cp_readonly)
			return;
		this.cp_input_files.splice(idx,1);
		this.cp_on_change();
	}

	this.cp_set_line_width = function(width) {
		this.cp_line_width = width;
		this.cp_svg.selectAll(".line")
			.attr("stroke-width",this.cp_line_width);
	};

	this.cp_get_line_width = function() {
		return this.cp_line_width;
	};

	this.cp_setup_svg = function() {
		if(!this.cp_has_data()) {
			d3.select(this.cp_element_name).select('svg').remove();
			return;
		}

		this.x = d3.scale.linear().domain(cp_classes)
			.range([0, this.cp_width]);

		this.y = d3.scale.linear()
			.range([this.cp_height, 0]);

		this.xAxis = d3.svg.axis()
			.scale(this.x)
			.orient("bottom");

		this.yAxis = d3.svg.axis()
			.scale(this.y)
			.orient("left");

		if(this.cp_svg != null)
			d3.select(this.cp_element_name).select("svg").remove();

		this.cp_svg = d3.select(this.cp_element_name).append("svg")
			.attr("width", this.cp_width + this.cp_margins.left + this.cp_margins.right)
			.attr("height", this.cp_height + this.cp_margins.top + this.cp_margins.bottom)
			.append("g")
			.attr("transform", "translate(" + this.cp_margins.left + "," + this.cp_margins.top + ")");

	}

	this.cp_view_domain = function() {
		return [this.cp_enabled_classes[0],this.cp_enabled_classes[this.cp_enabled_classes.length-1]];
	}

	this.cp_setup_x_axis = function() {
		this.xTicks = this.x.ticks(this.cp_view_domain()[1] - this.cp_view_domain()[0]);
		console.log(this.xTicks);
		console.log(this.x.domain());
		console.log(this.cp_view_domain());

		var xax = this.cp_svg.append("g")
			.attr("class", "x axis")
			.attr("transform", "translate(0," + (this.cp_height) + ")");

		if(this.cp_show_x_axis_label) {
			xax.append("text")
				.attr("class","label")
				.attr("x", this.cp_width / 2)
				.attr("y", 40)
				.attr("text-anchor","middle")
				.text("Complexity Class");
		}

		var self = this;
		var text_label_func = function(d) {
			return cp_classes_plain[self.cp_enabled_classes[d]];
		}
		var html_label_func = function(d) {
			return cp_classes[self.cp_enabled_classes[d]];
		}

		if(!this.cp_vertical_x_labels) {
			if(this.is_IE()) {
				// sorry, IE users. You don't get pretty axis text.
				this.cp_svg.append("g")
					.attr("class","x axis")
					.call(d3.svg.axis().scale(this.x).orient("bottom").tickSize(0).tickPadding(0).tickFormat(text_label_func))
					.attr("transform", "translate(0," + this.cp_height + ")");
			}
			else {
				this.cp_svg.append("g")
					.attr("class","x axis")
					.call(d3.svg.axis().scale(this.x).orient("bottom").tickSize(0).tickPadding(0).tickFormat(function(d) {return '';}))
					.attr("transform", "translate(0," + this.cp_height + ")")
					.selectAll('g')
					.append("svg:foreignObject")
					.attr("width",40).attr("height",20)
					.append("xhtml:div")
					.html(html_label_func);
			}
		}
		else {
			if(this.is_IE()) {
				// sorry, IE users. You don't get pretty axis text.
				this.cp_svg.append("g")
					.attr("class","x axis")
					.attr("transform","translate(0," + this.cp_height + ")")
					.call(this.xAxis)
					.selectAll("text")
					.text(text_label_func)
					.attr("text","text")
					.attr("transform", "translate(0,-20),rotate(-90)")
					.attr("width",40).attr("height",20);
			}
			else {
				this.cp_svg.append("g")
					.attr("class","x axis")
					.call(d3.svg.axis().scale(this.x).orient("bottom").tickSize(0).tickPadding(0).tickFormat(function(d) {return '';}))
					.attr("transform", "translate(0," + this.cp_height + ")")
					.selectAll('g')
					.append("svg:foreignObject")
					.attr("transform", "rotate(-90),translate(0,-5)")
					.attr("width",40).attr("height",20)
					.append("xhtml:div")
					.html(html_label_func);
			}
		}

		this.cp_svg.selectAll("xbar")
			.data(this.xTicks)
			.enter()
			.append("svg:line")
			.attr("class","xbar")
			.attr("x1",this.x)
			.attr("y1",0)
			.attr("x2",this.x)
			.attr("y2",this.cp_height);

		this.xAxis.tickFormat(html_label_func);
	};

	/*
	* precompute certainty array
	*/
	this.compute_certainty_table = function() {
		this.certainty = new Array(this.datums.length);
		for(s in this.datums) {
			series = this.datums[s];
			cert = new Array(series.length);
			for(var i=2;i<series.length-1;i++) {
				cert[i] = Math.abs(series[i][1]-series[i-1][1])/Math.abs(series[i-1][1]-series[i-2][1]);
				cert[i] = cert[i] > 2.0 ? 1.0 : 0.5 * cert[i];
				cert[i] = 1.0-cert[i];
			}
			var certS = new Array(series.length);
			certS[0] = certS[1] = certS[2];
			for(var i=2;i<series.length-2;i++) {
				certS[i] = (cert[i-2] + cert[i-1] + cert[i] + cert[i+1] + cert[i+2]) / 5.0;
			}
			certS[series.length-1] = certS[series.length-2] = certS[series.length-3];

			this.certainty[s] = certS;
		}
	}

	this.cp_setup_signature_baseline = function() {
		if(!this.cp_show_baseline)
			return;

		if(this.datums[0].length < cp_beta)
			return;

		this.cp_svg.append("line")
			.attr("y1", this.y(+this.datums[0][cp_beta][0]))
			.attr("y2", this.y(+this.datums[0][cp_beta][0]))
			.attr("x1", 0)
			.attr("x2", this.cp_width)
			.attr("stroke","#AAA")
			.attr("stroke-dasharray","5,5")
			.attr("stroke-width","1")
	}

	this.cp_static_link_for_data_series = function(idx) {
		return cp_static_dir + cp_data_dir + "/" + this.cp_input_files[idx][1]
	}

	this.cp_redraw = function() {
		if(this._redraw_in_progress)
			return;

		this._redraw_in_progress = true;
		this.cp_setup_svg();

		// draw state
		this.files_loaded = 0;
		this.datums = new Array();
		this.certainty = new Array();
		this.curr_y_domain = [100000,-100000];

		if(this.cp_input_files.length == 0) {
			this._redraw_in_progress = false;
			return;
		}

		for(data_idx_outer in this.cp_input_files) {
			var myObj = function(obj) {
				return function() {
					return obj;
				}
			}
			var selfObj = myObj(this);

			d3.text(this.cp_static_link_for_data_series(data_idx_outer), "text/csv", function(text) {
				data = d3.csv.parseRows(text);
				self = selfObj();

				this_domain = d3.extent(data, function(d) { return +d[0]; });
				if(this_domain[0] < self.curr_y_domain[0])
					self.curr_y_domain[0] = this_domain[0];
				if(this_domain[1] > self.curr_y_domain[1])
					self.curr_y_domain[1] = this_domain[1];

				self.datums.push(data);
				if(self.cp_check_all()) {
					self.cp_complete();
				}
			});
		}
	}


	this.cp_baseline_lookup = function(est_idx, complexity_idx,n) {
		if(n >= cp_baseline_data.length)
			n = cp_baseline_data.length-1;
		return cp_baseline_data[n][complexity_idx * num_estimators + est_idx];
	}

	this.cp_map_est = function(d) {
		/*
		* the spatial mapping function
		*/
		var v = +d[1];
		var n = +d[0];
		if(n >= cp_beta)
			n = cp_beta-1;

		var c = 0;

		// assume estimator 1, find pair s.t. p1 <= x <= p2
		for(c=0;c<this.cp_enabled_classes.length-1;c++) {
			var clsa = this.cp_enabled_classes[c];
			var clsb = this.cp_enabled_classes[c+1];
			var v1 = this.cp_baseline_lookup(0,clsa,n);
			var v2 = this.cp_baseline_lookup(0,clsb,n);
			if(v >= v1 && v <= v2) {
				break;
			}
		}

		// interpolate between
		var v1 = this.cp_baseline_lookup(0,clsa,n);
		var v2 = this.cp_baseline_lookup(0,clsb,n);
		var offset = (v-v1)/(v2-v1);
		return c + offset;
	}


	this.cp_check_all = function() {
		this.files_loaded++;
		return this.files_loaded == this.cp_input_files.length;
	}

	this.cp_decide_x_domain = function() {
/*		if(!this.cp_auto_zoom) {
			var xdom = [99999999,-99999999];

			for(data_idx in this.datums) {
				var minmax = d3.extent(this.datums[data_idx], function(el) {
					return +self.cp_map_est(el);
				});
				if(minmax[0] < xdom[0]) xdom[0] = minmax[0];
				if(minmax[1] > xdom[1]) xdom[1] = minmax[1];
			}

			if(xdom[0] != 0) xdom[0]-=0.5;
			if(xdom[1] != cp_classes.length-1) xdom[1]+=0.5;
			this.x.domain([xdom[0],xdom[1]]);
			console.log("X data domain: " + [xdom[0],xdom[1]]);
		}
		else {*/
			this.x.domain([0,this.cp_enabled_classes.length-1]);
		//}
	}

	this.cp_complete = function() {
		self = this;
		this.files_loaded = 0;

		this.compute_certainty_table();
		this.y.domain([this.curr_y_domain[0],this.curr_y_domain[1]]);

		var line = d3.svg.line()
			.x(function(d,i) { return this.x(self.cp_map_est(d)); })
			.y(function(d,i) { return this.y(+d[0]); });

		if(this.cp_show_y_axis) {
			this.cp_svg.append("g")
				.attr("class", "y axis")
				.call(this.yAxis)
				.append("text")
				.attr("transform", "rotate(-90)")
			.attr("y", 6)
			.attr("dy", ".71em")
			.style("text-anchor", "end")
			.attr("class", "label")
			.text("Input Size");
		}

		this.cp_decide_x_domain();
		this.cp_setup_x_axis();
		this.cp_setup_signature_baseline();

		for(data_idx in this.datums) {
			self = this;
			series = this.datums[data_idx];

			var p = this.cp_svg.selectAll("line"+data_idx)
				.data(series)
				.enter()
				.append("line")
				.filter(function(d,i) { return i > 0 && i < series.length-1; })
				.attr("x1", function(d,i) { return self.x(self.cp_map_est(series[i])); })
				.attr("y1", function(d,i) { return self.y(+series[i][0]); })
				.attr("x2", function(d,i) { return self.x(self.cp_map_est(series[i+1])); })
				.attr("y2", function(d,i) { return self.y(+series[i+1][0]); })
				.attr("stroke",function(d,i) { return util_modulate_color(cp_colors[self.cp_colour_scheme][data_idx],self.certainty[data_idx][i]); })
				.attr("stroke-width",this.cp_line_width)
				.attr("stroke-linecap","round")
				.attr("fill","none");

			if(this.cp_use_legend) {
				this.cp_svg.append("text")
					.datum(this.cp_input_files[data_idx])
					.text(function(d) { return d[2];})
					.attr('x',this.cp_width-10)
					.attr('y',data_idx*20)
					.attr('text-anchor','end')

				var circle = this.cp_svg.append("svg:circle")
					.attr("r",5)
					.attr("class","legend-circle")
					.attr('cx',this.cp_width-2.5)
					.attr('cy',data_idx*20-4)
					.attr('fill',cp_colors[this.cp_colour_scheme][data_idx]);

				if(!this.cp_readonly) {
					var removeFn = function(d) {
						return function() {
							self.cp_remove_series(d);
						};
					}
					circle.on("mouseover", function(d,i) {
						$(this).attr('stroke','black');
						$(this).attr('stroke-width','2px');
					});
					circle.on("mouseout", function(d,i) {
						$(this).attr('stroke','none');
					});
					circle.on("click", removeFn(data_idx));
				}
			}
		}

		self._redraw_in_progress = false;
	}
}

cp_init = function(static_dir) {
cp_static_dir = static_dir;

	function read_baseline() {
		d3.text(static_dir + "baseline.csv", "text/csv", function(text) {
			cp_baseline_data =  d3.csv.parseRows(text);
		});
	}

	// init
	read_baseline();
}
})();
