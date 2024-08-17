package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.entity.*;

@Transactional
@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("userinfo")
	public String userInfo(HttpServletRequest request, ModelMap model, @RequestParam(value = "customerId" , required = false) String cusID) {
		Session session = factory.getCurrentSession();
		
		HttpSession sessionProg = request.getSession();
		
		String role = (String) sessionProg.getAttribute("role");
		String customerId;
		if(role.equals("Admin"))
		{
			customerId = cusID;
		}
		else customerId = (String) sessionProg.getAttribute("user");
		//Lấy thông tin khách hàng
		String hql = "FROM Customers WHERE username = '"+customerId+"'";
		Query query = session.createQuery(hql);
		Customers customer = (Customers)query.uniqueResult();
		model.addAttribute("customer", customer);
		
		//Lấy thông tin danh sách đặt hàng
		hql = "FROM Orders WHERE customer.username = '"+customerId+"' ORDER BY Order_date DESC";
		query = session.createQuery(hql);
		List<Orders> orderList = query.list();
		Orders.setOrderDayAndTime(orderList);
		model.addAttribute("orderList", orderList);
		
		return "user/userinfo";
	}
	
	@RequestMapping("orderdetail")
	public String orderDetail(HttpServletRequest request, ModelMap model)
	{
		String orderId = (String) request.getParameter("orderId");
		if (orderId == null)
		{
			orderId = "-1";
		}
		System.out.println("123456");
		Session session = factory.getCurrentSession();
		
		//Lấy order detail
		String hql = "FROM Order_Details WHERE order.id = '"+orderId+"'";
		Query query = session.createQuery(hql);
		List<Order_Details> Order_Details = query.list();
		model.addAttribute("detail", Order_Details);
		
		
		return "user/orderDetail";
	}
	@RequestMapping(value = "saveChange",  method = RequestMethod.POST)
	public String saveChange(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("name") String name,  @RequestParam("phone") String phone, @RequestParam("email") String email)
	{
		Session session = factory.getCurrentSession();
		String message ="";
		HttpSession sessionProg = request.getSession();
		String customerId = (String) sessionProg.getAttribute("user");
		//Lấy thông tin khách hàng
		String hql = "FROM Customers WHERE username = '"+customerId+"'";
		Query query = session.createQuery(hql);
		Customers customer = (Customers)query.uniqueResult();
		
		if(customer.getName().equals(name) && customer.getEmail().equals(email) && customer.getNumber().equals(phone))
		{
			message = "Bạn chưa thực hiện thay đổi nào";
		}
		else
		{
			session = factory.openSession();
			Transaction t = session.beginTransaction();
			try
			{
				hql = "update Customers set name = :newName, number = :newPhone, email = :newEmail where username = :username";
	            session.createQuery(hql)
	                    .setParameter("newName", name)
	                    .setParameter("newPhone", phone)
	                    .setParameter("newEmail", email)
	                    .setParameter("username", customer.getUsername())
	                    .executeUpdate();
	            t.commit();
	            message = "Cập nhập thành công";
			}
			catch(Exception e)
			{
				t.rollback();
			}
			session.close();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/user/userinfo.htm";
	}
	@RequestMapping(value = "ChangePassword",  method = RequestMethod.POST)
	public String changePassword(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("newPassword") String newPass)
	{
		HttpSession sessionProg = request.getSession();
		String user = (String) sessionProg.getAttribute("user");
		String pass = (String) sessionProg.getAttribute("pass");
		String message ="";
		if(pass.equals(newPass))
		{
			message = "Mật khẩu mới trùng với mật khẩu cũ";
		}
		else
		{
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try
			{
				String hql = "update Customers set password = :newPass where username = :username";
	            session.createQuery(hql)
	                    .setParameter("newPass", newPass)
	                    .setParameter("username", user)
	                    .executeUpdate();
	            t.commit();
	            message = "Thay đổi mật khẩu thành công";
	            sessionProg.setAttribute("pass",pass);
			}
			catch(Exception e)
			{
				t.rollback();
			}
			session.close();			
		}
		
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/user/userinfo.htm";
	}
}
