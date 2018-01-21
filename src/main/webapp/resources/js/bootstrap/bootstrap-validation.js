;
(function($) {
	var globalOptions = {
		validRules : [
				{
					name : 'required',
					validate : function(value) {
						return ($.trim(value) == '');
					},
					defaultMsg : '${tk:lang("请输入内容")}'
				},
				{
					name : 'number',
					validate : function(value) {
						if (value == '') {
							return false;
						}
						return (!/^[0-9]\d*$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入数字")}'
				},
				{
					name : 'mail',
					validate : function(value) {
						if (value == '') {
							return false;
						}
						return (!/^[_a-zA-Z0-9-]{1}([\._a-zA-Z0-9-]+)(\.[_a-zA-Z0-9-]+)*@[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+){1,3}$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入邮箱地址")}'
				},
				{
					name : 'char',
					validate : function(value) {
						return (!/^[a-z\_\-A-Z]*$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入英文字符")}'
				},
				{
					name : 'chinese',
					validate : function(value) {
						return (!/^[\u4e00-\u9fff]$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入汉字")}'
				},
				{
					name : 'dbindex',
					validate : function(value) {
						return (!/^[\d]+,[\d]+$/.test(value));
					},
					defaultMsg : '${tk:lang("格式不正确")}'
				},
				{
					name : 'smtp',
					validate : function(value) {
						return (!/^smtp\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+){1,3}(\:[0-9]+){0,1}$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入正确的SMTP服务器地址")}'
				},
				{
					name : 'pop',
					validate : function(value) {
						return (!/^pop\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+){1,3}(\:[0-9]+){0,1}$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入正确的POP服务器地址")}'
				},
				{
					name : 'imap',
					validate : function(value) {
						return (!/^imap\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+){1,3}(\:[0-9]+){0,1}$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入正确的IMAP服务器地址")}'
				},
				{
					name : 'ip',
					validate : function(value) {
						if (value != '') {
							return (!/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/
									.test(value));
						} else {
							return false;
						}
					},
					defaultMsg : '${tk:lang("请输入正确的IP地址")}'
				}, {
					name : 'maxNum',
					validate : function(value) {
						return (!/^[0-9]\d*|(\-1)$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入-1或正数")}'
				}, {
					name : 'PeriodOfTime',
					validate : function(value) {
						return (!/^(?:[0-1]?[0-9]|2[0-3]):[0-5]?[0-9]-(?:[0-1]?[0-9]|2[0-3]):[0-5]?[0-9](?: +(?:[0-1]?[0-9]|2[0-3]):[0-5]?[0-9]-(?:[0-1]?[0-9]|2[0-3]):[0-5]?[0-9])*$/.test(value));
					},
					defaultMsg : '${tk:lang("请输正确的时间段,格式为10:00-12:00,多个用空格隔开.")}'
				}, {
					name : 'port',
					validate : function(value) {
						if (value == '') {
							return false;
						}
						if (isNaN(value)) {
							return true;
						}

						if (parseInt(value, 10) != value) {
							return true;
						}

						if (parseInt(value, 10) < 0 || parseInt(value) > 65535) {
							return true;
						}
						return false;
					},
					defaultMsg : '${tk:lang("请输入0至65535之间的整数")}'
				}, {
					name : 'integer_p',
					validate : function(value) {
						if (value == '')
							return false;
						if (isNaN(value))
							return true;
						if (parseInt(value) != value)
							return true;
						if (parseInt(value) <= 0)
							return true;
						return false;
					},
					defaultMsg : '${tk:lang("请输入正整数")}'
				}, {
					name : 'integer',
					validate : function(value) {
						if (isNaN(value))
							return true;
						if (parseInt(value) != value)
							return true;
						return false;
					},
					defaultMsg : '${tk:lang("请输入整数")}'
				}, {
					name : 'range',
					validate : function(value) {
						if (value.indexOf('-') == -1) {
							return true;
						} else {
							var vs = value.split('-');
							if (vs.length != 2) {
								return true;
							}
							if (isNaN(parseFloat(vs[0])) || isNaN(parseFloat(vs[1]))) {
								return true;
							}
							if (parseFloat(vs[0]) > parseFloat(vs[1])) {
								return true;
							}
						}
						return false;
					},
					defaultMsg : '${tk:lang("请按照格式要求输入")}'
				}, {
					name : 'stepindex',
					validate : function(value) {
						value = $.trim(value);
						if (value != '') {
							if (value.indexOf('.') > -1) {
								var vl = value.split('.');
								for ( var v in vl) {
									if (v % 2 == 0) {
										if (isNaN(parseInt(vl[v], 10))) {
											return true;
										}
									} else {
										if(vl[v].length != 1){
											return true;
										}
										var cc = vl[v].charCodeAt();
										if ((cc >= 65 && cc <= 90) || (cc >= 97 && cc <= 122)) {

										} else {
											return true;
										}
									}
								}
							} else {
								if (isNaN(parseInt(value, 10))) {
									return true;
								}
							}
						} else {
							return false;
						}
					},
					defaultMsg : '${tk:lang("请输入序号,格式范例：1或1.A或1.A.1")}'
				}, {
					name : 'enchar',
					validate : function(value) {
						return (!/^[a-z\_\-A-Z\d\.\_]*$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入英文字符或数字")}'
				} ,{
					name : 'enchar_space',
					validate : function(value) {
						return (!/^[a-z\_\-A-Z\d\.\ \_]*$/.test(value));
					},
					defaultMsg : '${tk:lang("请输入英文字符或数字,允许空格")}'
				} ]
	};
	$(function() {
		$(document).on('focus change', '[check-type]', function() {
			validateField(this, false);
		});
	});

	var validateField = function(field, needscroll) { // 验证字段
		var el = $(field), error = false, errorMsg = '';
		if ((el.is(':hidden') && !el.hasClass('mustinput')) || el.prop('disabled')) {// 无需验证
			return true;
		}
		var valid = el.attr('check-type').split(' ');
		for (i = 0; i < valid.length; i++) {
			var x = true, flag = valid[i], msg = el.attr(flag + '-message');
			if (flag.substr(0, 1) == '!') {
				x = false;
				flag = flag.substr(1, flag.length - 1);
			}

			var rules = globalOptions.validRules;
			for (j = 0; j < rules.length; j++) {
				var rule = rules[j];
				if (rule && flag == rule.name) {
					if (rule.validate.call(field, el.val()) == x) {
						error = true;
						errorMsg = msg || rule.defaultMsg;
						break;
					}
				}
			}

			if (error) {
				break;
			}
		}
		if (error) {
			if (el.data('show-valid-error')) {
				if (el.is(':visible')) {
					el.tooltip('destroy');
				} else {
					if (el.parent().length == 1) {
						el.parent().tooltip('destroy');
					}
				}
			}
			if (el.is(':visible')) {
				el.tooltip({
					trigger : 'manual',
					animation : false,
					placement : function(pop, node) {
						if ($('body').width() - $(node).offset().left - $(node).outerWidth() < 100) {
							return 'top';
						}
						return 'right';
					},
					html : true,
					title : function() {
						return errorMsg;
					}
				}).tooltip('show');
				if (needscroll) {
					if ($(window).scrollTop() != 0) {
						scrollTo(0, el.offset().top - 50 < 0 ? 0 : el.offset().top - 50);
					}
				}
			} else {
				if (el.parent().length == 1) {
					el.parent().tooltip({
						trigger : 'manual',
						animation : false,
						placement : function(pop, node) {
							if ($('body').width() - $(node).offset().left - $(node).outerWidth() < 100) {
								return 'top';
							}
							return 'right';
						},
						html : true,
						title : errorMsg
					}).tooltip('show');
					if (needscroll) {
						if ($(window).scrollTop() != 0) {
							scrollTo(0, el.parent().offset().top - 50 < 0 ? 0 : el.parent().offset().top - 50);
						}
					}
				}
			}
			el.data('show-valid-error', true);
		} else {
			if (el.data('show-valid-error')) {
				if (el.is(':visible')) {
					el.tooltip('destroy');
				} else {
					if (el.parent().length == 1) {
						el.parent().tooltip('destroy');
					}
				}
				el.data('show-valid-error', false);
			}
		}
		return !error;
	};

	$.fn.valid = function(options) {
		var validationError = false;
		this.each(function() {
			$('input[check-type], textarea[check-type], select[check-type]', this).each(function() {
				var el = $(this);
				if (!validateField(this, true)) {
					validationError = true;
				}
			});
		});
		return validationError ? false : true;
	};

})(jQuery);