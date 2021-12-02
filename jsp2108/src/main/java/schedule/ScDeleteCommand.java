package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ScDeleteCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		int yy = request.getParameter("yy")==null?1:Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null?1:Integer.parseInt(request.getParameter("mm"));
		
		ScheduleDAO dao = new ScheduleDAO();
		int res = dao.setScDelete(idx);
		
		
		if(res == 1) {
			request.setAttribute("msg", "scDeleteOk");
		} else {
			request.setAttribute("msg", "scDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/schedule.sc?yy="+yy+"&mm="+mm);
	}

}
