<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.application.timeplans.TimeSheet" %>
<%@ page import="com.data.dataFacade.*" %>
<%@ page import="com.application.timeplans.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<link href="managesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="new.js"></script>
<script src="jquery-ajax.js"></script>
<script src="timeSheetManager.js"></script>
<script type="text/javascript" src="jquery-2.1.4.min.js"></script>
<script>
$(document).ready(function(){
  $(".cts").addClass("newactive");

  //timesheet form
  $(".client_btn2").click(function(){
  });

  $("#myform_ts").submit(function(){
    return false;
  });

 // $(".ts_button").click(function(){

   // $(".name_title").slideDown();
    //$(".manage_table").slideUp();
    //$(".name_title").hide();

  //});


 
  $('.cts').click(function(){
    $(".cts").addClass("newactive");
    $('.shell_one').show();
    $('.shell_two').hide();
    $('.shell_three').hide();
    $('.shell_four').hide();

    $(".pts").removeClass("newactive");
    $(".ats").removeClass("newactive");
    $(".report").removeClass("newactive");
  });

  $('.ats').click(function(){
    $(".ats").addClass("newactive");
    $(".cts").removeClass("newactive");
    $(".pts").removeClass("newactive");
    $(".report").removeClass("newactive");

    $('.shell_one').hide();
    $('.shell_three').hide();
    $('.shell_four').hide();
    $('.shell_two').show();
  });

  $('.pts').click(function(){
    $('.pts').addClass("newactive");
    $(".cts").removeClass("newactive");
    $(".ats").removeClass("newactive");
    $(".report").removeClass("newactive");

    $('.shell_one').hide();
    $('.shell_two').hide();
    $('.shell_four').hide();
    $('.shell_three').show();
  });

  $('.report').click(function(){
    $('.report').addClass("newactive");
    $(".cts").removeClass("newactive");
    $(".ats").removeClass("newactive");
    $(".pts").removeClass("newactive");

    $('.shell_one').hide();
    $('.shell_two').hide();
    $('.shell_three').hide();
    $('.shell_four').show();
  });

  });
</script>

</head>
<body>
<!--overlay-->
  <div class="overlay">

    <!--send email-->
    <div class="mailForm">
      <div class="small_header">Send report via E-mail<img src="images/cancel30 (1).png" class="close-image"></div>
      <div class="emailGroup">
        <label>To:</label><br><input type="search" name="toEmail" id="toEmail">
      </div>
      <div class="emailGroup">
        <label>Subject:</label><br><input type="search" name="subject" id="subject">
      </div>
      <div class="emailGroup">
        <label>Message:</label><br>
        <textarea id="message"></textarea>
      </div>
      <div class="emailGroup">
        <button id="sendEmail">Send</button><span id="emailResultMessage"></span>
      </div>
    </div>
    <div class="time_off_info">
      <div class="small_header">Approve TimeSheet<img src="images/cancel30 (1).png" class="close-image"></div>
      <div class="leave_info_group">

        <h4>General Information</h4>

        <div class="inner_info">
        
        <%   
             
             TimeSheetDataFacade tSheet = new TimeSheetDataFacade();
             ServletContext context = getServletContext();
		         String username = (String)context.getAttribute("user");
		         String password = (String)context.getAttribute("pass");
		
             TimeSheet timesheet = tSheet.getTimeSheet("17"); 
             
             String employee_name = tSheet.getEmployee(Integer.toString(timesheet.getEmployee_id())).getFirstname();
             String datecreated = timesheet.getDateofcreation();
             
             //String name = tSheet.getEmployee(Integer.toString(employeeid)).getFirstname();
             
             //tSheet.getPendingTSheets("", "", "", employeeid);
             
        
        %>
              
          <label class="req_info"><%= employee_name %></label>
          <label class="req_name">Employee Name</label>
        </div>
        <div class="inner_info">
          <label class="req_info" id="approveTimeSheetId">17</label>
          <label class="req_name">TimeSheet id</label>
        </div>
        <div class="inner_info">
          <label class="req_info"><%= datecreated %></label>
          <label class="req_name">Submitted on</label>
        </div>

      </div>

      <div class="leave_info_group">

        <h4>TimeSheet Information</h4>

        <table>
          <thead>
            <tr>
                 <th>Day</th>
                 <th>Client</th>
                 <th>Service Code</th>
                 <th>Section</th>
                 <th>Billing State</th>
                 <th>Time Worked</th>
                
            </tr>
          </thead>
          <tbody>
          <%    for(int i=0; i<timesheet.getDayplans().size(); i++){ %>
          
          <tr>
                <td><%= timesheet.getDayplans().get(i).getDay() %></td>
                <td><%= timesheet.getDayplans().get(i).getClient() %> </td>
                <td> <%= timesheet.getDayplans().get(i).getServicecode() %> </td>
                <td><%= timesheet.getDayplans().get(i).getSection() %> </td>
                <td><%= timesheet.getDayplans().get(i).getBillingstate() %> </td>
                <td><%= timesheet.getDayplans().get(i).getTimeworked() %> </td>
               
          </tr>
          
          <% }%>
          
          </tbody>
      </table>
      

      </div>

      <div class="leave_info_group">

        <h4>Status Information</h4>

        <div class="inner_info">
          <label class="req_info">Pending</label>
          <label class="req_name">Time Off Status</label>
        </div>
         
      </div>

      <div class="leave_info_group">
        <h4>change status</h4>
        <p>Please select which action you would like to take</p>

        <div class="inner_info">
          <button class="ggg" id="approve_ts">Approve TimeSheet</button> <button id="reject_ts">Reject TimeSheet</button> <button id="cancel_ts">Cancel</button>
        </div> 
      </div>

    </div>
  </div>
  <!--start of the main staff-->

<div class="wrapper">
<div class="header"> Employee Time Tracking System </div>
<div class="maincontent">
<div class="ts_manager">
    <div class="top">Manage Timesheets</div>
<div class="shell">
	<div class="list_one">
	<ul class="list_ones">
		<li class="cts"><img src="images/sheet3.png" class="list_icon">New TimeSheet</li>
		<li class="ats"><img src="images/checked-files.png" class="list_icon">Approved TS</li>
		<li class="pts"><img src="images/erase-file.png" class="list_icon">Pending TS</li>
    <li class="report"><img src="images/seo-report.png" class="list_icon">Report</li>
	</ul>
	</div>
	
	<div class="shell_one">

		<div class="div_manage_table1">

      <div class="name_title">  
      <label>Enter client information and add to your TimeSheet</label>
      
        <input type="hidden" value="createTimeSheet" id="ts_value" name="ts_value">
        <button type="" class="client_btn2" id="createTimeSheet">New TimeSheet</button>
  
    </div>
      
     <!-- <form action="CreateTimeSheet" method="post">
        <div class="form_group">
          <label>Client Name</label><br>
          <input type="search" name="client_name">
        </div>
        <div class="form_group">
          <label>Date</label><br>
            <input type="date" name="client_date">
        </div>
        <div class="form_group">
          <label>Section Code</label><br>
          <div class="myselect">
          <select name="serviceCode" class="service_code">
            <option value="Audit">AUD</option>
            <option value="Tax Consultancy">TAX</option>
            <option value="Accountancy">ACC</option>
            <option value="Administration">ADMIN</option>
            <option value="Management Consultancy">CON</option>
            <option value="No Work">IDLE</option>
            <option value="training Including Self">TRA</option>
          </select>
        </div>
        </div>
        <div class="form_group">
          <label>Billing State</label><br>
          <div class="myselect">
          <select name="billable">
            <option>billable</option>
            <option>Non-bllable</option>
          </select>
        </div>
        </div>
        <div class="form_group">
          <label>Time Worked</label><br>
          <input type="number" name="time_worked">
        </div>
        <div class="form_group">
          <label>Section</label><br>
          <input type="search" name="section">
        </div><br>
<button class="client_btn1" type="submit"><img src="images/close-circular-button.png" class="list_icon1">Delete Client</button>
<button class="client_btn"><img src="images/rounded-add-button.png" class="list_icon1">Add Client</button> 
      </form>  -->

      <div class="manage_table">
        
      <table >
          <thead>
            <tr>
                 <th width="3%"></th>
                 <th width="23%">Client</th>
                 <th width="12%">Date</th>
                 <th width="12%">Time Worked</th>
                 <th width="11%">Service Code</th>
                 <th width="11%">Billing State</th>
                 <th colspan="2">Section</th>
            </tr>
          </thead>
          <tbody>
          
          <tr>
            <td><img src="images/pencil_32.png" class="list_icon"></td>
            <td><input type="search" name="client_name"  placeholder="Name" id="clientName"></td>

            <td><input type="date" name="client_date" id="clientDate"></td>

            <td><input type="number" name="time_worked" min="0" max="12" id="timeWorked"></td>

            <td>
              <div class="myselect">
                <select name="serviceCode" class="service_code" id="serviceCode">
                  <option value="Audit">AUD</option>
                  <option value="Tax Consultancy">TAX</option>
                  <option value="Accountancy">ACC</option>
                  <option value="Administration">ADMIN</option>
                  <option value="Management Consultancy">CON</option>
                  <option value="No Work">IDLE</option>
                  <option value="training Including Self">TRA</option>
                </select>
              </div>
            </td>

            <td>
              <div class="myselect">
                <select name="billable" id="billingState">
                <option>billable</option>
                <option>Non-bllable</option>
              </select>
        </div>
            </td>
            <td width="26%"><input type="search" name="section" placeholder="section" id="section"></td>
            <td class="table_icon1" id="add_ts"></td>
          </tr>
          
          <tr class="errors">
            <td></td>
            <td><span id="clientNameSpan"></span></td>
            <td><span id="clienDateSpan"></span></td>
            <td><span id="timeWorkedSpan"></span></td>
            <td><span id=""></span></td>
            <td><span id="billingStateSpan"></span></td>
            <td><span id="sectionSpan"></span></td>
            <td></td>
          </tr>
          <!--
          <tr>
            <td>rfhfh</td>
            <td>rfhfh</td>
            <td>fg</td>
            <td>fgh</td>
            <td>fh</td>
            <td>fth</td>
            <td>thj</td>
            <td class="table_icon"></td> -->
          </tr>
          
          </tbody>  
    </table>
    <div class="number2">
    <table>
          <thead>
            <tr>
                 <th width="39">Id</th>
                 <th width="136">Client</th>
                 <th width="57">Date</th>
                 <th width="57">TimeWorked</th>
                 <th width="127">Service Code</th>
                 <th width="104">Billing State</th>
                 <th colspan="2">Section</th>
            </tr>
          </thead>
          <tbody>
          <tr>
            <td id="ts_id">rf</td>
            <td>rf</td>
            <td>fg</td>
            <td>rf</td>
            <td>rf</td>
            <td>rf</td>
            <td width="103">thj</td>
            <td width="40" class="table_icon" id="delete_ts"></td>
          </tr>      
          </tbody>  
    </table>
  </div>
   <input type="submit" value="Submit TimeSheet" class="ts_button">
   </div>
</div>
	</div>
	<div class="shell_two">
          <div class="sbox">
      <div class="search">
          <input type="search" placeholder="Approved Time Sheets"><input type="submit" value=""> 
      </div>
       sort By: 
          <select class="sort" id="sort_two">
            <option value="date">Date</option>
            <option value="ascending">Ascending</option>
            <option value="descending">Descending</option>
          </select>
      </div>
      <table class="pend_appr">
          <thead>
            <tr>
                 <th>ID</th>
                 <th>Employee</th>
                 <th>Time Sheet</th>
                 <th>Issue Date</th>
                 <th>Approved By</th>
                 <th>Approval Date</th>
            </tr>
          </thead>
          <tbody>
          <tr>
         <% 
          TimeSheetDataFacade facade = new TimeSheetDataFacade();
          
          List<TimeSheet> sheets  = facade.getApprovedTSheets("01-01-2016","01-12-2016","fill","5");
          
          
          
          
          for(int i=0; i<sheets.size(); i++){ 
          %>
                <td></td>
                <td><%= facade.getEmployee(Integer.toString(sheets.get(i).getEmployee_id()) ).getFirstname() %></td>
                <td><%=sheets.get(i).getTimesheet_id() %></td>
                <td><%= sheets.get(i).getDateofcreation() %></td>
                <td><%= facade.getEmployee(Integer.toString(facade.get_EID_From_PIN_MGT(sheets.get(i).getApproval().getPerson_in_mgt_id()))).getFirstname() %></td>
                <td><%=sheets.get(i).getApproval().getDate() %></td>
                <%} %>
          </tr>
          
          </tbody>
      </table>
  </div>
	<div class="shell_three">
          <div class="sbox">
      <div class="search">
          <input type="search" placeholder="Pending Time Sheets"><input type="submit" value=""> 
      </div>
       sort By: 
          <select class="sort" id="sort_three">
            <option value="date">Date</option>
            <option value="ascending">Ascending</option>
            <option value="descending">Descending</option>
          </select>
      </div>
      <table class="pend_appr">
          <thead>
            <tr>
                 <th>ID</th>
                 <th>Employee</th>
                 <th>Time Sheet</th>
                 <th>Issue Date</th>
            </tr>
          </thead>
          <tbody>
          <% 
         
          
     List<TimeSheet> psheets  = facade.getPendingTSheets("d1", "d2", "filter","5");
           
          for(int i=0; i<psheets.size(); i++){ 
          %>
                <td></td>
                <td><%= facade.getEmployee(Integer.toString(psheets.get(i).getEmployee_id()) ).getFirstname() %></td>
                <td><%=psheets.get(i).getTimesheet_id() %></td>
                <td><%= psheets.get(i).getDateofcreation() %></td>
             
                <%} %>  
          </tbody>
      </table>
  </div>
  <div class="shell_four">
     <div class="sbox">
      Search Employee: 
          <select class="search_by" id="searchByEmployee">
            <option value="date">Client</option>
            <option value="ascending">Code</option>
            <option value="date">Day</option>
            <option value="date">Employee</option>
            <option value="date">All</option>
          </select>

        From:<input type="date" id="reportFromDate"> To:<input type="date" id="reportToDate"> 
        Sort By:  
          <select class="search_by" id="searchByItem">
            <option value="client">Client</option>
            <option value="billingState">Billing State</option>
          </select>
         
          <label id="optionLabel">gkg</label>  
          <select class="search_by" id="optionSelector">
            <option value="client">Client</option>
            <option value="billingState">Billing State</option>
          </select>
        
          <button id="mailButton">Send Email</button>
         <!-- <div class="search">
            <input type="search" placeholder="Search"><input type="submit" value="" class="report_field"> 
          </div>
       Item: 
       <select class="search_by">
            <option value="date"><%= psheets.get(0).getDayplans().get(0).getServicecode() %></option>
            <option value="ascending"><%= psheets.get(0).getDayplans().get(0).getServicecode() %></option>
            <option value="date"><%= psheets.get(0).getDayplans().get(0).getServicecode() %></option>
            <option value="date">All</option>
       </select>   -->
       
       
      </div> 
     
       <table class="pend_appr">
          <thead>
            <tr>
                 <th>Client</th>
                 <th>Charge Code</th>
                 <th>Mon</th>
                 <th>Tue</th>
                 <th>Wed</th>
                 <th>Thur</th>
                 <th>Fri</th>
                 <th>Sat</th>
                 <th>Sun</th>
                 <th>Section</th>
                 <th>Employee</th>
            </tr>
          </thead>
          <tbody>
           <% 
           
            List<TimeSheet> reportsheets  = facade.searchTimeSheet("", "","All-All", 1);
                
          for(int i=0; i<reportsheets.size(); i++){ 
        	  
        	 
        	  
        	  List<DayPlan> plans = reportsheets.get(i).getDayplans();
        	  
        	  for(int j=0; j<plans.size(); j++){
        	  
          %>
           <tr>
                <td><%= plans.get(j).getClient() %></td>
                <td><%= plans.get(j).getServicecode()  %></td>
                
                <td><% 
                int timeMon = 0; 
                if(plans.get(j).getDay().equals("monday")){
                	
                	timeMon = plans.get(j).getTimeworked();
                	
                } %>
                <%= timeMon+"  hrs" %>
                
                </td>
                <td><% int timeTue=0; if(plans.get(j).getDay().equals("tuesday")){
                	
                	timeTue = plans.get(j).getTimeworked();
                	
                }  %>
                <%= timeTue+" hrs"  %></td>
                <td><% int timeWed=0; if(plans.get(j).getDay().equals("wednesday")){
                	
                	timeWed =plans.get(j).getTimeworked();
                	
                }  %>
                <%= timeWed+" hrs"  %></td>
                
                <td><% int timeThur =0;if(plans.get(j).getDay().equals("thursday")){
                	
                	timeThur = plans.get(j).getTimeworked();
                	
                }  %>
                <%= timeThur+" hrs"  %></td>
                <td><% int timeFri = 0; if(plans.get(j).getDay().equals("friday")){
                	
                	timeFri = plans.get(j).getTimeworked();
                	
                }  %>
                <%= timeFri+" hrs"  %></td>
                <td></td>
                <td></td>
                <td><%= plans.get(j).getSection() %></td>

                
                
                <td><%=  facade.getEmployee(Integer.toString( reportsheets.get(i).getEmployee_id())).getFirstname() %></td>
               
               </tr>
               <%} %> 
                <%} %> 
          
          </tbody>
      </table>
      </div>
  </div>
</div>
<div class="message1"></div>
</div>

<div class="sidebar">
  <div class="profile">
      <div class="profileDetails">
          <% 
          TimeSheetDataFacade fac = new TimeSheetDataFacade(); 
          int employee_id = facade.getEID(username, password);
          
          String employeename = fac.getEmployee(Integer.toString(employee_id)).getFirstname();
          String employeeposition = fac.getEmployee(Integer.toString(employee_id)).getPosition_in_co();
          %>
      
          <label><%=  employeename%></label><br>
          <label><%=  employeeposition%></label>
          
      </div>
        <div class="profilePic"><img src="images/office worker1.png" class="p_pic"></div>
      </div>
  <ul class="menu">
      <li class="userAccounts"><a href="#"><img src="images/documents7.png" class="list_icon3">TimeSheets</a>
        <ul>
          <li>New TimeSheet</li>
          <li>Aproved TimeSheets</li>
          <li>Pending TimeSheets</li>
        </ul>
      </li>
      <li class="leave"><a href="#"><img src="images/documents7.png" class="list_icon3">Reports</a></li>
      <li class="leave"><a href="#"><img src="images/stick.png" class="list_icon3">Leave Applications</a></li>
      <li class="yearPlanner"><a href="#"><img src="images/accounts.png" class="list_icon3">Accounts</a>
        <ul>
          <li>My Account</li>
          <li>Employee Accounts</li>
        </ul>
      </li>
      <li class="userAccounts"><a href="#"><img src="images/settings.png" class="list_icon3">Settings</a>
        <ul>
          <li>My Settings</li>
          <li>Company Settings</li>
        </ul>
      </li>
  </ul>
</div>
  

<div class="footer"></div>
</div>
</body>
</html>