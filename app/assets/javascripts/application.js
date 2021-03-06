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
//= require turbolinks
//= require jquery.turbolinks

function goToByScroll(id){
        $('html,body').animate({scrollTop: $("#"+id).offset().top},'slow');
}

function getURLParameter(name) {
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}

function getParametera(param) {
            var val = document.URL;
            var url = val.substr(val.indexOf(param))  
            var n=parseInt(url.replace(param+"=",""));
            return n;
}

$(document).ready(function(){

	$(".comment_edit").live("click", function(){
		$(".underlay").fadeIn()
		$(".overlay").fadeIn()
		c = $(this).parent().parent().find("div")
		cid = c.attr("id")
		$(".overlay form").attr("action", "/comments/"+cid.toString(10))
		$(".overlay form").attr("id", "edit_comment_"+cid.toString(10))
		$(".overlay form textarea").html(c.find(".comment_raw").text())
	});
	$(".close_overlay").click(function(){
		$(".underlay").fadeOut()
		$(".overlay").fadeOut()
	});
	$(".underlay").click(function(){
		$(".underlay").fadeOut()
		$(".overlay").fadeOut()
	});
	$(".dismiss-all").click(function(){
		d = $(".dismiss").length
		for (i=0;i<d;i++) {
			($(".dismiss")[i]).click()
			console.log(i)
			console.log($(".dismiss")[i])
		}
	});
	$("input#unfollow").live("mouseenter", function(){
		$("input#unfollow").val("Stop Following");
		$("input#unfollow").addClass("btn-danger");
	});
	$("input#unfollow").live("mouseleave", function(){
		$("input#unfollow").val("Following Post");
		$("input#unfollow").removeClass("btn-danger");
	});
	$(".overlay form .actions input").click(function(){$(".close_overlay").click()})

	if (($(location).attr('href')).split("#")[1] === "n") {
		$("a#n_button").click()
	} else if (($(location).attr('href')).indexOf("#") > -1) {
		goToByScroll(($(location).attr('href')).split("#")[1]);
	}

	$(".notifications_button").click(function(){
		$("#n_button").click()
	});

	if ($.url().param('forum')) {
		$("#post-forum-select").val($.url().param('forum').toString(10))
	}

	$("input#search").keyup(function(){
		$("#front-page-loading").removeClass("hidden")
		$(this).closest("form").submit()
		$("li.active").removeClass("active")
		$("li#0").addClass("active")
		$("#front-page-loading").addClass("hidden")
	});

	$("#posts_search").submit(function(){
		$.get(this.action, $(this).serialize(), null, "script")
		return false;
	});

	$(".pagination a").live("click", function() {
		$("#front-page-loading").removeClass("hidden")
		$.get(this.href, null, function(){$("#front-page-loading").addClass("hidden");$("li.active").removeClass("active");$(".tabbable .navbar .navbar-inner ul.nav li#"+$("#forum_id").text().replace(/\s+/g, ' ')[1]).addClass("active");}, "script")
		return false;
	});

	$(".nav#forumnav li a").live("click", function(){
		$("#front-page-loading").removeClass("hidden")
		$.get(this.href, null, function(){$("#front-page-loading").addClass("hidden");$("input#search").val("");$("li.active").removeClass("active");$(".tabbable .navbar .navbar-inner ul.nav li#"+$("#forum_id").text().replace(/\s+/g, ' ')[1]).addClass("active");}, "script")
		return false;
	})

	$("textarea#wmd-input").keyup(function() {
		if ($(this).val() === ""){
			$("#comment-preview").hide()
		}else{
			$("#comment-preview").show()
		}
	});
});

$(document).on('page:fetch', function() {
	t = $('#content-container').height();
	$('#content-container').hide();
	$('#page_loading').show().height(t);
	
});
$(document).on('page:change', function() {
	if ($('#content-container').length > 0){
		$('#page_loading').hide();
		$('#content-container').show();
	} else {
		$("#front-page-change").show();
		$('#font-page_loading').hide()
	}
});
