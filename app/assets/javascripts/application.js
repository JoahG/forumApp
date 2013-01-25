// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require twitter/bootstrap

function goToByScroll(id){
        $('html,body').animate({scrollTop: $("#"+id).offset().top},'slow');
}

$(document).ready(function(){
	$(".comment_edit").click(function(){
		$(".underlay").fadeIn()
		$(".overlay").fadeIn()
		c = $(this).parent().parent().find("div")
		cid = c.attr("id")
		$(".overlay form").attr("action", "/comments/"+cid.toString(10))
		$(".overlay form").attr("id", "edit_comment_"+cid.toString(10))
		$(".overlay form textarea").text(c.find(".comment_raw").text())
	});
	$(".close_overlay").click(function(){
		$(".underlay").fadeOut()
		$(".overlay").fadeOut()
	});
	$(".underlay").click(function(){
		$(".underlay").fadeOut()
		$(".overlay").fadeOut()
	});
});