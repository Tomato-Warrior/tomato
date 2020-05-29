  $(window).on('turbolinks:load', function(){
      
    $('a[data-toggle="tab"]').on('shown', function(e) {
      $('.dropdown-menu li a.dropdown-item.active').removeClass('active');
      $(this).parent('li').addClass('active');
    })

    $(".tag-select2").select2({
        tags: true,
        multiple: 'true',
        tokenSeparators: [',', ' ']
      })
    
      $(function () {
        $('#datetimepicker1').datetimepicker({
          icons: {
            time: "far fa-clock",
            date: "far fa-calendar-alt",
            up: "fa fa-arrow-up",
            down: "fa fa-arrow-down"
          },
          format: "YYYY/MM/DD HH:mm"
        });
      });

      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      });

  });

