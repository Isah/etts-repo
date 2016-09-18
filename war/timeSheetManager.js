$(document).ready(function(){
   //the overlay 
  $('.shell_three tbody tr').click(function(){
    $(".time_off_info").show();
    $(".mailForm").hide();
    $('.overlay').fadeIn();
  });
  $('.close-image, #cancel_ts').click(function(){
    $('.overlay').fadeOut();
  });

  //email sh**t
  $('#mailButton').click(function(){
    $(".mailForm").show();
    $(".time_off_info").hide();
    $('.overlay').fadeIn();
  });
  $('.close-image').click(function(){
    $('.overlay').fadeOut();
  });
  
     //sending mail
  $("#sendEmail").click(function(){
    var toEmail = $("#toEmail").val();
    var subject = $("#subject").val();
    var message = $("#message").val();

    if(checkToEmail() && checkMessage() && checkSubject()){
      $.ajax({
          url:'/UserEventHandler',
          type:'POST',
          data:{tester:"sendEmail", toEmail:toEmail, subject:subject, message:message},
        dataType:'text'
      }).done(function(data){
       $("#emailResultMessage").text("Message sent"); 
       $(".overlay").fadeOut();
       alert(data); 
      }).fail(function(){alert("mail not sent")});
    }
  });

  function checkToEmail(){
    var toEmail = $("#toEmail").val();
    if(toEmail != ""){
      return true;
    }else{
      $("#emailResultMessage").text("Enter E-mail");
      return false;
    }
  }

  function checkSubject(){
    var subject = $("#subject").val();
    if(subject != ""){

      return true;
    }else{
      $("#emailResultMessage").text("Enter subject");
      return false;
    }
  }

  function checkMessage(){
    var message = $("#message").val();
    if(message != ""){

      return true;
    }else{
      $("#emailResultMessage").text("Enter message");
      return false;
    }
  }


//timesheet lines	

//submit timesheet
$(".ts_button").click(function(){
    var ts_id = $("#ts_id").text();
    $.ajax({
        url:'/UserEventHandler',
        type:'POST',
        data:{tester:"submitTimeSheet", ts_id:ts_id},
        dataType:'text'
      }).done(function(data){
       $(".name_title").slideDown();
       $(".manage_table").slideUp();
       alert(data); 
      }).fail(function(){alert("timesheet not submited")});
  });

//approving timesheets
  $("#approve_ts").click(function(){
    var approveTimeSheetId = $("#approveTimeSheetId").text();
    $.ajax({
          url:'/UserEventHandler',
          type:'POST',
          data:{tester:"approveTimeSheet", approveTimeSheetId:approveTimeSheetId},
          dataType:'text'
      }).done(function(data){
       $(".overlay").hide();
       $(".time_off_info").hide();
       alert(data); 
      }).fail(function(){alert("timesheet not approved")});
  });

  $("#reject_ts").click(function(){
    var approveTimeSheetId = $("#approveTimeSheetId").text();
    $.ajax({
          url:'/UserEventHandler',
          type:'POST',
          data:{tester:"rejectTimeSheet", approveTimeSheetId:approveTimeSheetId},
        dataType:'text'
      }).done(function(data){
       $(".overlay").hide();
       $(".time_off_info").hide();
       alert(data); 
      }).fail(function(){alert("timesheet not rejected")});
  });

	//creating new timeSheet
	$("#createTimeSheet").click(function(){
	  $.ajax({
      		url:'/UserEventHandler',
      		type:'POST',
      		data:{tester:"createTimeSheet"},
     		dataType:'text'
      }).done(function(data){
      	 $(".manage_table").slideDown();
    	 $(".name_title").hide();
    	 alert(data);	
      }).fail(function(){alert("timesheet not created")});
	});


	//validating day plan fileds
  function checkTimeWorked(){
        var timeWorked = $("#timeWorked").val();

         if(timeWorked > 12 || timeWorked < 1){
            $("#timeWorked").addClass("errorFields");
            $("#timeWorkedSpan").text("Must be between 1-12 hours");
            return false;
        }else{
            $("#timeWorked").removeClass("errorFields");
            $("#timeWorkedSpan").text("");
            return true;
        }
  }

	function checkSection(){
        var section1 = $("#section").val().length;
        var searchReg = /^[a-zA-Z0-9-]+$/;

        if(section1 == ""){
            $("#section").addClass("errorFields");
            $("#sectionSpan").text("Enter text");
            return false;
        }else if(!searchReg.test(section1)){
        	  $("#sectionSpan").text("Enter valid text");
            $("#section").addClass("errorFields");
            return false;
        }else if(section1 < 2){
            $("#section").addClass("errorFields");
            $("#sectionSpan").text("Atleast 4 characters");
            return false;
        }else{
            $("#section").removeClass("errorFields");
            $("#sectionSpan").text("");
            return true;
        }
    }

    function checkClientName(){
        var clientName1 = $("#clientName").val().length;
        var searchReg = /^[a-zA-Z0-9-]+$/;

        if(clientName1 == ""){
            $("#clientName").addClass("errorFields");
            $("#clientNameSpan").text("Enter text");
            return false;
        }else if(!searchReg.test(clientName1)){
            $("#clientNameSpan").text("Enter valid text");
            $("#clientName").addClass("errorFields");
            return false;
        }else if(clientName1 < 4){
            $("#clientName").addClass("errorFields");
            $("#clientNameSpan").text("Atleast 4 characters");
            return false;
        }else{
            $("#clientName").removeClass("errorFields");
            $("#clientNameSpan").text("");
            return true;
        }
    }
	//add day plan to a time sheet
	$("#add_ts").click(function(){
		var clientName = $("#clientName").val();
		var clientDate = $("#clientDate").val();
		var timeWorked = $("#timeWorked").val();
		var serviceCode = $("#serviceCode").val();
		var billingState= $("#billingState").val();
		var section = $("#section").val();

		if(checkClientName() && checkSection() && checkTimeWorked()){
		$.ajax({
      		url:'/UserEventHandler',
      		type:'POST',
      		data:{tester:"addTimeSheet", clientName:clientName, clientDate:clientDate, timeWorked:timeWorked, serviceCode:serviceCode, billingState:billingState, section:section},
     		dataType:'text'
      	}).done(function(data){
    	 	alert(data);	
      	}).fail(function(){alert("day plan not added")});
      }
	});

	//delete timesheet
	$("#delete_ts").click(function(){
		var tr = $(this).closest("tr");
		var id = tr.find("#ts_id").text();

		$.ajax({
      		url:'/UserEventHandler',
      		type:'POST',
      		data:{tester:"deleteTimeSheet", timeSheetId:id},
     		dataType:'text'
      	}).done(function(data){
    	 	alert(data);	
      	}).fail(function(){alert("timesheet not deleted")});
	});

  //report search
 // $("#searchByEmployee").change(function(){
 //     var employee =  
 // });
	
});