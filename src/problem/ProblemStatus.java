package problem;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import server.problemStatus_sql;

public class ProblemStatus {
	public String problemStatus(String Str,int Run_id) {
		Pattern p = Pattern.compile("<tr\\s*align(.*?)</tr>",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(Str);
		ArrayList<String> linklist = new ArrayList<String>();
		while (m.find()) {
			String link = m.group();
			linklist.add(link);
		}
		String status = new String();
		status = linklist.get(0);
		
		Pattern p1 = Pattern.compile("<td>(.*?)</td>",
				Pattern.CASE_INSENSITIVE);
		Matcher m1 = p1.matcher(status);
		ArrayList<String> link = new ArrayList<String>();
		while (m1.find()) {
			String l = m1.group();
			link.add(l);
		}
		String codeLength="";
		String result="";
		String memery="";
		String time="";
		codeLength=link.get(7).replaceAll("<.*?>", "");
		memery=link.get(4).replaceAll("<.*?>", "");
		time=link.get(5).replaceAll("<.*?>", "");
		result= link.get(3).replaceAll("<.*?>", "");
		problemStatus_sql pp =new problemStatus_sql();
		try {
			pp.Updata(Run_id, result, memery, time,codeLength);
		} catch (NumberFormatException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return result;
	}
}
 