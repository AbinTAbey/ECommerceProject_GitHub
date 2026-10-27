$(function(){

    /////  Open Menubar
    $(document).on("click", ".openNav", function (e) {
        e.preventDefault();
        $('.menu-section').show();
   });

   /////  Close Menubar

   $(document).on("click", ".closeNav", function (e) {
    e.preventDefault();
    $('.menu-section').hide();
  });


   //// Outside click Menubar Hide

   $(document).on('click', function (e) {
      if ($(e.target).find(".menu-sidebar").parent().length === 1) {
        $('.menu-section').hide();
      }
  });


       ////////////// Carousel ////

    if (typeof $.fn.owlCarousel !== 'undefined') {

        $('.slider').owlCarousel({
            responsiveClass: true,
            lazyLoad: true,
            loop: true,
            autoplay: true,
            dots: false,
            itemsScaleUp: false,
            responsive: {
                 0: {
                      items: 1,
                      nav: false,
                 },
                 600: {
                      items: 1,
                      nav: false,
                 },
                 1000: {
                      items: 1,
                      nav: true,
                 }
            }
       });
    
       $('.product-slider').owlCarousel({
            responsiveClass: true,
            lazyLoad: true,
            dots: false,
            responsive: {
                 0: {
                      items: 3,
                      nav: false,
                 },
                 600: {
                      items: 5,
                      nav: false,
                 },
                 1000: {
                      items: 7,
                      nav: true,
                      loop: false
                 }
            }
       });
    
       $('.similar-product-slider').owlCarousel({
        responsiveClass: true,
        dots: false,
        responsive: {
             0: {
                  items: 2,
                  nav: false,
             },
             600: {
                  items: 3,
                  nav: false,
             },
             1000: {
                  items: 6,
                  nav: true,
                  loop: false
             }
        }
    });

    } 


        //////  Counter Increament

        $('.count-increament').click(function(e){
            var count = $(this).prev().val();
             count++
            $(this).prev().val(count);
       });
  
        //////  Counter Decreament
  
       $('.count-decreament').click(function(e){
            var count = $(this).next().val();
            count--;
            if(count > 0){
              $(this).next().val(count);
            }
       });


           ////// Continue Checkout

     $(document).on("click", ".checkout-btn", function (e) {
        e.preventDefault();
          $('.login-check').addClass('hidden');
          $('.logined').removeClass('hidden');
      });

      ////// Change continue checkout

      $(document).on("click", ".login-change-btn", function (e) {
        e.preventDefault();
          $('.login-check').removeClass('hidden');
          $('.logined').addClass('hidden');
      }); 


      ////// Save Address

      $(document).on("click", ".save-address-btn", function (e) {
        e.preventDefault();
          $('.add-new-addrrss').addClass('hidden');
          $('.addressSave').removeClass('hidden');
      });

      /////// Change Address

      $(document).on("click", ".address-change-btn", function (e) {
        e.preventDefault();
          $('.add-new-addrrss').removeClass('hidden');
          $('.addressSave').addClass('hidden');
      });

      
      ///// Save Cart  

     $(document).on("click", ".save-cart-btn", function (e) {
        e.preventDefault();
          $('.review-cart').addClass('hidden');
          $('.cartSave').removeClass('hidden');
      });

     ///// Change Cart

     $(document).on("click", ".cart-change-btn", function (e) {
        e.preventDefault();
          $('.review-cart').removeClass('hidden');
          $('.cartSave').addClass('hidden');
      });

    ////// Filter Section  /////

    $(document).on("click", ".collopse", function () {
        $(this).nextAll(".item-list:first").toggle();
        $(this).find(".chevron-down").toggleClass("rotate-180");
    });

    $(document).on("click", ".sort-per", function () {
        $(this).addClass("active");
        $(this).nextAll(".sort-per").removeClass("active");
        $(this).prevAll(".sort-per").removeClass("active");
    });
    $(document).on("click", ".m-sort-per", function () {
        $(this).addClass("m-active");
        $(this).nextAll(".m-sort-per").removeClass("m-active");
        $(this).prevAll(".m-sort-per").removeClass("m-active");
    });

    $(document).on("click", ".links-click", function (e) {
        e.preventDefault();
        $(this).addClass('active').parent().siblings().children().removeClass('active');
    });

    $(document).on("click", ".close-m-filter", function (e) {
        e.preventDefault();
        $('.m-filter').hide();
    });
    $(document).on("click", ".open-filter", function (e) {
        e.preventDefault();
        $('.m-filter').show();
    });
    $(document).on("click", ".more-item-btn", function (e) {
        e.preventDefault();
        $(this).addClass('hidden');
        $('.more-items').removeClass('hidden');
    });



                ////// Product Page

                $(document).on("click", ".links-click", function (e) {
                    e.preventDefault();
                    $(this).addClass('border-2 border-blue-600').parent().siblings().children().removeClass('border-2 border-blue-600');
               });
               $(document).on("click", ".size-click", function (e) {
                    e.preventDefault();
                    $(this).addClass('border-blue-600').parent().siblings().children().removeClass('border-blue-600');
               });
               $(document).on("click", ".onClickShow", function (e) {
                    e.preventDefault();
                    $('.more-details').removeClass('hidden');
                    $('.see-all-product-details').addClass('hidden');  
               });
          
          
               $(document).on("click", ".goToRating", function (e) {
                  e.preventDefault();
                  $('html, body').animate({
                    scrollTop: $(".rating-review-section").offset().top
                  }, 1000);
              }); 

              //////  Zoom

              var zoomConfig = {
                lensSize: 40,
                zoomWindowFadeIn: 500,
                zoomWindowFadeOut: 500,
                lensFadeIn: 500,
                lensFadeOut: 500,
                scrollZoom: true,
                // zoomWindowPosition: "demo-container",
                // zoomWindowHeight: 600, zoomWindowWidth:600,
              };
              
           var image = $('#thumbs a');
           var zoomImage = $('#zoom_01');
 
           zoomImage.elevateZoom(zoomConfig); //initialise zoom
 
           image.hover(function () {
                // Remove old instance od EZ
                $('.zoomContainer').remove();
                zoomImage.removeData('elevateZoom');
                // Update source for images
                zoomImage.attr('src', $(this).data('image'));
                zoomImage.data('zoom-image', $(this).data('zoom-image'));
                // Reinitialize EZ
                zoomImage.elevateZoom(zoomConfig);
           });
 
 
           $('#thumbs ul li a').hover(
                function () {
                     $(this).addClass('border-2 border-blue-600').parent().siblings().children().removeClass('border-2 border-blue-600');
                },
                function () { }
           );
 
 
           $('#thumbs ul li a').click(function (e) {
                e.preventDefault();
           });


          
      

});


//////  Verify Input On Focus ///////
const digitInputs = document.querySelectorAll('input[id^="digit"]');
digitInputs.forEach((input, index) => {
input.addEventListener('input', (e) => {
if (e.target.value.length === 1 && index < digitInputs.length - 1) {
    digitInputs[index + 1].focus();
}
});
});