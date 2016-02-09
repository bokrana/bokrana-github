//--end of rocket ================================
$(document).ready(function(){
	

// Instantiate MixItUp:==========================
  $("#mixitup_result").mixItUp({
	  load: {
		sort: 'date-order:desc',
                filter: 'all'

	}, 	pagination: {
		limit: 20
	}
	  
//callbacks: {
 //       onMixEnd: function(state) {
//$('#passions_count > #total_show').html(state.totalShow);
//          $("#passions_count > #total_show_pluralize").text((state.totalShow == 1) ? "passion" : "passions");
  //          var $targetDiv = $('.mixitup_result');
            //$("#passions-container").css('height', $targetDiv.height())
 //       }
   // }
})




$.validate({form : '#login-form'});
//typeahead-suggesion==============================================

$('#search-bar').submit(function(e) {
if ($('#search_input').val().length == 0) {
e.preventDefault();          
return false;  
}
});
//---------------------------------------------------------------
$('#search_input').typeahead([

	{
limit: 5,
name: 'passion',
valueKey: 'name',
remote:  { url: '/autocomplete.json?q=%QUERY',
                 filter: function(data) { 
             var retval = [];
            for (var i = 0;  i < data.length;  i++) {
            if ( data[i].table == 'passion' ) { 
             retval.push({ 
                   name:  data[i].name,
                   id:  data[i].id,
                   passionates_num:  data[i].passionates_num,
                   passion_image_file_name: data[i].passion_image_file_name
                                });
                          }
                           }
               return retval;          
                                      },
                 dataType: 'json',
                 cache: true,
                 timeout: 5000
			 },
header: '<h3 class="tt-header">Passions</h3>' ,
template:  function(data){
      return '<img src="/system/passions/passion_images/000/000/00'+data.id+'/thumb/'+data.passion_image_file_name+'" ><div class = "tt-info"><p class = "tt-name">' + data.name + '</p><p class ="tt-num">' + data.passionates_num + ' Passions</p></div>';}
},
{
limit: 5,
name: 'passionate',
valueKey: 'name',
remote: { url: '/autocomplete.json?q=%QUERY',
                 filter: function(data) { 
             var retval = [];
            for (var i = 0;  i < data.length;  i++) {
            if ( data[i].table == 'passionate' ) { 
             retval.push({ 
                   name:  data[i].name ,
                   recommend_num: data[i].passionates_num, // recommend_num becouse the first data
                   id: data[i].id,
                  photo: data[i].photo
                                });
                          }
                           }
               return retval;          
                                      },
	             dataType: 'json',
                 cache: true,
                 timeout: 5000
			 },
header: '<h3 class="tt-header">Users</h3>' ,
template:  function(data){
      return '<img src="/system/passionates/profile_images/000/000/0'+data.id+'/thumb/'+data.photo+' "><div class = "tt-info"><p class = "tt-name">' + data.name + '</p><p class ="tt-num"> ' + data.recommend_num + ' recommends</p></div>';}
}
]).on('typeahead:initialized', function (obj, datum) {
    console.log(datum);
});
//================================================


var $modal = $('#mixitup_result');
$('.delete-passion').on("ajax:beforeSend", function(){
$modal.modal('loading');
 }).on("ajax:complete", function(){$modal.modal('loading');})


//=============================================




});
