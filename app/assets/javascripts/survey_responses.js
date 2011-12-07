$(document).ready(function() {
  $('.red').click(function(){
   val_id = $(this).attr('data');
   remove_on_class(val_id);
   $(this).addClass('on');
   change_hidden_value(val_id, 0);
    }),
  $('.yellow').click(function(){
   val_id = $(this).attr('data');
   remove_on_class(val_id);
   $(this).addClass('on');
   change_hidden_value(val_id, 1);
    }),
  $('.green').click(function(){
   val_id = $(this).attr('data');
   remove_on_class(val_id);
   $(this).addClass('on');
   change_hidden_value(val_id, 2);
    }),
  $('.comment').click(function(){
    val_id = $(this).attr('data');
    $('.hide_note[data='+val_id+']').show();
  }),
  $("input[name='commit']").click(function() {
    $(this).val("Saved");
  })
});  

function remove_on_class(val_id) { 
  $('.on[data='+val_id+']').removeClass('on');
}

function change_hidden_value(val_id,val_amt) {
  $('#'+val_id+'_response').val(val_amt);
  $.ajax({
      url: "survey_responses/"+val_id,
      dataType: "json",
      type: "POST",
      processData: false,
      contentType: "application/json",
      data: "{\"survey_response\":{\"response\":\""+val_amt+"\"}}",
      beforeSend: function(xhr)   
        {
         xhr.setRequestHeader("X-Http-Method-Override", "PUT");
         }
    });
}

