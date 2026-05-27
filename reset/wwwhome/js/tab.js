(function($) {
	$(function() {
		$('li a', 'ol.navi1').click(function(e) {
			e.preventDefault();
			if($(this).attr('href') == 'c2.asp') {			
				$('ul').load('c2.asp ul>li', function() {
					$(this).stop();
				});
			} else {
				$('ul').load('c1.asp ul>li', function() {
					$(this).stop();
				});
			}
		});	
	});	
})(jQuery);