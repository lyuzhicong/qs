//AMD 或 CommonJS Modules检测
(function(root, factory) {
	if (typeof define === 'function' && define.amd) {
		define(factory);
	} else if (typeof exports === 'object') {
		module.exports = factory(require, exports, module);
	} else {
		root.SVG = factory();
	}
}(this, function(require, exports, module) {

	// 模块代码开始
	var SVG = this.SVG = function(element) {
		if (SVG.supported) {
			element = new SVG.Canvas(element);
			return element;
		}
	};

	// Default namespaces
	SVG.ns = 'http://www.w3.org/2000/svg';
	SVG.xmlns = 'http://www.w3.org/2000/xmlns/';
	SVG.xlink = 'http://www.w3.org/1999/xlink';

	// Svg support test
	SVG.supported = (function() {
		return !!document.createElementNS && !!document.createElementNS(SVG.ns, 'svg').createSVGRect;
	})();
	// Don't bother to continue if SVG is not supported
	if (!SVG.supported)
		return false;

	// Element id sequence
	SVG.did = 1000;

	// Get next named element id
	SVG.eid = function(name) {
		return 'ts-' + name + (SVG.did++);
	};

	// Method for element creation
	SVG.create = function(name) {
		// create element
		var element = document.createElementNS(this.ns, name);

		// apply unique id
		element.setAttribute('id', this.eid(name));
		return element
	};

	// Method for extending objects
	SVG.extend = function() {
		var modules, methods, key, i;

		// Get list of modules
		modules = [].slice.call(arguments);

		// Get object with extensions
		methods = modules.pop();

		for (i = modules.length - 1; i >= 0; i--)
			if (modules[i])
				for (key in methods)
					modules[i].prototype[key] = methods[key];
	};

	// Invent new element
	SVG.invent = function(config) {

		if (typeof Object.create !== 'function') {
			Object.create = function(proto) {
				function F() {
				}
				;
				F.prototype = proto;
				return new F();
			};
		}

		// Create element create
		var create;
		if (typeof config.create == 'function') {
			create = config.create;
			create.prototype.constructor = create;
		} else {
			create = function() {
				this.constructor.call(this, SVG.create(config.create))
			}
		}

		// Inherit prototype
		if (config.inherit) {
			create.prototype = Object.create(config.inherit.prototype);
			// create.prototype.parent = config.inherit.prototype;
			// create.prototype.constructor = create;
		}

		// Extend with methods
		if (config.extend)
			SVG.extend(create, config.extend)

			// Attach construct method to parent
		if (config.construct)
			SVG.extend(SVG.Canvas, config.construct)

		return create;
	};

	SVG.roundToHalf = function(x) {
		x = parseFloat(x);
		var x2 = (Math.ceil(x * 2) + 1) * 0.5;

		if (x2 == parseInt(x2))
			return x2 + 0.5;
		else
			return x2;
	};

	SVG.Element = SVG.invent({
		create : function(node) {
			// create circular reference
			if (this.node = node) {
				this.type = node.nodeName;
				this.node.instance = this;
			}
		},

		extend : {
			attr : function(key, val, ns) {
				var node = this.node;

				if (typeof key == 'object') {
					// apply every attribute individually if an object is passed
					for (val in key)
						this.attr(val, key[val]);
				} else if (val == null) {
					return node.getAttribute(key);
				} else if (val == '') {
					node.removeAttribute(key);
				} else {
					if (ns == null)
						node.setAttribute(key, val);
					else
						node.setAttributeNS(ns, key, val);
				}

				return this;
			},

			defaultStroke : function() {
				this.attr({
					'stroke' : '#000000',
					'stroke-opacity' : 0.8,
					'stroke-width' : 1,
					'stroke-linejoin' : 'round',
					'stroke-linecap' : 'round',
					'fill' : 'none'
				});

				return this;
			},

			remove : function() {
				if (this.canvas.node && this.node) {
					return this.canvas.node.removeChild(this.node);
				}
				// this.node = null;
			},

			show : function() {
				if (this.attr('visibility') != 'visible')
					this.attr('visibility', 'visible');
				return this;
			},

			hide : function() {
				if (this.attr('visibility') != 'hidden')
					this.attr('visibility', 'hidden');
				return this;
			},

			on : function(event, handler) {
				this.node.addEventListener(event, handler, true);
			},

			off : function(event, handler) {
				this.node.removeEventListener(event, handler, true);
			},

			coords : function(event) {
				var target = event.target ? event.target : event.srcElement;
				var sctm = target.getScreenCTM();
				var coords = {};
				coords.x = event.clientX - Number(sctm.e);
				coords.y = event.clientY - Number(sctm.f);

				return coords;
			},

			draw : function() {
				this.canvas.node.appendChild(this.node);
				return this;
			}
		}
	});

	SVG.Canvas = SVG.invent({
		inherit : SVG.Element,

		create : function(element) {
			if (element) {
				/* ensure the presence of a dom element */
				element = typeof element == 'string' ? document.getElementById(element) : element;

				element.addEventListener("mousedown", function(e) {
					e.preventDefault();
				}, false);

				/*
				 * If the target is an svg element, use that element as the main
				 * wrapper. This allows svg.js to work with svg documents as
				 * well.
				 */
				if (element.nodeName == 'svg') {
					this.constructor.call(this, element);
				} else {
					this.constructor.call(this, SVG.create('svg'));
					this.node.setAttribute('xmlns', SVG.xmlns);
					this.node.setAttribute('version', '1.1');
					element.appendChild(this.node);
				}

				this.canvas = {
					node : element
				};
			}
		},

		extend : {}
	});

	SVG.G = SVG.invent({
		inherit : SVG.Canvas,
		create : 'g',

		construct : {
			// Create a rect element
			group : function() {
				var obj = new SVG.G();
				obj.canvas = this;
				this.node.appendChild(obj.node);
				return obj;
			}
		}
	});

	SVG.Text = SVG.invent({
		inherit : SVG.Element,

		create : 'text',

		extend : {
			plot : function(x, y, content) {
				this.textnode = document.createTextNode(content);
				this.node.appendChild(this.textnode);
				return this.attr('transform', 'translate(' + x + ',' + y + ')');
			},
			moveTo : function(x, y) {
				return this.attr('transform', 'translate(' + x + ',' + y + ')');
			},
			text : function(content) {
				this.textnode.nodeValue = content;
				return this;
			}
		},

		construct : {
			// Create a rect element
			text : function(x, y, content) {
				var obj = new SVG.Text();
				// obj.defaultStroke();

				if (arguments.length == 3)
					obj.plot(x, y, content);

				obj.canvas = this;
				return obj;
			}
		}
	});

	SVG.Rect = SVG.invent({
		inherit : SVG.Element,

		create : 'rect',

		extend : {
			plot : function(x, y, width, height) {
				if (arguments.length == 4)
					x = SVG.roundToHalf(x);
				y = SVG.roundToHalf(y);
				width = SVG.roundToHalf(width) + 0.5;
				height = SVG.roundToHalf(height) + 0.5;
				this.attr({
					'x' : x,
					'y' : y,
					'width' : width,
					'height' : height
				});
				return this;
			}
		},

		construct : {
			// Create a rect element
			rect : function(x, y, width, height) {
				var obj = new SVG.Rect();

				obj.plot(x, y, width, height);

				obj.canvas = this;
				return obj;
			}
		}
	});

	SVG.Circle = SVG.invent({
		inherit : SVG.Element,

		create : 'circle',

		extend : {
			plot : function(cx, cy, r) {
				if (arguments.length == 3)
					this.attr({
						'cx' : cx,
						'cy' : cy,
						'r' : r
					});

				return this;
			}
		},

		construct : {
			// Create a rect element
			circle : function(cx, cy, r) {
				var obj = new SVG.Circle();
				obj.attr({
					'stroke' : 'none',
					'fill-opacity' : 0.3,
					'fill' : '#ff0000'
				});

				obj.plot(cx, cy, r);

				obj.canvas = this;
				return obj;
			}
		}
	});

	SVG.Line = SVG.invent({
		inherit : SVG.Element,

		create : 'line',

		extend : {
			plot : function(x1, y1, x2, y2) {
				linePoints = {
					x1 : SVG.roundToHalf(x1),
					y1 : SVG.roundToHalf(y1),
					x2 : SVG.roundToHalf(x2),
					y2 : SVG.roundToHalf(y2)
				};
				return this.attr(linePoints);
			}
		},

		construct : {
			// Create a rect element
			line : function(x1, y1, x2, y2) {
				var obj = new SVG.Line();
				// obj.defaultStroke();

				if (arguments.length == 4)
					obj.plot(x1, y1, x2, y2);

				obj.canvas = this;
				return obj;
			}
		}
	});

	SVG.PolyLine = SVG.invent({
		inherit : SVG.Element,

		create : 'polyline',

		extend : {
			plot : function(pointArray, startIndex, endIndex) {
				var start = 0, end = pointArray.length;

				if (arguments.length == 3 && startIndex >= 0 && endIndex >= 0) {
					start = startIndex;
					end = endIndex;
				}

				var linePoint = [];
				for (var i = start; i < end; i++) {
					var point = pointArray[i];
					linePoint.push(point.join(','));
				}

				return this.attr('points', linePoint.join(' '));
			},

			focus : function() {
				this.attr('stroke-width', 2);
			},

			unfocus : function() {
				this.attr('stroke-width', 1);
			}
		},

		construct : {
			// Create a rect element
			polyline : function(pointArray, startIndex, endIndex) {
				var obj = new SVG.PolyLine();
				obj.defaultStroke();

				if (arguments.length >= 1)
					obj.plot(pointArray, startIndex, endIndex);

				obj.canvas = this;
				return obj;
			}
		}
	});

	return SVG;
}));

(function(root, factory) {
	if (typeof define === 'function' && define.amd) {
		define(factory);
	} else if (typeof exports === 'object') {
		module.exports = factory(require, exports, module);
	} else {
		root.TsChart = factory();
	}
}(this, function(require, exports, module) {

	// 模块代码开始
	var TsChart = this.TsChart = function(element, chartAttr, linesData) {
		if (arguments < 1)
			return

		else {
			var domNode;
			if (typeof element == 'object')
				domNode = element;
			else
				domNode = document.getElementById(element);

			if (!domNode || domNode == null) {
				console.log('Error:can not find the chart container.')
				return;
			}

			var classAttr = domNode.getAttribute('class');
			if (classAttr == null)
				domNode.setAttribute('class', 'tschart');
			else if (classAttr.indexOf('tschart') == -1)
				domNode.setAttribute('class', classAttr + ' tschart');

			var lineChart = new TsChart.LineChart(domNode, chartAttr, linesData);

			domNode.chart = lineChart;
			return lineChart;
		}
	};

	// Method for extending objects
	TsChart.extend = function() {
		var modules, methods, key, i;

		// Get list of modules
		modules = [].slice.call(arguments);

		// Get object with extensions
		methods = modules.pop();

		for (i = modules.length - 1; i >= 0; i--)
			if (modules[i])
				for (key in methods)
					modules[i].prototype[key] = methods[key];
	};

	TsChart.marginTop = 16;
	TsChart.marginBottom = 24;
	TsChart.marginLeft = 54;
	TsChart.marginRight = 48;
	TsChart.minYGridSize = 40;
	TsChart.minXGridSize = 100;

	TsChart.plotWidth = 1.5;
	TsChart.focusPlotWidth = 2;
	TsChart.plotOpacity = 1;
	TsChart.blurPlotOpacity = 0.3;

	TsChart.hisCount = 5;

	TsChart.colors = [ '#67b7dc', '#fdd400', '#84b761', '#cc4748', '#cd82ad', '#2f4074', '#448e4d', '#b7b83f', '#b9783f', '#b93e3d', '#913167', '#4572A7', '#AA4643', '#89A54E', '#80699B', '#3D96AE', '#DB843D', '#92A8CD', '#A47D7C', '#B5CA92', '#de4c4f', '#d8854f', '#eea638', '#a7a737', '#86a965', '#8aabb0', '#69c8ff', '#cfd27e', '#9d9888', '#916b8a', '#724887', '#7256bc', '#ae85c9', '#aab9f7', '#b6d2ff', '#c9e6f2', '#c9f0e1', '#e8d685', '#e0ad63', '#d48652', '#d27362', '#495fba', '#7a629b', '#8881cc' ];

	TsChart.padStr = function(i) {
		return (i < 10) ? "0" + i : "" + i;
	};

	TsChart.epochToTimeStr = function(epochTime, resolution) {
		var date = new Date(epochTime);
		var label;

		if (resolution == 1) {
			label = TsChart.padStr(date.getHours()) + ':' + TsChart.padStr(date.getMinutes()) + ':' + TsChart.padStr(date.getSeconds());
		} else if (resolution == 60) {
			label = TsChart.padStr(1 + date.getMonth()) + '-' + TsChart.padStr(date.getDate()) + ' ' + TsChart.padStr(date.getHours()) + ':' + TsChart.padStr(date.getMinutes());
		} else if (resolution == 3600) {
			label = TsChart.padStr(1 + date.getMonth()) + '-' + TsChart.padStr(date.getDate()) + ' ' + TsChart.padStr(date.getHours()) + ':' + TsChart.padStr(date.getMinutes());
		} else if (resolution == 86400) {
			label = TsChart.padStr(date.getFullYear()) + '-' + TsChart.padStr(1 + date.getMonth()) + '-' + TsChart.padStr(date.getDate()) + ' ' + TsChart.padStr(date.getHours()) + ':' + TsChart.padStr(date.getMinutes());
		}

		return label;
	};

	TsChart.LinesData = function(chartAttr, linesData, plotWidth, plotHeight) {
		this.noData = false;
		this.lineData = linesData;
		this.dynamic = 0;

		this.init(chartAttr, plotWidth, plotHeight);

		return;
	};

	TsChart.LinesData.prototype = {

		init : function(chartAttr, plotWidth, plotHeight) {
			// var minMax = this.minMax = this.getMaxAndMin(this.lineData);
			var minMax = this.minMax = this.getChartMaxAndMin(this.lineData, chartAttr);
			var dataAttr = chartAttr.dataAttr;

			this.polyLine = new Array(this.lineData.length);
			this.plotData = new Array(this.lineData.length);

			if (minMax.minVal == null || minMax.maxVal == null || minMax.minTime == null || minMax.maxTime == null) {
				this.noData = true;
				for (var i = 0; i < dataAttr.length; i++) {
					this.lineData[i] = [];
					this.plotData[i] = [];
				}
			} else if (this.lineData.length > 0)
				this.noData = false;

			this.plotWidth = plotWidth;
			this.plotHeight = plotHeight;

			this.initXScale(chartAttr);
			this.initYScale(chartAttr);
			this.convertLineData();
		},

		initXScale : function(chartAttr) {
			var plotWidth = this.plotWidth;
			// clone this.minMax
			var minMax = {};
			minMax.minTime = this.minMax.minTime;
			minMax.maxTime = this.minMax.maxTime;

			if (this.noData && (minMax.minTime == null || minMax.maxTime == null)) {
				var now = new Date().getTime();

				if (chartAttr.timeRange && chartAttr.timeRange > 0) {
					minMax.minTime = now - 60000 * chartAttr.timeRange;
					minMax.maxTime = now;
				} else {
					if (chartAttr.beginTime && chartAttr.beginTime > 0)
						minMax.minTime = chartAttr.beginTime;
					else
						minMax.minTime = now - 86400000;

					if (chartAttr.endTime && chartAttr.endTime > 0)
						minMax.maxTime = chartAttr.endTime;
					else
						minMax.maxTime = now;
				}
			} else {

			}

			var timeScales;
			if (this.dynamic > 0)
				timeScales = this._getDynamicTimeScales(chartAttr.timeRange, plotWidth);
			else
				timeScales = this._getDateTimeScales(minMax.minTime / 1000, minMax.maxTime / 1000, plotWidth);
			// return {'steps':steps, 'stepSize':stepSize,
			// 'niceStart':niceStart,
			// 'niceEnd':niceEnd, 'scales':scales};
			// return {'steps':steps, 'stepSize':stepSize,
			// 'niceStart':niceStart,
			// 'niceEnd':niceEnd, 'niceReslu':resolution, 'scales':scales};
			var timeResolution = (minMax.maxTime - minMax.minTime) / plotWidth;
			if (timeResolution == 0)
				timeResolution = 180000 / plotWidth;
			this.timeResolution = timeResolution;
			this.xSteps = timeScales.steps;
			this.xScales = timeScales.scales;
			this.xStepPixel = plotWidth / this.xSteps;
			this.xNiceReslu = timeScales.niceReslu;
		},

		initYScale : function(chartAttr) {
			var plotHeight = this.plotHeight;
			// clone this.minMax
			var minMax = {};
			minMax.minVal = this.minMax.minVal;
			minMax.maxVal = this.minMax.maxVal;

			if (this.noData) {
				minMax.minVal = 0;
				minMax.maxVal = 100;
			}

			var valScales = this._getValueScales(minMax.minVal, minMax.maxVal, plotHeight);
			// return {'steps':steps, 'stepSize':stepSize, 'niceStart':niceMin,
			// 'niceEnd':niceMax, 'scales':scales};
			var valResolution = (valScales.niceEnd - valScales.niceStart) / plotHeight;
			if (valResolution == 0)
				valResolution = 100 / plotHeight;
			this.valResolution = valResolution;
			this.niceYStart = valScales.niceStart;
			this.niceYEnd = valScales.niceEnd;
			this.ySteps = valScales.steps;
			this.yPower = valScales.power;
			this.yScales = valScales.scales;
			this.yStepPixel = plotHeight / this.ySteps;
		},

		convertLineData : function() {
			var pointArray, data, point, idx, avgInterval, tolerateInterval;
			var dataSegments = new Array(this.lineData.length);
			var plotWidth = this.plotWidth, plotHeight = this.plotHeight;
			var minMax = this.minMax;
			var timeResolution = this.timeResolution = (minMax.maxTime - minMax.minTime) / plotWidth;

			if (this.lineData) {
				for (var i = 0; i < this.lineData.length; i++) {
					pointArray = this.lineData[i];
					idx = 0;
					if (pointArray && pointArray.length > 0) {
						avgInterval = (pointArray[pointArray.length - 1][0] - pointArray[0][0]) / pointArray.length;

						tolerateInterval = avgInterval * 3.7;
						dataSegments[i] = new Array();

						data = new Array(pointArray.length);
						for (var j = 0; j < pointArray.length; j++) {
							point = new Array(2);

							if (pointArray[j][0] == minMax.minTime || timeResolution == 0)
								continue;
							else
								point[0] = (pointArray[j][0] - minMax.minTime) / timeResolution;

							if (point[0] < 0)
								continue;
							else if (point[0] > plotWidth)
								break;

							point[1] = plotHeight - (pointArray[j][1] - this.niceYStart) / this.valResolution;

							if (point[1] <= 0)
								point[1] = 0;
							else if (point[1] > plotHeight)
								point[1] = plotHeight;

							if (!point[1])
								point[1] = 0;

							data[idx] = point;

							if (j > 1 && pointArray[j][0] - pointArray[j - 1][0] > tolerateInterval)
								dataSegments[i].push(idx);

							idx++;
						}
						dataSegments[i].push(idx);
						this.plotData[i] = data.slice(0, idx);
					} else {
						dataSegments[i] = [];
						this.plotData[i] = [];
					}
				}
			}
			this.dataSegments = dataSegments;
		},

		sliceData : function(chartAttr, xBegin, xEnd) {
			var lineData = this.lineData;
			var beginTime, endTime;

			beginTime = xBegin * this.timeResolution + this.minMax.minTime;
			endTime = xEnd * this.timeResolution + this.minMax.minTime;

			if (endTime - beginTime < 60000)
				endTime = endTime + 60000;

			var points, start, end, len;
			var data = new Array(lineData.length);
			if (lineData && lineData.length > 0) {
				for (var i = 0; i < lineData.length; i++) {
					points = lineData[i];
					if (points && points.length > 0) {// no data
						len = points.length;

						start = 0;
						end = len;

						for (var j = 0; j < points.length; j++)
							if (points[j][0] >= beginTime - 2)
								break;
						start = j;

						for (var k = points.length - 1; k >= 0; k--)
							if (points[k][0] <= endTime + 2)
								break;
						end = k;

						data[i] = lineData[i].slice(start, end + 1);
					}
				}
			}
			// var minMax = this.getMaxAndMin(data);
			var minMax = this.getChartMaxAndMin(data, chartAttr);

			if (minMax.minTime == null) {
				minMax.minTime = beginTime;
				minMax.maxTime = endTime;
			}
			this.minMax = minMax;
			this.lineData = data;

			var dataAttr = chartAttr.dataAttr;

			this.polyLine = new Array(dataAttr.length);
			this.plotData = new Array(dataAttr.length);

			if (minMax.minVal == null || minMax.maxVal == null) {
				minMax.minVal = 0;
				minMax.maxVal = 100;

				this.noData = true;

				for (var i = 0; i < dataAttr.length; i++) {
					this.lineData[i] = [];
					this.plotData[i] = [];
				}
			}

			this.initXScale(chartAttr);
			this.initYScale(chartAttr);
			this.convertLineData();
		},

		getNearPoint : function(x, y) {
			var ratio = x / this.plotWidth;
			var data, len, s, start, end;
			var lineIdx = -1, pointIdx = -1, px, py;
			var delta, minDelta = Number.POSITIVE_INFINITY;

			for (var i = 0; i < this.plotData.length; i++) {
				data = this.plotData[i];
				if (data && data.length > 0) {
					len = data.length;
					if (len == 0)
						continue;

					start = 0;
					end = len - 1;
					s = Math.floor(len * ratio);
					if (s >= len)
						s = len - 1;

					while (end - start > 1) {
						if (data[s][0] - x > 0) {
							end = s;
						} else {
							start = s;
						}

						s = Math.floor(start + (end - start) / 2);
					}

					if (Math.abs(data[start][0] - x) < Math.abs(data[end][0] - x))
						s = start;
					else
						s = end;

					delta = Math.abs(data[s][0] - x) + Math.abs(data[s][1] - y);

					if (delta < minDelta) {
						lineIdx = i;
						pointIdx = s;
						px = data[s][0];
						py = data[s][1];

						minDelta = delta;
					}
				}
			}

			return {
				'lineIdx' : lineIdx,
				'pointIdx' : pointIdx,
				'px' : px,
				'py' : py
			};
		},

		getAllPoint : function(x, y, focusIdx) {
			var isHighLight = false;
			if(focusIdx != -1){
				isHighLight = true;
			}
			var pointDataList = new Array();
			var ratio = x / this.plotWidth;
			var data, len, s, start, end;
			var lineIdx = -1, pointIdx = -1, px, py;
			var delta, minDelta = Number.POSITIVE_INFINITY;

			for (var i = 0; i < this.plotData.length; i++) {
				if(i != focusIdx && isHighLight){
					continue;
				}
				data = this.plotData[i];
				if (data && data.length > 0) {
					len = data.length;
					if (len == 0)
						continue;

					start = 0;
					end = len - 1;
					s = Math.floor(len * ratio);
					if (s >= len)
						s = len - 1;

					while (end - start > 1) {
						if (data[s][0] - x > 0) {
							end = s;
						} else {
							start = s;
						}
						s = Math.floor(start + (end - start) / 2);
					}

					if (Math.abs(data[start][0] - x) < Math.abs(data[end][0] - x))
						s = start;
					else
						s = end;
					
					var pointData = {
						'lineIdx' : i,
						'pointIdx' : s,
						'px' : data[s][0],
						'py' : data[s][1]
					};
					pointDataList.push(pointData);

				}
			}
			return pointDataList;
		},

		getChartMaxAndMin : function(pointArrays, chartAttr) {
			var pointArray;
			var len = 0;
			var nowTime = (new Date()).getTime();
			var minTime = 0, maxTime = 0, flag = 0;

			if (chartAttr && chartAttr.startTime > 0 && chartAttr.endTime > 0) {
				minTime = chartAttr.startTime;
				maxTime = chartAttr.endTime;
				flag = 1;
			} else {
				minTime = nowTime;
			}
			var minVal = Number.POSITIVE_INFINITY, maxVal = Number.NEGATIVE_INFINITY;
			if (pointArrays && pointArrays.length > 0) {
				for (var i = 0; i < pointArrays.length; i++) {
					pointArray = pointArrays[i];
					len = pointArray ? pointArray.length : 0;

					if (len > 0 && flag == 0) {
						if (pointArray[0][0] < minTime)
							minTime = pointArray[0][0];
						if (pointArray[len - 1][0] > maxTime)
							maxTime = pointArray[len - 1][0];
					}

					if (pointArray) {
						for (var j = 0; j < len; j++) {
							if (pointArray[j] && parseFloat(pointArray[j][1]) < parseFloat(minVal))
								minVal = pointArray[j][1];
							if (pointArray[j] && parseFloat(pointArray[j][1]) > parseFloat(maxVal))
								maxVal = pointArray[j][1];
						}
					}
				}
			}
			if (minTime == nowTime)
				minTime = null;
			if (maxTime == 0)
				maxTime = null;
			if (minVal == Number.POSITIVE_INFINITY)
				minVal = null;
			if (maxVal == Number.NEGATIVE_INFINITY)
				maxVal = null;
			// 当数据为空或者数据为0的
			if (!maxVal || (maxVal == minVal && minVal == 0))
				maxVal = 100;
			if (!minVal || (maxVal == minVal && minVal == 0))
				minVal = 0;

			return {
				'minTime' : minTime,
				'maxTime' : maxTime,
				'minVal' : minVal,
				'maxVal' : maxVal
			};
		},
		getMaxAndMin : function(pointArrays) {
			var pointArray;
			var len = 0;
			var nowTime = (new Date()).getTime();
			var minTime = nowTime, maxTime = 0;
			var minVal = Number.POSITIVE_INFINITY, maxVal = Number.NEGATIVE_INFINITY;
			if (pointArrays && pointArrays.length > 0) {
				for (var i = 0; i < pointArrays.length; i++) {
					pointArray = pointArrays[i];
					len = pointArray ? pointArray.length : 0;

					if (len > 0) {
						if (pointArray[0][0] < minTime)
							minTime = pointArray[0][0];
						if (pointArray[len - 1][0] > maxTime)
							maxTime = pointArray[len - 1][0];
					}

					for (var j = 0; j < len; j++) {
						if (parseFloat(pointArray[j][1]) < parseFloat(minVal))
							minVal = pointArray[j][1];
						if (parseFloat(pointArray[j][1]) > parseFloat(maxVal))
							maxVal = pointArray[j][1];
					}
				}
			}
			if (minTime == nowTime)
				minTime = null;
			if (maxTime == 0)
				maxTime = null;
			if (minVal == Number.POSITIVE_INFINITY)
				minVal = null;
			if (maxVal == Number.NEGATIVE_INFINITY)
				maxVal = null;
			// 当数据为空或者数据为0的
			if (!maxVal || (maxVal == minVal && minVal == 0))
				maxVal = 100;
			if (!minVal || (maxVal == minVal && minVal == 0))
				minVal = 0;

			return {
				'minTime' : minTime,
				'maxTime' : maxTime,
				'minVal' : minVal,
				'maxVal' : maxVal
			};
		},

		shiftTimeOutData : function(beginTime) {
			var lineData, plotData;
			var shiftCount = 0;

			for (var i = 0; i < this.lineData.length; i++) {
				lineData = this.lineData[i];

				while (lineData.length > 0 && lineData[0][0] < beginTime) {
					lineData.shift();
					shiftCount++;
				}
			}

			this.minMax.minTime = beginTime;
			this.convertLineData();
			return shiftCount;
		},

		// below is private methods
		_niceStepSize : function(base, stepSize) {
			var BASEDEF = {
				7 : [ 1, 2, 7 ],
				10 : [ 1, 2, 5, 10 ],
				12 : [ 1, 2, 3, 4, 6, 8, 12 ],
				60 : [ 1, 2, 3, 5, 10, 15, 30, 60 ]
			};

			// get the magnitude of the step size
			var power = Math.floor(Math.log(stepSize) / Math.log(base) + 0.5);
			var mag = Math.pow(base, power); // 去掉尾数,获取数量级
			// calculate most significant digit of the new step size
			var magMsd = stepSize / mag; // 获取需要对齐的stepSize相对数量级的倍数

			var slices = BASEDEF[base];

			if (slices) {
				var l = slices.length;
				var i = 0;
				for (i = 0; i < l; i++) {
					if (magMsd <= slices[i]) {
						magMsd = slices[i];
						break;
					}
				}
			}

			return {
				'stepSize' : magMsd * mag,
				'power' : power
			};
		},

		// getValueScales(mini value, max value, max steps，chart height);
		_getValueScales : function(minVal, maxVal, height) {
			if (maxVal == minVal) {
				maxVal = maxVal * 1.2;
				minVal = minVal * 0.8;
			}

			var targetSteps = Math.floor(height / 30);
			var range = maxVal - minVal;

			// calculate an initial guess at step size
			var tempStep = range / targetSteps;
			var nice = this._niceStepSize(10, tempStep);
			var stepSize = nice.stepSize;

			nice.power = Math.floor(Math.log10(stepSize));

			var niceMin, niceMax;
			niceMax = Math.floor(maxVal / stepSize) * stepSize;
			niceMin = Math.floor(minVal / stepSize) * stepSize;

			var steps = Math.floor((niceMax - niceMin) / stepSize);

			var spareSteps = targetSteps - steps;
			if (spareSteps >= 3) {
				niceMax = niceMax + stepSize + stepSize;
				niceMin = niceMin - stepSize;
				steps = steps + 3;
			} else if (spareSteps == 2) {
				niceMax = niceMax + stepSize;
				niceMin = niceMin - stepSize;
				steps = steps + 2;
			} else if (spareSteps == 1) {
				niceMax = niceMax + stepSize;
				steps = steps + 1;
			}

			if (minVal >= 0 && niceMin < 0) {
				niceMin = 0;
				steps = Math.floor((niceMax - niceMin) / stepSize);
			}

			if (maxVal <= niceMax - stepSize) {
				niceMax = niceMax - stepSize;
				steps = Math.floor((niceMax - niceMin) / stepSize);
			}

			niceMax = parseFloat(niceMax.toFixed(4));
			niceMin = parseFloat(niceMin.toFixed(4));

			var stepResolution = height / steps;
			var scales = [];
			var scale = niceMin;
			for (var i = 0; i <= steps; i++) {
				scales.push([ stepResolution * i, parseFloat(scale.toFixed(4)) ]);
				scale = scale + stepSize;
			}

			return {
				'steps' : steps,
				'power' : nice.power,
				'stepSize' : stepSize,
				'niceStart' : niceMin,
				'niceEnd' : niceMax,
				'scales' : scales
			};
		},

		_getDateTimeScales : function(minVal, maxVal, width) {
			if (maxVal == minVal) {
				minVal = minVal - 900;
				maxVal = maxVal + 900;
			}

			var range = maxVal - minVal;
			// var maxMid = minVal + Math.floor(range/2);

			// 小时：3600
			// 天：86400
			// 星期：604800
			var resolution, labelLen;

			if (range <= 60 * 30) {
				resolution = 1;
				labelLen = 64; // 'hh:mm:ss';
			} else if (range <= 3600 * 4) {
				resolution = 60;
				labelLen = 64; // 'hh:mm:ss';
			} else if (range <= 86400 * 4) {
				resolution = 3600;
				labelLen = 78; // 'mm-dd hh:00';
			} else if (range <= 604800 * 4) {
				resolution = 86400;
				labelLen = 72; // 'yyyy-mm-dd';
			} else {
				resolution = 86400;
				labelLen = 72; // 'yyyy-mm-dd';
			}
			/*
			 * if (width < 200){ return null; }
			 */
			var targetSteps = Math.ceil(width / labelLen / 2);
			var stepSize;

			if (resolution == 1) {
				stepSize = (maxVal - minVal) / targetSteps;
				stepSize = this._niceStepSize(60, stepSize).stepSize;
			} else if (resolution == 60) {
				stepSize = (maxVal - minVal) / 60 / targetSteps;
				stepSize = this._niceStepSize(60, stepSize).stepSize * 60;
			} else if (resolution == 3600) {
				stepSize = (maxVal - minVal) / 3600 / targetSteps;
				stepSize = this._niceStepSize(12, stepSize).stepSize * 3600;
			} else if (resolution == 86400) {
				stepSize = (maxVal - minVal) / 86400 / targetSteps;
				stepSize = this._niceStepSize(7, stepSize).stepSize * 86400;
			}

			var chartResolution = (maxVal - minVal) / width;
			var stepResolution = stepSize / chartResolution;
			var niceStart = Math.ceil(minVal / stepSize) * stepSize;
			var niceStartPos = (niceStart - minVal) / chartResolution;
			var niceEnd = Math.floor(maxVal / stepSize) * stepSize;
			var niceEndPos = (niceEnd - minVal) / chartResolution;

			var steps = 0;
			var midPos = 0;
			var scales = [];
			for (var scale = niceStart; scale <= niceEnd + 1; scale = scale + stepSize) {
				var scaleDate = new Date(scale * 1000);

				var label;
				if (resolution == 1) {
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
				} else if (resolution == 60) {
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
				} else if (resolution == 3600) {
					label = TsChart.padStr(1 + scaleDate.getMonth()) + '-' + TsChart.padStr(scaleDate.getDate()) + ' ' + TsChart.padStr(scaleDate.getHours()) + ':00';
				} else if (resolution == 86400) {
					label = TsChart.padStr(scaleDate.getFullYear()) + '-' + TsChart.padStr(1 + scaleDate.getMonth()) + '-' + TsChart.padStr(scaleDate.getDate());
				}

				if (stepResolution > 160) {
					midPos = (scale - minVal) / chartResolution - stepResolution / 2;
					if (midPos > 0 && midPos < width + 1)
						scales.push([ midPos, '' ]);
				}

				scales.push([ (scale - minVal) / chartResolution, label ]);

				steps = steps + 1;
			}

			if (stepResolution > 160) {
				midPos = (scale - minVal) / chartResolution - stepResolution / 2;
				if (midPos < width + 1)
					scales.push([ midPos, '' ]);
			}

			return {
				'steps' : steps,
				'stepSize' : stepSize,
				'niceStart' : niceStart,
				'niceEnd' : niceEnd,
				'niceReslu' : resolution,
				'scales' : scales
			};
		},

		_getDynamicTimeScales : function(timeRange, width) {
			var now = new Date().getTime();
			var minTime = (now - 60000 * timeRange);
			var maxTime = now;

			this.minMax.minTime = minTime;
			this.minMax.maxTime = maxTime;
			this.timeResolution = (maxTime - minTime) / this.plotWidth;

			var sTime = minTime / 1000;
			var eTime = maxTime / 1000;

			var steps = Math.floor(width / 50 / 4) * 2;
			var stepSize = (eTime - sTime) / steps;
			var chartResolution = (eTime - sTime) / width;
			var resolution = 1;

			var scales = [];
			var scaleDate, label, i = 0;
			for (var scale = sTime; scale <= eTime + 1; scale = scale + stepSize) {
				label = '';

				if (i == 0 || i == steps || i == steps / 2) {
					scaleDate = new Date(scale * 1000);
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
				}
				scales.push([ (scale - sTime) / chartResolution, label ]);

				i = i + 1;
			}

			return {
				'steps' : steps,
				'stepSize' : stepSize,
				'niceStart' : sTime,
				'niceEnd' : eTime,
				'niceReslu' : resolution,
				'scales' : scales
			};
		}
	};

	TsChart.LineChart = function(node, chartAttr, linesData) {
		if (node.chart)
			node.chart.destroy();

		this.node = node;
		this.node.chart = this;

		this.dynamic = false;

		this.refresh = 0;
		this.history = [];

		// get the lines configuration and points data from the parameters or
		// html
		// dom
		var data;
		if (chartAttr && linesData) {
			if (chartAttr == null)
				chartAttr = {};

			if (linesData != null)
				data = linesData;
			else
				data = [];
		} else if (chartAttr && !linesData) {
			if (chartAttr.data)
				data = chartAttr.data;
			else
				data = [];
			if (chartAttr.attr)
				chartAttr = chartAttr.attr;
			else
				chartAttr = {};
		} else {
			var childNodes = this.node.getElementsByTagName('div');

			for (var i = 0; i < childNodes.length; i++) {
				if (childNodes[i].getAttribute('name') == 'data') {
					var chartDef = eval('(' + childNodes[i].innerText + ')');

					if (!chartDef)
						chartDef = {
							attr : {
								dataAttr : []
							},
							data : []
						};

					if (chartDef.attr)
						chartAttr = chartDef.attr;
					else
						chartAttr = {};
					if (chartDef.data)
						data = chartDef.data;
					else
						data = [];

					break;
				}
			}

			if (!chartDef) {
				chartDef = {
					attr : {
						dataAttr : []
					},
					data : []
				};
				chartAttr = chartDef.attr;
				data = chartDef.data;
			}
		}

		this.chartAttr = chartAttr;
		if (!chartAttr.timeRange)
			chartAttr.timeRange = 0;
		if (!chartAttr.title)
			chartAttr.title = "BLANK CHART";

		if (!chartAttr.startTime)
			chartAttr.beginTime = 0;
		else
			chartAttr.beginTime = chartAttr.startTime;

		if (!chartAttr.endTime)
			chartAttr.endTime = 0;

		if (!chartAttr.dataUnit)
			chartAttr.dataUnit = '';

		if (chartAttr['timeRange'] > 0)
			this.dynamic = true;

		// if color no defined, use the default color table color
		var dataAttr = chartAttr.dataAttr;
		if (!dataAttr || dataAttr == null) {
			chartAttr.dataAttr = [];
			dataAttr = chartAttr.dataAttr;
		}

		for (var i = 0; i < dataAttr.length; i++) {
			if (!dataAttr[i].color || dataAttr[i].color == '' || dataAttr[i].color == null)
				dataAttr[i].color = TsChart.colors[i % TsChart.colors.length];
		}

		// construct chart title div
		var titleDiv = document.createElement('div');
		this.titleDiv = titleDiv;
		
		
		titleDiv.setAttribute('class', 'title');
		titleDiv.setAttribute('title', chartAttr.title);
		
		titleDiv.appendChild(document.createTextNode(chartAttr.title));
		this.node.appendChild(titleDiv);

		// construct chart svg root canvas
		var chartCanvas = SVG(node);
		this.chartCanvas = chartCanvas;

		// analysis lines data, dynamic calculate the axis grids and labels
		this.linesData = new TsChart.LinesData(chartAttr, data, this.plotWidth, this.plotHeight);
		this.legendCanvas = new TsChart.LegendCanvas(this, node, chartAttr.nolegends);
		this._drawLegend(dataAttr);

		// init attributes
		this._init(node);
		var plotWidth = this.plotWidth;
		var titleNum = plotWidth / 10;
		if(chartAttr.title.length > titleNum){
			var titleTemp = chartAttr.title.substring(0, titleNum) + "...";
		}
		$(node).find('.title').text(titleTemp);
		

		// set the root canvas width and height
		chartCanvas.attr({
			'width' : '100%',
			'height' : this.chartHeight
		});

		// for chart auto resizing
		var instance = this;
		window.addEventListener('resize', function() {
			instance.resize()
		});
		if (this.dynamic) {
			var chart = this;
			window.setTimeout(function() {
				chart._moveTime();
			}, 10000);
		}

		this.drawed = false;
		this._draw();
		
		
		
	};

	TsChart.LineChart.prototype = {
		getChart : function() {
			var chartAttr = this.chartAttr;
			var data = this.linesData.lineData;

			return {
				'attr' : chartAttr,
				'data' : data
			};
		},

		setChart : function(chartAttr, data) {
			this.drawed = false;

			var linesData = this.linesData;

			if (arguments.length == 2) {
				this.chartAttr = chartAttr;
				linesData.lineData = data;
			} else {
				this.chartAttr = chartAttr.attr;
				linesData.lineData = chartAttr.data;
			}

			chartAttr = this.chartAttr;

			this._setDefaultColor();
			this.setTitle(chartAttr.title);
			if (chartAttr.timeRange && chartAttr.timeRange > 0)
				this.dynamic = true;

			this.redraw();
			return this;
		},

		getData : function() {
			var data = this.linesData.lineData;

			return data;
		},

		setData : function(data) {
			this.drawed = false;
			var dataAttr = this.chartAttr.dataAttr;

			if (!dataAttr)
				console.log('Error:chart config is malform');

			var dataLen = data.length;
			var attrLen = dataAttr.length;
			var lineData = new Array(attrLen);

			for (var i = 0; i < dataLen && i < attrLen; i++)
				lineData[i] = data[i];

			this.linesData.lineData = lineData;
			this.redraw();
			return this;
		},

		addData : function(data) {
			if (this.refresh > 0) {
				var hasNewData = false, needRedraw = false, linesData = this.linesData, lineData = linesData.lineData;

				// if (this.history.length != 1)
				// this.history = [lineData];
				if (!data || data.length == 0) {
					return false;
				}

				var newData = new Array(lineData.length);

				/*
				 * for (var i=0; i<data.length; i++){ newData[i] = (lineData[i] ?
				 * lineData[i] : []).concat(data[i]); if (data[i].length > 0)
				 * hasNewData = true; } console.info(newData);
				 */

				for (var i = 0; i < data.length; i++) {

					// 数据去重，避免同个时间点出现多个数据
					var oldLineData = (lineData[i] ? lineData[i] : []);
					var newLineData = data[i];
					var needLineData = new Array();

					for (var l = 0; l < newLineData.length; l++) {
						var isNeed = true;
						var newIns = newLineData[l];
						for (var k = 0; k < oldLineData.length; k++) {
							var oldIns = oldLineData[k];
							if (newIns[0] && oldIns[0] && oldIns[0] == newIns[0]) {
								isNeed = false;
							}
						}
						if (isNeed) {
							needLineData.push(newIns);
						}
					}
					if (needLineData.length > 0) {
						newData[i] = oldLineData.concat(needLineData);
						hasNewData = true;
					} else {
						newData[i] = oldLineData;
					}
				}
				linesData.lineData = newData;

				var minMax = linesData.minMax;
				// var aMinMax = linesData.getMaxAndMin(data);
				var aMinMax = linesData.getChartMaxAndMin(data);

				if (aMinMax.minVal < minMax.minVal || aMinMax.maxVal > minMax.maxVal) {
					minMax.minVal = aMinMax.minVal;
					minMax.maxVal = aMinMax.maxVal;
				}

				if (aMinMax.minVal < linesData.niceYStart || aMinMax.maxVal > linesData.niceYEnd || Math.abs(aMinMax.minVal - linesData.niceYStart) > Math.abs(aMinMax.minVal) || Math.abs(linesData.niceYEnd - aMinMax.maxVal) > Math.abs(aMinMax.maxVal)) {
					linesData.initYScale(this.chartAttr);
					needRedraw = true;
				}

				if (needRedraw || (linesData.noData && hasNewData))
					this.redraw();
			}
			return this;
		},

		addLines : function(dattr, data) {
			this.drawed = false;

			var linesData = this.linesData;
			var lineData = linesData.lineData;
			var dataAttr = this.chartAttr.dataAttr;

			this.chartAttr.dataAttr = dataAttr.concat(dattr);
			linesData.lineData = lineData.concat(data);

			this._setDefaultColor();

			this.redraw();
			return this;
		},

		getAttr : function() {
			return this.chartAttr;
		},

		setAttr : function(chartAttr) {
			this.chartAttr = chartAttr;
			var dataAttr = chartAttr.dataAttr;
			if (!dataAttr)
				console.log('Error:malform setAttr paramer.');

			var lineData = this.linesData.lineData;
			var attrLen = dataAttr.length;
			var dataLen = lineData.len;

			// 如何是动态图且动态图的最小时间小于30
			if (this.dynamic && this.chartAttr.timeRange < 30) {
				this.chartAttr.timeRange = 30;
			}

			if (dataLen > attrLen) {
				console.log("Warn:line config entries count less than line data count, trim the data.")
				this.linesData.lineData = lineData.slice(0, attrLen);
			} else if (dataLen < attrLen) {
				console.log("Warn:line config entries count more than line data count, trim the config.")
				for (var i = dataLen; i < attrLen; i++)
					lineData[i] = [];
			}
			this.redraw();
			return this;
		},

		getMaxTime : function() {
			var linesData = this.linesData;
			return linesData.minMax.maxTime;
		},

		getMinTime : function() {
			var linesData = this.linesData;
			return linesData.minMax.minTime;
		},

		setDynamic : function(dynamic) {
			this.dynamic = dynamic;
		},

		doRefresh : function(interval) {
			var linesData = this.linesData;
			if (this.dynamic) {
				this.history = [];
				linesData.dynamic = interval;
				this.refresh = interval;
				var chart = this;
				this.redraw();
				window.setTimeout(function() {
					chart._moveTime();
				}, interval * 1000);
			}
			return this;
		},

		setTitle : function(title) {
			var titleDiv = this.titleDiv;
			while (titleDiv.firstChild) {
				titleDiv.removeChild(titleDiv.firstChild);
			}

			this.chartAttr.title = title;
			titleDiv.appendChild(document.createTextNode(title));
			return this;
		},
		setLineClickCallback : function(callback) {
			this.clickLineCallback = callback;
			return this;
		},
		// author : MJR
		setMousemoveCallback : function(callback) {
			this.mousemoveCallback = callback;
			return this;
		},
		
		setMouseleaveCallback : function(callback){
			this.mouseleaveCallback = callback;
			return this;
		},
		
		setZoom : function(callback) {
			this.zoomCallback = callback;
			return this;
		},
		setRestore : function(callback) {
			this.restoreCallback = callback;
			return this;
		},
		restore : function() {
			var his = this.history;
			if (his.length > 0) {
				var timeDiff = his.pop();
				if (this.chartAttr.startTime == timeDiff.startTime && this.chartAttr.endTime == timeDiff.endTime) {
					timeDiff = his.pop();
				}
				this.chartAttr.startTime = timeDiff.startTime;
				this.chartAttr.endTime = timeDiff.endTime;
				this.chartAttr.data = [];
				this.setAttr(this.chartAttr);
				// this.setData(chartAttr.data);

				if (this.restoreCallback)
					this.restoreCallback(this, timeDiff.startTime, timeDiff.endTime);
			}
			return his.length;
		},

		getHisCount : function() {
			return his.length;
		},

		/*
		 * reset: function(){ var his = this.history; if (his.length > 0){ var
		 * chartAttr = his.pop(); this.setAttr(chartAttr);
		 * this.setData(chartAttr.data); } this.history = []; return this; },
		 */

		resize : function() {
			this.drawed = false;

			var focusIdx = this.focusIdx;
			this.focusIdx = -1;

			this.chartGroup.remove();
			this.legendCanvas.removeAll();
			this.linesData.init(this.chartAttr, this.plotWidth, this.plotHeight);
			this._drawLegend(this.chartAttr.dataAttr);
			this._init(this.node);
			
			this.chartCanvas.attr({
				'width' : '100%',
				'height' : this.chartHeight
			});

			this._draw();

			this.nearIdx = focusIdx;
			this._toggleLine();
			return this;
		},

		redraw : function() {
			this.drawed = false;

			var focusIdx = this.focusIdx;
			this.focusIdx = -1;

			this.chartGroup.remove();
			this.legendCanvas.removeAll();
			this._drawLegend(this.chartAttr.dataAttr);
			this._init(this.node);
			this.linesData.init(this.chartAttr, this.plotWidth, this.plotHeight);
			this.chartCanvas.attr({
				'width' : '100%',
				'height' : this.chartHeight
			});

			this._draw();
			this.nearIdx = focusIdx;
			this._toggleLine();
			return this;
		},

		destroy : function() {
			this.drawed = false;
			var domNode = this.node;
			domNode.removeChild(this.titleDiv);
			domNode.removeChild(this.chartCanvas.canvas.node);
			domNode.removeChild(this.legendCanvas.node);
			delete (domNode.chart);
		},

		getPlotWidth : function() {
			return this.plotWidth;

		},
		// below is private methods

		_init : function(node) {
			// get the width and height from dom node
			var width = this.node.clientWidth - 2;
			var height = (this.node.clientHeight == 0 ? 290 : this.node.clientHeight) - 1;

			// the min width is 200 pixel
			if (width < 200)
				width = 200;

			// 300, 260, 220, 180, 140
			// if height not defined, set the height to some values relative to
			// the
			// width
			if (height != null && height == 0) {
				if (width > 500)
					height = 350;
				else if (width > 400)
					height = 310;
				else if (width > 300)
					height = 270;
				else
					height = 230;
				this.node.style.height = height + 'px';
			}

			// the svg height is total height minus the title and legend height
			var chartWidth = width;
			var chartHeight = height - this.titleDiv.clientHeight - this.legendHeight;

			this.plotHeight = chartHeight - TsChart.marginTop - TsChart.marginBottom;
			this.plotWidth = chartWidth - TsChart.marginLeft - TsChart.marginRight;

			this.chartWidth = chartWidth;
			this.chartHeight = chartHeight;

			this.realXStart = TsChart.marginLeft;
			this.realXEnd = chartWidth - TsChart.marginRight;
			this.realYStart = TsChart.marginTop;
			this.realYEnd = chartHeight - TsChart.marginBottom;

			// svg transform translate value for plot area
			this.offset = 'translate(' + this.realXStart + ',' + this.realYStart + ')';

			// for highlight one plot line
			this.nearIdx = -1;
			this.focusIdx = -1;
		},

		_draw : function() {
			this.drawed = false;

			// the root graphic group for all shape
			var chartGroup = this.chartCanvas.group();
			this.chartGroup = chartGroup;

			chartGroup.lineChart = this;

			// the background rectangle, just for event trigger
			this.bkMask = chartGroup.rect(0, 0, this.chartWidth, this.chartHeight).attr({
				'fill' : '#ffffff',
				'fill-opacity' : '0'
			}).draw();

			this._drawGrid();
			this._drawLines();
			this._drawLabel();

			// event handler for the vertical moving line, combine with line
			// point
			// Adsorption and point value hint info;
			chartGroup.on('mousemove', this._getMouseXAndY);
			// event handler for the time range select in plot area
			chartGroup.on('mousedown', this._startSelect);
			chartGroup.on('mouseup', this._endSelect);

			// event handler for hide all extra shape items in canvas
			chartGroup.on('mouseleave', this._clearSelect);

			// event hander for plot line highlighting
			chartGroup.on('click', this._focusLine);

			this.drawed = true;
		},

		_setDefaultColor : function() {
			var dataAttr = this.chartAttr.dataAttr;
			for (var i = 0; i < dataAttr.length; i++) {
				if (!dataAttr[i].color || dataAttr[i].color == '' || dataAttr[i].color == null)
					dataAttr[i].color = TsChart.colors[i % TsChart.colors.length];
			}
		},

		_moveTime : function() {
			if (this.refresh > 0) {
				if (this.drawed) {
					var linesData = this.linesData;

					var now = new Date().getTime();
					this._updateDynamicTime();
					lastMvTime = this.lastMvTime;

					if (!lastMvTime)
						this.lastMvTime = lastMvTime = linesData.minMax.maxTime;

					if ((now - lastMvTime) / linesData.timeResolution > 1) {
						linesData.shiftTimeOutData(now - this.chartAttr.timeRange * 60000);

						var focusIdx = this.focusIdx;
						this.focusIdx = -1;

						this._redrawLines();

						this.nearIdx = focusIdx;
						this._toggleLine();

						this.lastMvTime = now;
					}
				}
				var chart = this;
				window.setTimeout(function() {
					chart._moveTime();
				}, this.refresh * 1000);
			}
		},

		_drawGrid : function() {
			var gridGroup = this.chartGroup.group().attr('transform', this.offset);
			this.gridGroup = gridGroup;

			gridGroup.attr('style', 'pointer-events:none');

			var line;

			for (var i = 0; i < this.linesData.yScales.length; i++) {
				scale = this.linesData.yScales[i];

				line = gridGroup.line(0, scale[0], this.plotWidth, scale[0]).attr('class', 'gridStroke xgrid');
				line.draw();
			}

			for (var i = 0; i < this.linesData.xScales.length; i++) {
				scale = this.linesData.xScales[i];
				line = gridGroup.line(scale[0], 0, scale[0], this.plotHeight).attr('class', 'gridStroke ygrid');
				line.draw();
			}
		},

		_redrawLines : function() {
			var linesData = this.linesData;
			var plotData = linesData.plotData;
			var dataSegments = linesData.dataSegments;
			var polyLine;

			for (var i = 0; i < plotData.length; i++) {
				var segs = dataSegments[i];
				var start = 0, end = segs[0], pline;
				for (var j = 0; j < segs.length; j++) {
					end = segs[j];
					pline = linesData.polyLine[i][j];
					if (pline)
						pline.plot(plotData[i], start, end);
					start = end;
				}
			}
		},

		_drawLines : function() {
			
			var polylineG = this.chartGroup.group().attr('transform', this.offset);
			this.polylineGroup = polylineG;
			
			var linesData = this.linesData;
			var plotData = linesData.plotData;
			var dataSegments = linesData.dataSegments;
			var dataAttr = this.chartAttr.dataAttr;
			var color;
			for (var i = 0; i < plotData.length; i++) {
				color = '';
				if (dataAttr[i] && dataAttr[i].color)
					color = dataAttr[i].color;
				if (color == '' || color == null)
					color = TsChart.colors[i % TsChart.colors.length];

				var segs = dataSegments[i];
				if (segs && segs.length > 0) {
					linesData.polyLine[i] = new Array(segs.length);

					var start = 0, end = segs[0];
					for (var j = 0; j < segs.length; j++) {
						end = segs[j];
						var polyline = polylineG.polyline(plotData[i], start, end).attr('stroke-opacity', TsChart.plotOpacity).attr('stroke-linejoin', 'miter').attr('stroke-linecap', 'butt').attr('fill', 'none').attr('stroke-width', TsChart.plotWidth).attr('stroke', color).draw();
						start = end;
						linesData.polyLine[i][j] = polyline;
					}
				}
			}
		},

		_drawLegend : function(dataAttr) {
			var legendCanvas = this.legendCanvas;
			var ul = legendCanvas.ul, div = legendCanvas.div;
			div.style.height = 'auto';
			ul.style.height = 'auto';
			var color;

			for (var i = 0; i < dataAttr.length; i++) {
				color = '';
				if (dataAttr[i].color)
					color = dataAttr[i].color;
				if (color == '' || color == null)
					color = TsChart.colors[i % TsChart.colors.length];
				lengendNode = legendCanvas.add(dataAttr[i].title, color);
			}

			if (ul.clientHeight < 35)
				ul.style.height = '28px';
			else
				ul.style.height = '56px';

			this.legendHeight = div.clientHeight;

			legendCanvas._resize();
		},

		_updateDynamicTime : function() {
			var xAxisTexts = this.xAxisTexts;

			if (xAxisTexts.length <= 3) {
				var linesData = this.linesData;
				var minMax = linesData.minMax;
				var xScales = linesData.xScales;
				var steps = linesData.xSteps;
				var timeRange = this.chartAttr.timeRange * 60000;
				var end = new Date().getTime();
				var start = end - timeRange;
				var mid = end - timeRange / 2;

				minMax.minTime = start;
				minMax.maxTime = end;
				linesData.timeResolution = (end - start) / this.plotWidth;

				var label, scaleDate;

				if (xAxisTexts.length >= 1) {
					scaleDate = new Date(start);
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
					xAxisTexts[0].text(label);
					xScales[0][1] = label;
				}

				if (xAxisTexts.length >= 2) {
					scaleDate = new Date(mid);
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
					xAxisTexts[1].text(label);
					xScales[steps / 2][1] = label;
				}

				if (xAxisTexts.length >= 3) {
					scaleDate = new Date(end);
					label = TsChart.padStr(scaleDate.getHours()) + ':' + TsChart.padStr(scaleDate.getMinutes()) + ':' + TsChart.padStr(scaleDate.getSeconds());
					xAxisTexts[2].text(label);
					xScales[steps][1] = label;
				}
			}
		},

		_drawLabel : function() {
			var axisGroup = this.chartGroup.group().attr('transform', this.offset);
			this.axisGroup = axisGroup;

			var linesData = this.linesData;
			var plotWidth = this.plotWidth, plotHeight = this.plotHeight;

			axisGroup.attr('style', 'pointer-events:none');

			var hLine = axisGroup.line(0, plotHeight, plotWidth, plotHeight).attr('class', 'gridStroke axis');
			hLine.draw();

			this.xAxisTexts = [];

			var scale;
			for (var i = 0; i < linesData.xScales.length; i++) {
				scale = linesData.xScales[i];

				var scaleDash = axisGroup.line(scale[0], plotHeight, scale[0], plotHeight + 6).attr('class', 'gridStroke axis');
				scaleDash.draw();

				if (scale[1] != '')
					this.xAxisTexts.push(axisGroup.text(scale[0], plotHeight + 15 + 6, scale[1]).attr('class', 'text mText').draw());
			}

			var powNum = 1;
			if (linesData.yPower > 2 || (linesData.yPower >= 1 && linesData.yScales[0][1] > 1000)) {
				powNum = Math.pow(10, linesData.yPower);
			}

			for (var i = 0; i < linesData.yScales.length; i++) {
				scale = linesData.yScales[i];
				axisGroup.text(-6, plotHeight - scale[0] + 4, scale[1] / powNum).attr('class', 'text eText').draw();
			}

			if (powNum >= 10)
				axisGroup.text(0 + 6, 4, '(X ' + powNum + ')').attr('class', 'text sText').draw();
			if (linesData.noData)
				axisGroup.text(0 + 6, 4, '(WARN:The lines data is empty.)').attr('class', 'text sText').draw();
		},
		
		_getMouseXAndY: function(event){
			var chartG = this.instance;
			var coords = chartG.coords(event);
			var xPos = coords.x;
			var yPos = coords.y;
			var lineChart = chartG.lineChart;
			lineChart._hideSelect(chartG);
			lineChart._markLine(chartG, xPos, yPos);
			
			if (lineChart.mousemoveCallback) {
				lineChart.mousemoveCallback(xPos, yPos);
			}
		},

		_markLine : function(chartG, xPos, yPos) {
			var lineChart = chartG.lineChart;
			var focusIdx = lineChart.focusIdx;
			
			var realXStart = lineChart.realXStart, realXEnd = lineChart.realXEnd;
			var realYStart = lineChart.realYStart, realYEnd = lineChart.realYEnd;

			if (xPos >= realXStart && xPos <= realXEnd) {
				if (chartG.markLine && chartG.markLine != null) {
					chartG.markLine.plot(xPos, realYStart, xPos, realYEnd).show();
				} else {
					chartG.markLine = chartG.line(xPos, realYStart, xPos, realYEnd).defaultStroke().attr('stroke-width', 1).attr('stroke', '#CC0000').draw();
				}

				if (yPos >= realYStart && yPos <= realYEnd) {
					var linesData = lineChart.linesData;

					var nearInfo = linesData.getNearPoint(xPos - realXStart, yPos - realYStart);
					var allPoint = linesData.getAllPoint(xPos - realXStart, yPos - realYStart, focusIdx);
					if (allPoint.length > 0) {
						lineChart._markAllPoint(chartG, allPoint);
						lineChart.nearIdx = nearInfo.lineIdx;
						lineChart._drawAllHint(chartG, allPoint);
					} 
				}
			}else{
				if(lineChart.mouseleaveCallback){
					lineChart.mouseleaveCallback();
				}
			}
		},

		_markAllPoint : function(chartG, allPoint) {
			var lineChart = chartG.lineChart;
			var markAllPoint = new Array(allPoint.length);
			if (!chartG.markAllPoint) {
				chartG.markAllPoint = markAllPoint;
			}

			var lineChart = chartG.lineChart;
			var linesData = lineChart.linesData;
			var dataAttr = lineChart.chartAttr.dataAttr;
			var x, y, idx;
			var color = '';

			for (var i = 0; i < allPoint.length; i++) {
				var point = allPoint[i];
				x = point.px + lineChart.realXStart;
				y = point.py + lineChart.realYStart;
				idx = point.lineIdx;
				color = lineChart._getColor(dataAttr, idx);

				if (chartG.markAllPoint[i] && chartG.markAllPoint[i] != null) {
					chartG.markAllPoint[i].attr({
						'cx' : x,
						'cy' : y
					}).attr('fill', color).show();
				} else {
					chartG.markAllPoint[i] = chartG.circle(x, y, 6).attr('fill', color).draw();
				}
			}
		},

		_markPoint : function(chartG, nearInfo) {
			var lineChart = chartG.lineChart;
			var linesData = lineChart.linesData;
			var dataAttr = lineChart.chartAttr.dataAttr;
			var x = nearInfo.px + lineChart.realXStart, y = nearInfo.py + lineChart.realYStart;

			var idx = nearInfo.lineIdx;
			var color = lineChart._getColor(dataAttr, idx);

			if (chartG.markPoint && chartG.markPoint != null)
				chartG.markPoint.attr({
					'cx' : x,
					'cy' : y
				}).attr('fill', color).show();
			else
				chartG.markPoint = chartG.circle(x, y, 6).attr('fill', color).draw();
		},

		_focusLine : function() {
			var chartG = this.instance;
			var coords = chartG.coords(event);

			var lineChart = chartG.lineChart;
			if (chartG.dragCoords && (coords.x != chartG.dragCoords.x || coords.y != chartG.dragCoords.y))
				return;

			lineChart._toggleLine();
		},

		_toggleLine : function() {
			
			var linesData = this.linesData;
			var legendCanvas = this.legendCanvas;
			var legends = legendCanvas.legends;

			var focusIdx = this.focusIdx;
			var nearIdx = this.nearIdx;

			if (nearIdx < 0)
				return;
			var polylines;

			if (nearIdx != focusIdx) {
				for (var i = 0; i < linesData.polyLine.length; i++) {
					polylines = linesData.polyLine[i];
					if (i != nearIdx) {
						if (polylines) {
							for (var j = 0; j < polylines.length; j++)
								polylines[j].attr('opacity', TsChart.blurPlotOpacity).attr('stroke-width', TsChart.plotWidth);
						}
						if(legends[i]){
							legends[i].style.filter = 'alpha(opacity=30)';
							legends[i].style.opacity = 0.3;
						}
					}
					else {
						if (polylines) {
							for (var j = 0; j < polylines.length; j++)
								polylines[j].attr('opacity', TsChart.plotOpacity).attr('stroke-width', TsChart.focusPlotWidth);
						}
						if(legends[i]){
							legends[i].style.filter = 'alpha(opacity=100)';
							legends[i].style.opacity = 1;
						}
						var minOffsetTop = legends[0].offsetTop;
						if (legends[i].offsetTop - minOffsetTop != legendCanvas.ul.scrollTop)
							legendCanvas.ul.scrollTop = legends[i].offsetTop - minOffsetTop;
					}
				}
				this.focusIdx = nearIdx;
			} else {
				for (var i = 0; i < linesData.polyLine.length; i++) {
					polylines = linesData.polyLine[i];
					if (polylines) {
						for (var j = 0; j < polylines.length; j++)
							polylines[j].attr('opacity', TsChart.plotOpacity).attr('stroke-width', TsChart.plotWidth);
					}
					if(legends[i]){
						legends[i].style.filter = 'alpha(opacity=100)';
						legends[i].style.opacity = 1;
					}
				}
				this.focusIdx = -1;
			}
		},

		// author : MJR
		_getColor : function(dataAttr, idx) {
			var color = '';
			if (dataAttr[idx].color)
				color = dataAttr[idx].color;
			if (color == '' || color == null)
				color = TsChart.colors[idx % TsChart.colors.length];

			return color;
		},

		// author : MJR
		_drawAllHint : function(chartG, allPoint) {
			var lineChart = chartG.lineChart;
			var linesData = lineChart.linesData;
			var dataAttr = lineChart.chartAttr.dataAttr;
			var isActionPage = lineChart.chartAttr.isActionPage;
			if(isActionPage){
				var legendWidth = 12;
			}else{
				var legendWidth = 0;
			}
			
			var plotHeight = linesData.plotHeight;
			var hintRow = Math.floor(plotHeight / 20);// 对行数限制
			// -1是第一行的采集时间
			if(allPoint.length > hintRow - 1){
				hintRow = hintRow - 2;
			}else{
				hintRow = allPoint.length;
			}
			
			// 初始化
			var hintArray = new Array(allPoint.length);
			var markLegendArray = new Array(allPoint.length);
			if (!chartG.markInfo) {
				chartG.markInfo = hintArray;
			}
			if (!chartG.markLegend) {
				chartG.markLegend = markLegendArray;
			}
			
			// 初始化公共信息,取第一个点作为参考
			var nearInfo = allPoint[0];
			var x = nearInfo.px + lineChart.realXStart, y = 35;
			
			var direction = 'left';
			if (nearInfo.px > linesData.plotWidth / 2) {
				direction = 'right';
				x = x - 5 + legendWidth;
			}else {
				x = x + 5;
			}

			// 背景框
			if (!chartG.markBg || chartG.markBg == null)
				chartG.markBg = chartG.rect(x, y, 1, 1).attr('class', 'hintRect').attr({
					rx : 2,
					ry : 2
				}).hide().draw();

			// 采集时间
			var point = linesData.lineData[nearInfo.lineIdx][nearInfo.pointIdx];
			var timeStr = "采集时间:" + TsChart.epochToTimeStr(point[0], linesData.xNiceReslu);
			if(isActionPage){
				timeStr = "时间:" +  TsChart.epochToTimeStr(point[0], linesData.xNiceReslu);
			}
			if (chartG.markTime && chartG.markTime != null)
				chartG.markTime.moveTo(x + 20 - legendWidth, y).attr('fill', 'white').text(timeStr).show();
			else
				chartG.markTime = chartG.text(x + 16 - legendWidth, y, timeStr).attr({
					'pointer-events' : 'none',
					'font-family' : 'Verdana',
					'font-size' : 12,
					'opacity' : 0.95
				}).attr('fill', '#999999').draw();

			for (var i = 0; i < hintRow; i++) {
				var idx = allPoint[i].lineIdx;
				var color = lineChart._getColor(dataAttr, idx);

				var point = linesData.lineData[idx][allPoint[i].pointIdx];
				var title = (dataAttr[idx].title ? dataAttr[idx].title : '');
				var valStr = point[1] + (dataAttr[idx].valueUnit ? dataAttr[idx].valueUnit : '');
				
				if(chartG.markLegend[idx] && chartG.markLegend[idx] != null)
					chartG.markLegend[idx].plot(x + 4, y + 12 + 20 * i, 10, 4).show();
				else
					chartG.markLegend[idx] = chartG.rect(x + 4, y + 12 + 20 * i, 10, 4).attr('fill', color).draw();

				if(isActionPage){
					title = "值";// 监控查询页面图太小节省空间
					chartG.markLegend[idx].hide();
				}
				
				if (chartG.markInfo[idx] && chartG.markInfo[idx] != null){
					chartG.markInfo[idx].moveTo(x + 20 - legendWidth, y + 20 * (i + 1)).attr('fill', 'white').text(title + ':' + valStr).show();
				}
				else{
					chartG.markInfo[idx] = chartG.text(x + 20 - legendWidth, y + 20 * (i + 1), title + ':' + valStr).attr({
						'pointer-events' : 'none',
						'font-family' : 'Verdana',
						'font-size' : 12,
						'opacity' : 0.95
					}).attr('fill', 'white').draw();
				}
			}
			
			if(allPoint.length > hintRow + 1){
				if(chartG.markOmitted && chartG.markOmitted != null){
					chartG.markOmitted.moveTo(x + 20, y + 20 * hintRow + 15).attr('fill', 'white').text('...').show();
				}else{
					chartG.markOmitted = chartG.text(x + 20,  y + 20 * hintRow + 15, '...').attr({
						'pointer-events' : 'none',
						'font-family' : 'Verdana',
						'font-size' : 12,
						'opacity' : 0.95
					}).attr('fill', 'white').draw();
				}
			}
			
			// 获取最长的的数据宽度
			var bgWidth = 0;
			for (var i = 0; i < hintRow; i++) {
				var idx = allPoint[i].lineIdx;
				if (chartG.markInfo[idx].node.scrollWidth > bgWidth) {
					bgWidth = chartG.markInfo[idx].node.scrollWidth;
				}
			}
			if(bgWidth < chartG.markTime.node.scrollWidth){
				bgWidth = chartG.markTime.node.scrollWidth;
			}
			bgWidth = bgWidth + 22;

			var rx = x, ry = y;
			
			// 当鼠标在图的右边，内容移到左边
			if (nearInfo.px > linesData.plotWidth / 2){
				rx = rx - bgWidth;
				for (var i = 0; i < hintRow; i++) {
					var idx = allPoint[i].lineIdx;
					var color = lineChart._getColor(dataAttr, idx);
					var point = linesData.lineData[idx][allPoint[i].pointIdx];
					var title = (dataAttr[idx].title ? dataAttr[idx].title : '');
					var valStr = point[1] + (dataAttr[idx].valueUnit ? dataAttr[idx].valueUnit : '');
					
					if(chartG.markLegend[idx] && chartG.markLegend[idx] != null)
						chartG.markLegend[idx].plot(rx + 4, y + 12 + 20 * i, 10, 4).show();
					
					if(isActionPage){
						// 监控查询页面曲线图图太小节省空间
						title = "值";
						chartG.markLegend[idx].hide();
					}
					if (chartG.markInfo[idx] && chartG.markInfo[idx] != null)
						chartG.markInfo[idx].moveTo(rx + 20 - legendWidth, y + 20 * (i + 1)).attr('fill', 'white').text(title + ':' + valStr);
				}
				
				chartG.markTime.moveTo(rx + 20 - legendWidth, y).attr('fill', 'white').text(timeStr).show();
				if(allPoint.length > hintRow + 1){
					chartG.markOmitted.moveTo(rx + 20 , y + 20 * hintRow + 15).attr('fill', 'white').text('...').show();
				}
			}
			var bgHeight = 20 * (hintRow + 1);
			if(allPoint.length > hintRow + 1){
				bgHeight += 20;
			}
			
			chartG.markBg.plot(rx, ry - 15, bgWidth - legendWidth, bgHeight).show();
		},

		_drawHint : function(chartG, nearInfo) {

			var lineChart = chartG.lineChart;
			var linesData = lineChart.linesData;
			var dataAttr = lineChart.chartAttr.dataAttr;

			var anchor = 'start', dy = 0;
			var x = nearInfo.px + lineChart.realXStart, y = nearInfo.py + lineChart.realYStart;

			if (nearInfo.px > linesData.plotWidth / 2) {
				anchor = 'end';
				x = x - 16;
			} else {
				anchor = 'start';
				x = x + 10;
			}

			if (nearInfo.py > linesData.plotHeight / 2)
				y = y - 26;
			else
				y = y + 22;

			var idx = nearInfo.lineIdx;
			var color = lineChart._getColor(dataAttr, idx);

			var point = linesData.lineData[idx][nearInfo.pointIdx];
			var timeStr = "采集时间:" + TsChart.epochToTimeStr(point[0], linesData.xNiceReslu);
			var valStr = "采集值:" + point[1] + '' + (dataAttr[idx].valueUnit ? dataAttr[idx].valueUnit : '');
			var title = (dataAttr[idx].title ? "名称:" + dataAttr[idx].title : '');
			if (!chartG.markBg || chartG.markBg == null)
				chartG.markBg = chartG.rect(x, y, 1, 1).attr('class', 'hintRect').attr({
					rx : 2,
					ry : 2
				}).hide().draw();

			if (chartG.markTitle && chartG.markTitle != null)
				chartG.markTitle.moveTo(x, y).attr('fill', color).attr('text-anchor', anchor).text(title).show();
			else
				chartG.markTitle = chartG.text(x, y, title).attr({
					'pointer-events' : 'none',
					'font-family' : 'Verdana',
					'font-weight' : 'bold',
					'font-size' : 12,
					'opacity' : 0.95
				}).attr('fill', color).attr('text-anchor', anchor).draw();

			if (chartG.markTime && chartG.markTime != null)
				chartG.markTime.moveTo(x, y + 16).attr('fill', color).attr('text-anchor', anchor).text(timeStr).show();
			else
				chartG.markTime = chartG.text(x, y + 16, timeStr).attr({
					'pointer-events' : 'none',
					'font-family' : 'Verdana',
					'font-weight' : 'bold',
					'font-size' : 12,
					'opacity' : 0.95
				}).attr('fill', color).attr('text-anchor', anchor).draw();

			if (chartG.markVal && chartG.markVal != null)
				chartG.markVal.moveTo(x, y + 32).attr('fill', color).attr('text-anchor', anchor).text(valStr).show();
			else
				chartG.markVal = chartG.text(x, y + 32, valStr).attr({
					'pointer-events' : 'none',
					'font-family' : 'Verdana',
					'font-weight' : 'bold',
					'font-size' : 12,
					'opacity' : 0.95
				}).attr('fill', color).attr('text-anchor', anchor).draw();

			var bgWidth = chartG.markTime.node.scrollWidth;
			if (bgWidth < chartG.markVal.node.scrollWidth)
				bgWidth = chartG.markVal.node.scrollWidth;
			if (bgWidth < chartG.markTitle.node.scrollWidth)
				bgWidth = chartG.markTitle.node.scrollWidth;
			var bgHeight = chartG.markTime.node.scrollHeight;

			bgWidth = bgWidth;
			bgHeight = bgHeight;

			var rx = x, ry = y;
			if (nearInfo.px > linesData.plotWidth / 2)
				rx = rx - bgWidth - 4;
			else
				rx = rx - 4;

			if (nearInfo.py > linesData.plotHeight / 2)
				ry = ry - bgHeight - 3;
			else
				ry = ry - bgHeight - 3;

			chartG.markBg.plot(rx, ry, bgWidth + 8, bgHeight * 3 + 8).show();
		},

		_selectMove : function() {

			var chartG = this.instance;
			var lineChart = chartG.lineChart;

			if (lineChart.refresh)
				return;

			var coords = chartG.coords(event);

			var realXStart = lineChart.realXStart, realXEnd = lineChart.realXEnd;
			var realYStart = lineChart.realYStart, realYEnd = lineChart.realYEnd;

			if (chartG.dragStart) {
				if (coords.x >= realXStart && coords.x <= realXEnd) {
					if (!chartG.dragRect || chartG.dragRect == null) {
						if (coords.x >= chartG.dragStart)
							chartG.dragRect = chartG.rect(chartG.dragStart, realYStart, coords.x - chartG.dragStart, realYEnd - realYStart);
						else
							chartG.dragRect = chartG.rect(coords.x, realYStart, chartG.dragStart - coords.x, realYEnd - realYStart);

						// chartG.dragRect.attr({'fill':'#029fe4',
						// 'opacity':0.3,
						// 'stroke':'none'});
						chartG.dragRect.attr({
							'fill' : '#CC0000',
							'opacity' : 0.3,
							'stroke' : 'none'
						});
						chartG.dragRect.draw();
					} else {
						if (coords.x >= chartG.dragStart)
							chartG.dragRect.plot(chartG.dragStart, realYStart, coords.x - chartG.dragStart, realYEnd - realYStart).show();
						else
							chartG.dragRect.plot(coords.x, realYStart, chartG.dragStart - coords.x, realYEnd - realYStart).show();
					}
				}
			}
		},

		_startSelect : function() {
			var chartG = this.instance;
			var lineChart = chartG.lineChart;

			var coords = chartG.coords(event);
			chartG.dragCoords = coords;

			if (lineChart.refresh)
				return;

			if (coords.x >= lineChart.realXStart && coords.x <= lineChart.realXEnd) {
				chartG.dragStart = coords.x;

				chartG.on('mousemove', chartG.lineChart._selectMove);
			}
		},

		_endSelect : function() {
			var chartG = this.instance;
			var lineChart = chartG.lineChart;

			if (lineChart.refresh)
				return;

			var coords = chartG.coords(event);

			chartG.off('mousemove', chartG.lineChart._selectMove);

			if (coords.x >= lineChart.realXStart && coords.x <= lineChart.realXEnd) {
				chartG.dragEnd = coords.x;
			} else if (coords.x > lineChart.realXEnd) {
				chartG.dragEnd = lineChart.realXEnd;
			} else if (coords.x < lineChart.realXStart) {
				chartG.dragEnd = lineChart.realXStart;
			}

			if (chartG.dragRect && chartG.dragRect != null) {
				chartG.dragRect.hide();
				// chartG.dragRect = null;
				// chartG.dragEnd - lineChart.realXStart
			    // 正方向drag
				if(chartG.dragEnd - lineChart.realXStart > chartG.dragStart - lineChart.realXStart)
					lineChart._zoom(chartG.dragStart - lineChart.realXStart, chartG.dragEnd - lineChart.realXStart);
				else
					lineChart._zoom(chartG.dragEnd - lineChart.realXStart, chartG.dragStart - lineChart.realXStart);
			}
		},

		_clearSelect : function() {
			var target = event.target ? event.target : event.srcElement;
			var eventObj = target.instance;
			var chartG = this.instance;
			var lineChart = chartG.lineChart;

			if (eventObj == chartG) {
				if (chartG.markLine && chartG.markLine != null)
					chartG.markLine.hide();

				if (chartG.markPoint && chartG.markPoint != null)
					chartG.markPoint.hide();

				if (chartG.markAllPoint && chartG.markAllPoint != null) {
					for (var i = 0; i < chartG.markAllPoint.length; i++) {
						chartG.markAllPoint[i].hide();
					}
				}
				if (chartG.markTime && chartG.markTime != null)
					chartG.markTime.hide();

				if (chartG.markVal && chartG.markVal != null)
					chartG.markVal.hide();
				
				if(chartG.markOmitted && chartG.markOmitted != null)
					chartG.markOmitted.hide();

				if (chartG.markInfo && chartG.markInfo != null) {
					for (var i = 0; i < chartG.markInfo.length; i++) {
						if(chartG.markInfo[i]){
							chartG.markInfo[i].hide();
						}
					}
				}
				if (chartG.markLegend && chartG.markLegend != null) {
					for (var i = 0; i < chartG.markLegend.length; i++) {
						if(chartG.markLegend[i]){
							chartG.markLegend[i].hide();
						}
					}
				}
				
				if (chartG.markBg && chartG.markBg != null)
					chartG.markBg.hide();

				// chartG.lineChart.endSelect.apply(this, event);
				var lineChart = chartG.lineChart;
				chartG.off('mousemove', chartG.lineChart._selectMove);
				chartG.dragStart = -1;

				if (chartG.dragRect && chartG.dragRect != null) {
					chartG.dragRect.hide();
				}
			}
		},
		
		_hideSelect : function(chartG) {
			var lineChart = chartG.lineChart;
			if (chartG.markLine && chartG.markLine != null)
				chartG.markLine.hide();

			if (chartG.markPoint && chartG.markPoint != null)
				chartG.markPoint.hide();

			if (chartG.markAllPoint && chartG.markAllPoint != null) {
				for (var i = 0; i < chartG.markAllPoint.length; i++) {
					chartG.markAllPoint[i].hide();
				}
			}
			if (chartG.markTime && chartG.markTime != null)
				chartG.markTime.hide();

			if (chartG.markVal && chartG.markVal != null)
				chartG.markVal.hide();
			
			if(chartG.markOmitted && chartG.markOmitted != null)
				chartG.markOmitted.hide();

			if (chartG.markInfo && chartG.markInfo != null) {
				for (var i = 0; i < chartG.markInfo.length; i++) {
					if(chartG.markInfo[i]){
						chartG.markInfo[i].hide();
					}
				}
			}
			if (chartG.markLegend && chartG.markLegend != null) {
				for (var i = 0; i < chartG.markLegend.length; i++) {
					if(chartG.markLegend[i]){
						chartG.markLegend[i].hide();
					}
				}
			}
			if (chartG.markBg && chartG.markBg != null)
				chartG.markBg.hide();
			
		},

		_zoom : function(xBegin, xEnd) {
			var linesData = this.linesData;
			var his = this.history;
			if (his.length > TsChart.hisCount)
				his.shift();

			if (his.length == 0) {// 最初的状态
				his.push({
					'startTime' : this.chartAttr.startTime,
					'endTime' : this.chartAttr.endTime
				});
			}

			if (Math.abs(xEnd - xBegin) > 10) {
				if (xEnd > xBegin)
					linesData.sliceData(this.chartAttr, xBegin, xEnd);
				else if (xEnd < xBegin)
					linesData.sliceData(this.chartAttr, xEnd, xBegin);

				// this.redraw();
				this.drawed = false;

				var focusIdx = this.focusIdx;
				this.focusIdx = -1;

				this.chartGroup.remove();
				this._init(this.node);

				this._draw();
				this.nearIdx = focusIdx;
				this._toggleLine();

				var tmResolution = linesData.timeResolution;
				var minTime = linesData.minMax.minTime;
				var startTime = minTime + xBegin * tmResolution;
				var endTime = minTime + xEnd * tmResolution

				this.chartAttr.startTime = parseInt(startTime);
				this.chartAttr.endTime = parseInt(endTime);
				this.chartAttr.beginTime = parseInt(startTime);
				// this.chartAttr.data = linesData.lineData;
				this.chartAttr.data = [];
				his.push({
					'startTime' : this.chartAttr.startTime,
					'endTime' : this.chartAttr.endTime
				});
				if (this.zoomCallback)
					this.zoomCallback(this, minTime + xBegin * tmResolution, minTime + xEnd * tmResolution);
			}
		}
	};

	TsChart.LegendCanvas = function(lineChart, container, nolegends) {
		var chartCanvas;
		if (typeof container == 'object') {
			chartCanvas = container;
		} else {
			chartCanvas = document.getElementById(container);
		}

		this.legends = [];
		this.chart = lineChart;

		// for legend outer container div
		var div = document.createElement('div');
		div.setAttribute('class', 'lgdiv');

		// legent list container ul
		var ul = document.createElement('ul');
		ul.setAttribute('class', 'legends');

		// this ul node for two legend scroll button, default is invisible
		// when the scrollHeight bigger than the clientHeight, it will be shown
		var sul = document.createElement('ul');
		sul.setAttribute('class', 'lgscroll');

		// for legend scroll up
		var up = document.createElement('li');
		up.setAttribute('class', 'up');
		up.instance = this;
		sul.appendChild(up);
		// for legend scroll down
		var down = document.createElement('li');
		down.setAttribute('class', 'down');
		down.instance = this;
		sul.appendChild(down);

		// append the legend dom to the chart container div
		div.appendChild(ul);
		div.appendChild(sul);
		chartCanvas.appendChild(div);

		// record the legend child nodes container
		this.canvas = chartCanvas;
		this.div = div;
		this.ul = ul;
		this.sul = sul;

		// resize for the scroll button show or hide
		var instance = this;
		window.addEventListener('resize', function() {
			instance._resize()
		});

		// for the scroll event process
		up.addEventListener('click', this._up);
		down.addEventListener('click', this._down);

		if (nolegends) {
			div.style.display = "none";
		}
	}

	TsChart.LegendCanvas.prototype = {
		add : function(title, color) {
			var li = document.createElement('li');
			var i = document.createElement('i');
			i.style.backgroundColor = color;
			var t = document.createTextNode(title);
			li.appendChild(i);
			li.appendChild(t);

			this.ul.appendChild(li);

			if (this.ul.scrollHeight > this.ul.clientHeight)
				this.sul.style.display = 'block';

			// use the Array this.legends to record all the legends, use array
			// index
			// to map to the line
			this.legends.push(li);
			li.instance = this;
			li.lineIndex = this.legends.length - 1;
			li.addEventListener('click', this._toggleLegend);

			return li;
		},

		removeAll : function() {
			while (this.ul.firstChild) {
				this.ul.removeChild(this.ul.firstChild);
			}

			this.legends = [];
		},

		// below is private methods
		_resize : function() {
			if (this.ul.scrollHeight > this.ul.clientHeight)
				this.sul.style.display = 'block';
			else
				this.sul.style.display = 'none';
		},

		_toggleLegend : function() {
			var legendCanvas = this.instance;
			var lineIndex = this.lineIndex;

			var chart = legendCanvas.chart;
			if (chart.clickLineCallback) {
				var dataAttr = chart.chartAttr.dataAttr[lineIndex];
				chart.clickLineCallback(this, dataAttr);
			}
			chart.nearIdx = lineIndex;
			chart._toggleLine();
		},

		_up : function() {
			var legendContainer = this.instance;
			var canvas = legendContainer.ul;
			var scrollTop = canvas.scrollTop;
			scrollTop = scrollTop - canvas.clientHeight;
			if (scrollTop < 0)
				scrollTop = 0;
			canvas.scrollTop = scrollTop;
			return this;
		},

		_down : function() {
			var legendContainer = this.instance;
			var canvas = legendContainer.ul;
			var scrollHeight = canvas.scrollHeight;
			var scrollTop = canvas.scrollTop;
			scrollTop = scrollTop + canvas.clientHeight;
			if (scrollTop > scrollHeight)
				scrollTop = scrollHeight - legendContainer.height;
			canvas.scrollTop = scrollTop;
			return this;
		}
	};

	return TsChart;
}));