(function($) {
  $(document).ready(function(){
    var albumList = $( ".albums-list" );
    albumList.sortable({
      items: "> li.sortable",
      axis: "y",
      cursor: "move",
      update: function( event, ui ) {
        var order = {};
        albumList.find('>li').each(function(index){
          order[$(this).data('albumId') + ''] = index + 1;
        });
        $.ajax({
            type: "POST",
            url: relativeRoot + '/albums/reorder',
            dataType: 'json',
            //json object to sent to the authentication url
            data: {order: order},
            success: function () {
              console.log("success");
            }
        });
      }
    });

    albumList.find('.photo-list').each(function(){
      var photoList = $(this);
      photoList.sortable({
        items: "> li.sortable",
        axis: "x",
        containment: "parent",
        cursor: "move",
        update: function( event, ui ) {
          var order = {};
          photoList.find('>li').each(function(index){
            order[$(this).data('photoId') + ''] = index + 1;
          });
          $.ajax({
              type: "POST",
              url: relativeRoot + '/photos/reorder',
              dataType: 'json',
              //json object to sent to the authentication url
              data: {order: order},
              success: function () {
                console.log("success");
              }
          });
        }
      });
    });
  });
})(jQuery);
