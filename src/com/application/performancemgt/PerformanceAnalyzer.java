package com.application.performancemgt;

import java.util.List;

import com.application.timeplans.TimeSheet;
import com.data.dataFacade.AbstractDAOFactory;
import com.data.dataFacade.TimeSheetDataFacade;
import com.data.worktimedatamgt.TimeSheetDAO;

public class PerformanceAnalyzer {

	
	public List<TimeSheet> analyzeTimeSpent(String datefro, String dateto, String filter,int approvestate){
		List<TimeSheet> timesheetlist = null;
		
		
		TimeSheetDataFacade facade = new TimeSheetDataFacade();
		
		
		return facade.searchTimeSheet(datefro, dateto, filter, approvestate);
	}
	
	
	
	
}
