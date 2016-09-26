/* Used for loading Vocaloid song information. */
/*$(document).ready(function() {
    var filename = document.URL;
    filename = filename.substring(filename.lastIndexOf('/') + 1, filename.length - 5) + ".json";
    alert(filename);
});
*/
function loadSong(file) {
    var jqxhr = $.getJSON(file, function(data) {
        console.log( "success" );

        // Get basic data.
        $('.title').html(data.title);
        $('.romaji').html("Romaji: " + data.romaji);
        if(data.hasOwnProperty("subtitle")) {
            $('.subtitle').html("English title: " + data.subtitle);
        }
        $('.date').html("Release Date: " + data.date);

        // Get video info.
        $('.video').attr('src', data.url);
        if(data.hasOwnProperty("upload")) {
            $('.upload').html("Uploaded on: " + data.upload);
            $('.artists').html("Illustrated by: ").append('<ul class="drawn"></ul>');
            for(var i = 0; i < data.artists.length; ++i) {
                $('.drawn').append('<li>' + data.artists[i].drawn + '</li>');
            }
        } else {
            $('.upload').html("Fanmade video by " + data.artists);
        }

        // Get the album and series information
        if(data.hasOwnProperty("albums")) {
            $('.albums').after('<ul class="cd"></ul>');
            for(var i = 0; i < data.albums.length; ++i) {
                $('.cd').append('<li>' + data.albums[i].cd + '</li>');
            }
        } else {
            $('.albums').empty();
        }

        if(data.hasOwnProperty("series")) {
            $('.series').after('<ul class="story"></ul>');
            for(var i = 0; i < data.series.length; ++i) {
                $('.story').append('<li>' + data.series[i].story + '</li>');
            }
        } else {
            $('.series').empty();
        }

        // Get the cast information
        for(var i = 0; i < data.cast.length; ++i) {
            $('.cast').append('<p><span class="vocaloid' + data.cast[i].vocal.substr(data.cast[i].vocal.indexOf(' ')).toLowerCase() + '">' + data.cast[i].character + '</span> (' + data.cast[i].vocal + ')</p>');
        }
    }).done(function() {
        console.log( "second success" );
    }).fail(function(err) {
        console.log( "error" );
        console.log(err);
    }).always(function() {
        console.log( "complete" );
    });
}
