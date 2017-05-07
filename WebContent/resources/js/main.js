$(function(){
    $(".tip>button").click(function(){
        var idx = $(this).closest("li").index();
        window.location.href="number.html?idx=" + idx;
    });


    $(".number-list ul li").click(function(){
        $(this).index()
    })

})