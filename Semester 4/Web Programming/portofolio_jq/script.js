$(function(){

	var current_li;

	$("#portfolio img").click(function(){
		var src = $(this).attr("src");
		current_li = $(this).parent();
		$("#main").attr("src", src);
		$("#frame").fadeIn();
		$("#overlay").fadeIn();
	});

	$("#overlay").click(function(){
		$(this).fadeOut();
		$("#frame").fadeOut();
	});

	$("#right").click(function(){

		if(current_li.is(":last-child")){

			var next_li = $("#portfolio li").first();

		}else{
			var next_li = current_li.next();
		}
		
		var next_src = next_li.children("img").attr("src");
		$("#main").attr("src", next_src);
		current_li = next_li;
	});

	$("#left").click(function(){

		if(current_li.is(":first-child")){

			var prev_li = $("#portfolio li").last();

		}else{
			var prev_li = current_li.prev();
		}

		var prev_src = prev_li.children("img").attr("src");
		$("#main").attr("src", prev_src);
		current_li = prev_li;
	});

	$("#right img, #left img").mouseover(function(){
		$(this).css("opacity", "1");
	});

	$("#right img, #left img").mouseleave(function(){
		$(this).css("opacity", "0.5");
	});
});