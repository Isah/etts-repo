package com.presentation.displaymgt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.data.dataFacade.TimeSheetDataFacade;

public class EmployeeNumberServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		
		TimeSheetDataFacade tfacade = new TimeSheetDataFacade();
		
		String employeeno = request.getParameter("emp_number");
		
		if(tfacade.isEmployeeNoExist(employeeno)){
			request.getRequestDispatcher("/signup.jsp").forward(request, response);
		}else{
			request.setAttribute("errorMessage", "Access Denied");
			request.getRequestDispatcher("/employeeNumber.jsp").forward(request, response);
		}
	
	}
}
