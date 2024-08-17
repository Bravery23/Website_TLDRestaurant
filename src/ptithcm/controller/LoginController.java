package ptithcm.controller;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.entity.Comments;
import ptithcm.entity.Customers;

@Controller
@Transactional
@RequestMapping("/login/")
public class LoginController {
	@Autowired
	SessionFactory factory;
	@Autowired
	JavaMailSender mailer;
	@RequestMapping("loginForm")
	public String index(HttpServletRequest request)
	{
		return "login/loginForm";
	}

	@RequestMapping("signupForm")
	public String signupForm() {
		return "login/signupForm";
	}
	
	@RequestMapping("forgotPassword")
	public String fgp() {
		return "login/forgot-password";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Session session = factory.getCurrentSession();
		
		HttpSession sessionProg = request.getSession();
		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
		String role = "";
		String errorMessage = "Sai Tài Khoản hoặc Mật Khẩu";
		
		if(user.equals("staff_1") && pass.equals("12"))
		{
			role = "Staff";
		}
		else
		{
			String hql = "SELECT COUNT(*) FROM Customers WHERE username = '" + user + "' and password ='"+ pass +"'";
			Query query = session.createQuery(hql);
			Long count = (Long) query.uniqueResult();
			if(count != 0)
			{
				role = "Customer";
			}
			else
			{
				hql = "SELECT COUNT(*) FROM Admins WHERE username = '" + user + "' and password ='"+ pass +"'";
				query = session.createQuery(hql);
				count = (Long) query.uniqueResult();
				if(count != 0)
				{
					role = "Admin";
				}
				else
				{
					model.addAttribute("errorMessage",errorMessage);
					return "login/loginForm";
				}
			}
		}
		boolean isLogged = true;
		sessionProg.setAttribute("user",user);
		sessionProg.setAttribute("pass",pass);
		sessionProg.setAttribute("role",role);
		sessionProg.setAttribute("isLogged", isLogged);
		if(role.equals("Admin"))
		{
			return "redirect:/admin/dashboard.htm";
		}
		if(role.equals("Staff"))
		{
			return "redirect:/staff/orderManagement.htm";
		}
		return "redirect:/index/index.htm";
	}

	@RequestMapping(value = "signUp", method = RequestMethod.POST)
	public String signup(RedirectAttributes redirectAttributes, HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Session session = factory.getCurrentSession();
		
		String user = request.getParameter("username");
		String email = request.getParameter("re_email");
		String message = "";
		
		if(user.equals("staff_1"))
		{
			message = "UserName đã tồn tại vui lòng chọn user name khác";
			model.addAttribute("Message", message);
			return "login/signupForm";
		}
		else
		{
			String hql = "SELECT COUNT(*) FROM Customers WHERE email = '" + email + "'";
			Query query = session.createQuery(hql);
			Long count = (Long) query.uniqueResult();
			if(count != 0)
			{
				message = "Mail đã tồn tại vui lòng chọn mail khác";
				model.addAttribute("Message", message);
				return "login/signupForm";
			}
			
			hql = "SELECT COUNT(*) FROM Customers WHERE username = '" + user + "'";
			query = session.createQuery(hql);
			count = (Long) query.uniqueResult();
			if(count != 0)
			{
				message = "UserName đã tồn tại vui lòng chọn user name khác";
				model.addAttribute("Message", message);
				return "login/signupForm";
			}
			else
			{
				hql = "SELECT COUNT(*) FROM Admins WHERE username = '" + user + "'";
				query = session.createQuery(hql);
				count = (Long) query.uniqueResult();
				if(count != 0)
								{
					message = "UserName đã tồn tại vui lòng chọn user name khác";
					model.addAttribute("Message", message);
					return "login/signupForm";
				}
				else
				{
					session = factory.openSession();
					Transaction t = session.beginTransaction();
					String name = request.getParameter("name");
					String phone = request.getParameter("phone");
					String pass = request.getParameter("pass");
					try
					{
						Customers cus = new Customers();
						cus.setUsername(user);
						cus.setPassword(pass);
						cus.setNumber(phone);
						cus.setEmail(email);
						cus.setName(name);
						cus.setBalance(0.0);
						
						session.save(cus);
			            t.commit();
			            message = "Tạo Tài khoản thành công";
					}
					catch(Exception e)
					{
						t.rollback();
						message = "Tạo Tài khoản thất bại";
					}
					session.close();
				}
			}
		}
		redirectAttributes.addFlashAttribute("Message", message);
		return "redirect:/index/index.htm";
	}

	@RequestMapping(value = "forgot-password", method = RequestMethod.POST)
	public String forgot_password(RedirectAttributes redirectAttributes, HttpServletRequest request,HttpServletResponse response,ModelMap model)
	{
		Session session = factory.getCurrentSession();
		
		String mail = request.getParameter("email");
		String message = "";
		
		String hql = "SELECT COUNT(*) FROM Customers WHERE email = '" + mail + "'";
		Query query = session.createQuery(hql);
		Long count = (Long) query.uniqueResult();
		
		if(count == 0)
		{
			message = "Email không hợp lệ vui lòng chọn email khác";
			model.addAttribute("Message", message);
			return "login/forgot-password";
		}
		else
		{
			String tempPass;
		    try
		    {
				MessageDigest m = MessageDigest.getInstance("MD5");
			    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
			    Date date = new Date();  
				tempPass = mail + formatter.format(date);
				m.reset();
				m.update(tempPass.getBytes());
				byte[] digest = m.digest();
				tempPass = digest.toString();
			} 
		    catch (NoSuchAlgorithmException e)
		    {
				message = "Lỗi trong quá trình xử lý mail";
				model.addAttribute("Message", message);
				return "login/forgot-password";				
			}
		    
			session = factory.openSession();
			Transaction t = session.beginTransaction();
			try
			{
				hql = "update Customers set password = :newPass where email = :mail";
	            session.createQuery(hql)
	                    .setParameter("newPass", tempPass)
	                    .setParameter("mail", mail)
	                    .executeUpdate();
	            t.commit();
			}
			catch(Exception e)
			{
				t.rollback();
				message = "Lỗi trong quá trình xử lý mail";
				model.addAttribute("Message", message);
				return "login/forgot-password";		
			}
			session.close();	
			try
			{
				MimeMessage mailing = mailer.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mailing, true, "utf-8");
				helper.setFrom("TLD_Restaurant","TLD_Restaurant");
				helper.setTo(mail);
				helper.setReplyTo("TLD_Restaurant","TLD_Restaurant");
				helper.setSubject("QUÊN MẬT KHẨU");
				helper.setText("Đây là mật khẩu mới : "+tempPass+"\n Sử dụng mật khẩu trên để đăng nhập \n Bạn có thể đổi mật khẩu khi đăng nhập thành công!",true);
				
				mailer.send(mailing);
			}
			catch(Exception ex)
			{
				message = "Lỗi trong quá trình xử lý mail";
				model.addAttribute("Message", message);
				return "login/forgot-password";		
			}
			message = "Kiểm tra mail để đăng nhập";
		}
		redirectAttributes.addFlashAttribute("Message", message);
		return "redirect:/index/index.htm";
	}
}
