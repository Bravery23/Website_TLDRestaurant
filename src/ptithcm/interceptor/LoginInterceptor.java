package ptithcm.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
@Override
public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws IOException
{
	HttpSession sessionProg = request.getSession();
	Boolean isLogged = false;
	isLogged = (Boolean) sessionProg.getAttribute("isLogged");

	if(isLogged == false || isLogged == null)
	{
		response.sendRedirect(request.getContextPath()+"/index/index.htm");
		return false;
	}
	String url = request.getRequestURI();
	if(sessionProg.getAttribute("role").equals("Customer"))
	{
		if(url.contains("admin") || url.contains("staff"))
		{
			response.sendRedirect(request.getContextPath()+"/index/index.htm");
			return false;
		}
	}
	else if(sessionProg.getAttribute("role").equals("Admin"))
	{
		if(!url.contains("user/userinfo") && !url.contains("admin") && !url.contains("log_out"))
		{
			response.sendRedirect(request.getContextPath()+"/admin/dashboard.htm");
			return false;
		}
	}
	else
	{
		if(!url.contains("staff") && !url.contains("log_out"))
		{
			response.sendRedirect(request.getContextPath()+"/staff/orderManagement.htm");
			return false;
		}
	}
	return true;
}
}
