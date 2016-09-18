package com.presentation.displaymgt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.application.email.MailSenderBean;

public class UserEventHandler extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String clientRequest = request.getParameter("tester");
		
		if(clientRequest.equals("createTimeSheet")){
			
			out.print("created "+clientRequest);
			
		}else if(clientRequest.equals("deleteTimeSheet")){
			
			String timeSheetId = request.getParameter("timeSheetId");
			out.print("hello bicth" +clientRequest+"  "+timeSheetId+" row deleted");
			
		}else if(clientRequest.equals("addTimeSheet")){
			
			String clientName = request.getParameter("clientName");
			String clientDate = request.getParameter("clientDate");
			String timeWorked = request.getParameter("timeWorked");
			String serviceCode = request.getParameter("serviceCode");
			String billingState = request.getParameter("billingState");
			String section = request.getParameter("section");
			
			out.print("yo "+clientRequest+"  "+clientName+"  "+clientDate+"  "+timeWorked+"  "+serviceCode+"  "+billingState+"  "+section+" added to timesheet");
			
		}else if(clientRequest.equals("sendEmail")){
			String toEmail = request.getParameter("toEmail");
			String subject = request.getParameter("subject");
			String message = request.getParameter("message");
			
			String fromEmail = "timesheetbk@gmail.com";
			String username = "alex matovu";
			String password = "Bukenyaa";
			
			MailSenderBean mailSender = new MailSenderBean();
			mailSender.sendMail(fromEmail, username, password, toEmail, subject, message);
			
		}else if(clientRequest.equals("approveTimeSheet")){
			
			String timeSheetId = request.getParameter("approveTimeSheetId");
			out.print("hello bicth" +clientRequest+"  "+timeSheetId+" approved");
			
		}else if(clientRequest.equals("rejectTimeSheet")){
			
			String timeSheetId = request.getParameter("approveTimeSheetId");
			out.print("hello bicth" +clientRequest+"  "+timeSheetId+" rejected");
			
		}else if(clientRequest.equals("submitTimeSheet")){
			String id = request.getParameter("ts_id");
			
			out.print("ts submited  "+id+" allowed");
			
		}
		
		
		
	}
}
