package ptithcm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.bean.Company;
import ptithcm.entity.*;

@Transactional
@Controller
@RequestMapping("/index/")
public class IndexController {
	@Autowired
	SessionFactory factory;
	@Autowired
	JavaMailSender mailer;
	@Autowired
	Company comp;
	//Trang chủ
	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap model) {
		Session session = factory.getCurrentSession();
		
		String user ="";
		String pass ="";
		String role ="";
		Boolean isLogged = false;
		
		HttpSession sessionProg = request.getSession();
		
		user = (String) sessionProg.getAttribute("user");
		if (user == null)
		{
			sessionProg.setAttribute("user",user);
		}
		
		pass = (String) sessionProg.getAttribute("pass");
		if (pass == null)
		{
			sessionProg.setAttribute("pass",pass);
		}
		
		role = (String) sessionProg.getAttribute("role");
		if (role == null)
		{
			sessionProg.setAttribute("role",role);
		}
		
		isLogged = (Boolean) sessionProg.getAttribute("isLogged");
		if (isLogged == null)
		{
			isLogged = false;
			sessionProg.setAttribute("isLogged",isLogged);
		}
		
		//Lấy danh sách foods
		String hql = "FROM Categories";
		Query query = session.createQuery(hql);
		List<Categories> categoriesList = query.list();
		
		model.addAttribute("categories", categoriesList);
		
		//Lấy danh sách foods
		hql = "FROM Foods";
		query = session.createQuery(hql);
		List<Foods> foodList = query.list();
		model.addAttribute("foods", foodList);
		
		//Lấy danh sách comments
		hql = "FROM Comments";
		query = session.createQuery(hql);
		List<Comments> commentList = query.list();
		model.addAttribute("comments", commentList);
		
		//Thêm tạm 1 user để làm view userinfo

		model.addAttribute("customerId",user);
		model.addAttribute("company",comp);
		return "index";
	}
	
	//CART
	@RequestMapping("cart")
	public String cart(ModelMap modal, @RequestParam(value = "foodId") String foodId) {
	    
	    // Xử lý giá trị foodId ở đây
	    if (!foodId.equals("null") && !foodId.equals("")) {
	        // Chuyển đổi chuỗi thành mảng các foodIds
	        String[] stringFoodIds = foodId.split(",");
	        
	        // Lấy danh sách foods được chọn, truyền qua view
	        Session session = factory.getCurrentSession();
	        
	        ////Lấy danh sách foods
	        StringBuilder hqlBuilder = new StringBuilder("FROM Foods WHERE id IN (");

	        //// Thêm các id vào chuỗi truy vấn
	        for (int i = 0; i < stringFoodIds.length; i++) {
	            hqlBuilder.append(Integer.parseInt(stringFoodIds[i]));
	            if (i < stringFoodIds.length - 1) {
	                hqlBuilder.append(", ");
	            }
	        }
	        hqlBuilder.append(")");
	        
	        //// Thực hiện truy vấn
	        String hql = hqlBuilder.toString();
	        Query query = session.createQuery(hql);
	        List<Foods> foodsList = query.list();
	        
	        modal.addAttribute("list",foodsList);
	        return "cart/cart";
	    } 
	    
	    //Nếu không có id thì return về index
	    return "redirect:/index/index.htm";
	    		
	    
	}

	@RequestMapping("success")
    public String processCart(RedirectAttributes redirectAttributes,HttpServletRequest request,@RequestParam("vnp_ResponseCode") String responseCode)
	{
		String message = "Giao Dịch Thất Bại!";
		if(responseCode.equals("00"))
		{
			HttpSession sessionProg = request.getSession();
	        // Xử lý dữ liệu 
			
			Session session = factory.getCurrentSession();
			Customers cus = (Customers)session.get(Customers.class, sessionProg.getAttribute("user").toString());
			Orders order = new Orders(new Date(),cus,Double.parseDouble(sessionProg.getAttribute("amount").toString()));
			
			ArrayList<Integer> listFood = (ArrayList<Integer>) sessionProg.getAttribute("foodIds");
			ArrayList<Integer> listQuantity = (ArrayList<Integer>) sessionProg.getAttribute("quantities");
			ArrayList<Double> listPrice = (ArrayList<Double>) sessionProg.getAttribute("priceElement");
			ArrayList<Order_Details> listOrderDetail = new ArrayList<>();
			
			for(int i = 0; i < listFood.size(); i++)
			{
				Foods food = (Foods)session.get(Foods.class, listFood.get(i));
				listOrderDetail.add(new Order_Details(food,order,listQuantity.get(i),listPrice.get(i)));
			}

			session = factory.openSession();
			Transaction t = session.beginTransaction();
			try
			{
				session.save(order);
		        for (Order_Details orderdetail : listOrderDetail) {
		            session.save(orderdetail);
		        }
				t.commit();
				message = "Đặt hàng thành công!";	
				sessionProg.removeAttribute("foodIds");
				sessionProg.removeAttribute("quantities");
				sessionProg.removeAttribute("amount");
				sessionProg.removeAttribute("priceElement");
			}
			catch(Exception e)
			{
				t.rollback();
			}
			session.close();
		}

		redirectAttributes.addFlashAttribute("Message", message);

        // Chuyển hướng đến trang hoặc làm gì đó khác
        return "redirect:/index/index.htm";
    }

	//LogOut
	@RequestMapping("log_out")
	public String logOut(HttpServletRequest request, RedirectAttributes redirectAttributes)
	{
		HttpSession sessionProg = request.getSession();
		String message ="Đăng xuất thành công!";
		sessionProg.invalidate();
		redirectAttributes.addFlashAttribute("Message", message);
		return "redirect:/index/index.htm";
	}
	
	//Contact Form
	@RequestMapping("rating")
	public String rating(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("reviewContent") String reviewContent, @RequestParam("radio1") String rating)
	{
		//Xử lý gửi form
		HttpSession sessionProg = request.getSession();
		String user = (String) sessionProg.getAttribute("user");
		String message ="";
		if(user == null)
		{
			message = "Cần phải đăng nhập mới được đánh giá";
		}
		else
		{
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			
			try
			{
				Customers cus = new Customers();
				cus.setUsername(user);
				session.refresh(cus);
				
				Comments cmt = new Comments();
				cmt.setContent(reviewContent);
				cmt.setCustomer(cus);
				cmt.setRating(Integer.parseInt(rating));
				
				session.save(cmt);
	            message = "Gửi đánh giá thành công";
	            t.commit();
			}
			catch(Exception e)
			{
				t.rollback();
				message = "Gửi đánh giá thất bại";
			}
			session.close();			
		}
		redirectAttributes.addFlashAttribute("Message", message);
		return "redirect:/index/index.htm";
	}
}
