(function($) {
  $(document).ready(function(){
    var albumList = $( ".albums-list" );
    albumList.sortable({
      items: "> li.sortable",
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
              console.log("Thanks!");
            }
        });
      }
    });
  });
})(jQuery);
