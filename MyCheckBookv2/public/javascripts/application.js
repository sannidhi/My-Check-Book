// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function swapDisplay(to_hide, to_show) {
	$(to_hide).hide("slow");
	$(to_show).show("slow");
	
	$(to_show+' input[type=text]').focus();
}