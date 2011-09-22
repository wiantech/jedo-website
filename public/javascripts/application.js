
    // Switch between personel and organisational profile (on radio button)
function formshowhide(id)
{
   
    if (id == "personal")
          {
            $('#sub1').show();
            $('#sub2').hide();
            $('#radio1').attr('checked', true);
          }
    else
          {
            $('#sub2').show();
            $('#sub1').hide();
            $('#radio2').attr('checked', true);
          }

}


// Dynamicaly select dropdown list for country/state( for Personel Profile).
$(document).ready(function(){
        $("select#user_location_attributes_country_id").change(function(){
                var id_value_string = $(this).val();
                if (id_value_string == "")
                {
                    $("select#user_location_attributes_state_id option").remove();
                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                    $(row).appendTo("select#user_location_attributes_state_id");
                }
                else
                {
                    $.ajax({
                    dataType: "json",
                    cache: false,
                    url: '/get_state?id=' + id_value_string ,
                    timeout: 2000,
                    error: function(XMLHttpRequest, errorTextStatus, error)
                    {
                        alert("Failed to get state data : "+ errorTextStatus+" ;"+error);
                    },
                    success: function(data)
                    {
                        $("select#user_location_attributes_state_id option").remove();
                        var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                        $(row).appendTo("select#user_location_attributes_state_id");
                        $.each(data, function(i, j)
                        {
                            row = "<option value=\"" + j.state.id + "\">" + j.state.name + "</option>";
                            $(row).appendTo("select#user_location_attributes_state_id");
                        });
                     }
                });
            }

      });

 });


 

// Dynamicaly select dropdown list for category/subcategory(for Personel Profile).
$(document).ready(function(){
        $("select#interests1_category_name").change(function(){
                   var id_value_string = $(this).val();
                   if (id_value_string == "")
                   {
                        $("select#interests1_subcategory_name option").remove();
                        var row = "<option value=\"" + "" + "\">" + "-Subcategory-" + "</option>";
                        $(row).appendTo("select#interests1_subcategory_name");
                   }
                   else
                   {
                        $.ajax({
                        dataType: "json",
                        cache: false,
                        url: '/get_subcategory?id=' + id_value_string ,
                        timeout: 2000,
                        error: function(XMLHttpRequest, errorTextStatus, error)
                        {
                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                        },
                        success: function(data){
                        $("select#interests1_subcategory_name option").remove();
                        var row = "<option value=\"" + "" + "\">" + "-Subcategory-" + "</option>";
                        $(row).appendTo("select#interests1_subcategory_name");
                        $.each(data, function(i, j)
                        {
                            row = "<option value=\"" + j.event_category_master.id + "\">" + j.event_category_master.event_cat_name + "</option>";
                            $(row).appendTo("select#interests1_subcategory_name");
                        });
                     }
                });
            }

      });

 });



// Add data from I_like section into table & show data in table.(Person profile)
 function submitdata()
 {
     $(document).ready(function(){
                    var category_id = $('#interests1_category_name').val();
                    var subcategory_id = $('#interests1_subcategory_name').val();
                    var state_id= $('user_location_attributes_state_id').val()
                    if (category_id == "" || subcategory_id == "" )
                        {
                            if (category_id == "")
                                { alert('Please select the interest.'); }
                            else if(subcategory_id == "")
                                { alert('Please select the subcategory.'); }
                            
                        }
                   else
                        {
                            $.ajax({
                            dataType: "json",
                            cache: false,
                            url: '/save_interest?category_id=' + category_id + '&subcategory_id=' + subcategory_id  ,
                            timeout: 2000,                          
                            complete: function()
                                        {
                                           $('#ajax_loader').hide();
                                           $('#interest').show();
                                        },
                            error: function(XMLHttpRequest, errorTextStatus, error)
                            {
                                alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                            },
                            success: function(data){
                                $.each(data, function(i, j)
                                                    {
                                                        if ( j == "same pair." || j == "limit exceed.")
                                                            {
                                                                if(j == "limit exceed.")
                                                                     {
                                                                         alert("You can add only 15 interest categories. Please delete a few before adding more interests.");
                                                                     }
                                                                
                                                               else if(j == "same pair.")
                                                                    {
                                                                       alert("Already exists.Please select another.");
                                                                    }
                                                            }
                                                          
                                                         
                                                        else
                                                            {
                                                                $('#interest').load('edit #interest');
                                                               //location.reload();
                                                               
                                                            }
                                                            
                                                    });
                                                    }
                                });
                        }
            });
 }

//delete records from interest_table & i_like section when click on delete(for i_like section)
function delete_interest(interest_id)
{    
    $(document).ready(function(){
              var interest = interest_id;             
            $.ajax({
                    dataType: "json",
                    cache: false,
                    url: '/delete_interest?interest_id=' + interest ,
                    timeout: 2000,
                     error: function(XMLHttpRequest, errorTextStatus, error)
                    {
                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                    },
                    success: function(data)
                    {
                               location.reload();
                               $('#ajax_loader').hide();

                    }
            });
     });
}


 // Dynamicaly select dropdown list for country/state( for Organisation Profile).
$(document).ready(function(){
        $("select#organisation_country_id").change(function(){
                var id_value_string = $(this).val();
                if (id_value_string == "")
                {
                    $("select#organisation_state_id option").remove();
                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                    $(row).appendTo("select#organisation_state_id");
                }
                else
                {
                    $.ajax({
                            dataType: "json",
                            cache: false,
                            url: '/get_state?id=' + id_value_string ,
                            timeout: 2000,
                            error: function(XMLHttpRequest, errorTextStatus, error){
                            alert("Failed to state data : "+ errorTextStatus+" ;"+error);
                            },
                            success: function(data){
                                    $("select#organisation_state_id option").remove();
                                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                                    $(row).appendTo("select#organisation_state_id");
                                    $.each(data, function(i, j)
                                    {
                                    row = "<option value=\"" + j.state.id + "\">" + j.state.name + "</option>";
                                    $(row).appendTo("select#organisation_state_id");
                                    });
                                    }
                            });
                }

      });

 });


  // Dynamicaly select dropdown list for country/state my_location(for Organisation Profile).
$(document).ready(function(){
        $("select#locations1_country_id").change(function(){
                var id_value_string = $(this).val();
                if (id_value_string == "")
                {
                    $("select#locations1_state_id option").remove();
                    var row = "<option value=\"" + "" + "\">" + "-123-" + "</option>";
                    $(row).appendTo("select#locations1_state_id");
                }
                else
                {
                    $.ajax({
                            dataType: "json",
                            cache: false,
                            url: '/get_state?id=' + id_value_string ,
                            timeout: 2000,
                            error: function(XMLHttpRequest, errorTextStatus, error)
                            {
                                alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                            },
                            success: function(data){
                                    $("select#locations1_state_id option").remove();
                                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                                    $(row).appendTo("select#locations1_state_id");
                                    $.each(data, function(i, j){
                                    row = "<option value=\"" + j.state.id + "\">" + j.state.name + "</option>";
                                    $(row).appendTo("select#locations1_state_id");
                                    });
                            }
                        });
                }

      });

 });

// State of Send Friend request fucntion
function send_friend_req(fid)
{

 $.ajax({
        dataType: "json",
        cache: false,
        url: '/friends/send_requests?id=' + fid ,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: function(data){
            if(data)
            {
//            //Remove onclick fucntion
//             $('a#send_friend_req_'+data).removeAttr('onclick').click(function(){
//             send_friend_req(data);
//             });
            // remove send friend request button.
            $('p#send_friend_req_'+data).html('<a class="post_comment" href="#" title="pending friend request"><span class="o_color">Pending</span> <span class="o_colorPending">invites</span></a>');
            }else
            { 
            // do here if error comes

            }
         
         
         }
    });

}

// End of Send Friend request fucntion

function accept_friend_request(friendship_to , friendship_from)
{
        $.ajax({
        dataType: "json",
        cache: false,
        url: '/friends/accept_friendship?friendship_to=' + friendship_to +'&friendship_from='+friendship_from ,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: function(data){
            if(data)
            {
             //Remove onclick fucntion
             $('#mypendingfrieend_'+data).html("");
             $('#mypendingfrieend_'+data).hide();
             location.reload();
            }else
            { 
              // do here if error comes


            }


         }
    });
    
}

//Reject friend request
function deny_friend_request(to , from)
{
$.ajax({
        dataType: "json",
        cache: false,
        url: '/friends/reject_friendship?friendship_to=' + to +'&friendship_from='+from ,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: function(data){
            if(data)
            {
             $('#mypendingfrieend_'+data).html("");
             $('#mypendingfrieend_'+data).hide();
             location.reload();
            }else
            {
            // do here if error comes
            }

         }
    });

}

// END Reject friend request
//  function used to accept and reject friend from request widget

function accept_friend_request_from_layout(friendship_to , friendship_from)
{
        $.ajax({
        dataType: "json",
        cache: false,
        url: '/dashboards/accept_friendship?friendship_to=' + friendship_to +'&friendship_from='+friendship_from ,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: function(data){
            if(data)
            {
             //Remove onclick fucntion
            $('#accept_reject_id_'+data).html("");
            $('#accept_reject_id_'+data).remove();
             location.reload();

             }else
            {
              // do here if error comes


            }


         }
    });

}

//Reject friend request
function deny_friend_request_from_layout(to , from)
{
$.ajax({
        dataType: "json",
        cache: false,
        url: '/dashboards/reject_friendship?friendship_to=' + to +'&friendship_from='+from ,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error){
            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
        },
        success: function(data){
            if(data)
            {
                
             $('#accept_reject_id_'+data).html("");
             $('#accept_reject_id_'+data).remove();
             location.reload();
            }else
            {
            // do here if error comes
            }

         }
    });

}

//  function used to accept and reject friend from request widget

$(document).ready(function(){
        $("select#interests_category_id").change(function(){
            var id_value_string = $(this).val();
            if (id_value_string == "") {
                // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
                $("select#interests_subcategory_id option").remove();
                var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                $(row).appendTo("select#interests_category_id");
            }
            else {
                // Send the request and update sub category dropdown
                $.ajax({
                    dataType: "json",
                    cache: false,
                    url: '/users/getsubcategory?id=' + id_value_string ,
                    timeout: 2000,
                    error: function(XMLHttpRequest, errorTextStatus, error){
                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                    },
                    success: function(data){
                        // Clear all options from sub category select
                        $("select#interests_subcategory_id option").remove();
                        //put in a empty default line
                        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                        $(row).appendTo("select#interests_subcategory_id");
                        // Fill sub category select
                        $.each(data, function(i, j){
                            row = "<option value=\"" + i + "\">" + j.event_category_master.event_cat_name + "</option>";
                            $(row).appendTo("select#interests_subcategory_id");
                        });
                     }
                });
            }
                });
    });



// Dynamicaly select dropdown list for category/subcategory(for Create Event).
$(document).ready(function(){
        $("select#event_category_category_id").change(function(){
                   var id_value_string = $(this).val();
                   if (id_value_string == "")
                   {
                        $("select#event_category_subcategory_id").remove();
                        var row = "<option value=\"" + "" + "\">" + "-Select Subcategory-" + "</option>";
                        $(row).appendTo("select#event_category_subcategory_id");
                   }
                   else
                   {
                        $.ajax({
                        dataType: "json",
                        cache: false,
                        url: '/events/getsubcategory?id=' + id_value_string ,
                        timeout: 2000,
                        error: function(XMLHttpRequest, errorTextStatus, error)
                        {
                        alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                        },
                        success: function(data){

                        $("select#event_category_subcategory_id option").remove();
                        var row = "<option value=\"" + "" + "\">" + "-Select Subcategory-" + "</option>";
                        $(row).appendTo("select#event_category_subcategory_id");
                        $.each(data, function(i, j)
                        {
                         row = "<option value=\"" + j.event_category_master.id + "\">" + j.event_category_master.event_cat_name + "</option>";
                         $(row).appendTo("select#event_category_subcategory_id");
                        });
                     }
                });
            }

      });

 });

//END of Dynamic dropdown of subcategory

// Dynamic dropdown for country/state (for create Event)
$(document).ready(function(){
        $("select#event_location_country_id").change(function(){
                var id_value_string = $(this).val();
                if (id_value_string == "")
                {
                    $("select#event_location_state_id option").remove();
                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                    $(row).appendTo("select#event_location_state_id");
                }
                else
                {
                    $.ajax({
                            dataType: "json",
                            cache: false,
                            url: '/events/getstate?id=' + id_value_string ,
                            timeout: 2000,
                            error: function(XMLHttpRequest, errorTextStatus, error){
                            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                            },
                            success: function(data){
                                    $("select#event_location_state_id option").remove();
                                    var row = "<option value=\"" + "" + "\">" + "-Select State-" + "</option>";
                                    $(row).appendTo("select#event_location_state_id");
                                    $.each(data, function(i, j)
                                    {
                                    row = "<option value=\"" + j.state.id + "\">" + j.state.name + "</option>";
                                    $(row).appendTo("select#event_location_state_id");
                                    });
                                    }
                            });
                }

      });

 });
//END Dynamic dropdown for country/state


// text box show/hide for create_event
 $(function() {
                
            $('select#cost_type').change(function() {
                if (this.value == "Paid") {
                    $('b#doller').show();
                    $('#div_cost').show();
                }
                else
                  {
                    $('#div_cost').hide();
                    $('b#doller').hide();
                  }

            });

        });        
//END

// drag & drop functionality for interest section
$(document).ready(function(){
    $('#task_list').sortable(
        {
          axis: 'y',
          cursor: 'move',
          update: function(){            
            $.ajax({
                            type: 'get',
                            dataType: 'json',
                            data: $('#task_list').sortable('serialize') + '&id=5',
                            cache: false,
                            url: '/users/drag_drop_interest',
                            timeout: 2000,
                            error: function(XMLHttpRequest, errorTextStatus, error){
                            alert("Failed to submit : "+ errorTextStatus+" ;"+error);
                            },
                            success: function(data){
                                    $.each(data, function(i, j)
                                    {
                                         location.reload();
                                    });
                                    }
                            });
            }
        });

});
