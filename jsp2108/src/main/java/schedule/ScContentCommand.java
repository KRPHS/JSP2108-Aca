package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScContentCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ymd = request.getParameter("ymd")==null?"":request.getParameter("ymd");
		int yy = request.getParameter("yy")==null?1:Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null?1:Integer.parseInt(request.getParameter("mm"));

		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		ScheduleDAO dao = new ScheduleDAO();
		ScheduleVO vo = dao.getScContent(ymd, mid);
		
		request.setAttribute("vo", vo);
		request.setAttribute("ymd", ymd);
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
	}

}
