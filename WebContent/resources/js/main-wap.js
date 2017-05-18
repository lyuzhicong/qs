 $(function() {
     $(".menu").click(function() {
         if ($("#floatmenu").css("display") == "none") {
             $("#floatmenu").slideDown("slow");
             $(".mask").show();
         } else {
             $("#floatmenu").slideUp("fast");
             $(".mask").hide();
         }

     })


 })