package ptithcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.criteria.Order;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.entity.*;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("dashboard")
	public String index(ModelMap model) {
		DateTimeFormatter dfm = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
		LocalDateTime now = LocalDateTime.now();
		Session session = factory.getCurrentSession();
		String hql = String.format("FROM Orders WHERE orderDate > '12-31-%d' AND orderDate < '1-1-%d'", now.getYear() - 1, now.getYear() + 1);
		Query query = session.createQuery(hql);
		List<Orders> orderList = query.list();
		
		double sales[] = new double [12];
		Double currentSale = new Double(0.0);
		for (Orders order: orderList) {
			System.out.println(order.getOrderDate().getMonth());
			sales[order.getOrderDate().getMonth() - 1] += order.getTotalPrice();
			if (order.getOrderDate().getDate() == now.getDayOfMonth() && order.getOrderDate().getMonth() == now.getMonth().getValue()) {
				currentSale += order.getTotalPrice();
			}
		}
		
		List<Double> salesData = new ArrayList<Double>();
		for (int mi = 0; mi < 12; mi++) {
			salesData.add(sales[mi]);
		}
		
        model.addAttribute("sales", salesData);
        model.addAttribute("currentSale", currentSale);
        model.addAttribute("currentDate", dfm.format(now));
        
		return "dash-board/dashboard";
	}
	
	@RequestMapping("profile")
	public String profile() {
		return "dash-board/profile";
	}
	
	//Order
	@RequestMapping("order")
	public String order(@RequestParam(value = "page", required = false) String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách foods
		String hql = "FROM Orders ORDER BY Order_date DESC";
		Query query = session.createQuery(hql);
		List<Orders> orderList = query.list();
		Orders.setOrderDayAndTime(orderList);
		
		List<Orders> pageOrderList = new ArrayList<Orders>();
		Orders temp = new Orders();
		int index = 0;
		if(page==null) page = "1";
		
		////lấy 10 foods tương ứng với số page
		for(int i=1; i<=10; i++) {
			index = 10*(Integer.parseInt(page)-1)+i-1;
			if(index < orderList.size()) {
				temp = orderList.get(index);
				pageOrderList.add(temp);
			}
			else break;
		}
		
		model.addAttribute("order", pageOrderList);
		
		//Tính số trang cần để show
		double numPage = Math.ceil((double)(orderList.size())/10);
		
		model.addAttribute("numPage", numPage);
		model.addAttribute("curPage",Integer.parseInt(page));
		
		return "dash-board/Orders";
	}
	
	@RequestMapping("orderdetail")
	public String orderDetail(@RequestParam("orderId") String orderId, @RequestParam(value = "curPage") String curPage, ModelMap model) {
		Session session = factory.getCurrentSession();
		
		//Lấy order detail
		String hql = "FROM Order_Details WHERE order.id = '"+orderId+"'";
		Query query = session.createQuery(hql);
		List<Order_Details> Order_Details = query.list();
		model.addAttribute("detail", Order_Details);
		
		model.addAttribute("curPage",Integer.parseInt(curPage));
		
		return "dash-board/orderDetail";
	}
	
	
	//Product
	@RequestMapping("product")
	public String product(@RequestParam(value = "page", required = false) String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách foods
		String hql = "FROM Foods";
		Query query = session.createQuery(hql);
		List<Foods> foodList = query.list();
		
		List<Foods> pageList = new ArrayList<Foods>();
		Foods temp = new Foods();
		int index = 0;
		if(page==null) page = "1";
		
		////lấy 10 foods tương ứng với số page
		for(int i=1; i<=10; i++) {
			index = 10*(Integer.parseInt(page)-1)+i-1;
			if(index < foodList.size()) {
				temp = foodList.get(index);
				pageList.add(temp);
			}
			else break;
		}
		
		model.addAttribute("list", pageList);
		
		//Lấy category
		hql = "FROM Categories";
		query = session.createQuery(hql);
		List<Categories> list = query.list();
		model.addAttribute("category", list);
		
		//Tính số trang cần để show
		double numPage = Math.ceil((double)(foodList.size())/10);
		
		model.addAttribute("numPage", numPage);
		model.addAttribute("curPage",Integer.parseInt(page));
		
		System.out.println(foodList.size()+" "+pageList.size()+" "+page+" "+numPage);
		
		return "dash-board/products";
	}
	
	@RequestMapping("editProduct")
	public String edit(@RequestParam(value = "productId") String id, @RequestParam(value = "page") String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		
		String hql = "FROM Foods WHERE id = '"+id+"'";
		Query query = session.createQuery(hql);
		
		// Khác new là edit, bằng new là add
		if(!id.equals("new")) {
			//Lấy thông tin product
			Foods product = (Foods)query.uniqueResult();
			model.addAttribute("product", product);
		}
		
		
		//Lấy category
		hql = "FROM Categories";
		query = session.createQuery(hql);
		List<Categories> list = query.list();
		model.addAttribute("list", list);
		
		model.addAttribute("page",page);
		
		return "dash-board/editProduct";
	}
	
	//Customer
	@RequestMapping("customer")
	public String customer(@RequestParam(value = "page", required = false) String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách customers
		String hql = "FROM Customers";
		Query query = session.createQuery(hql);
		List<Customers> cusList = query.list();
		
		List<Customers> pageList = new ArrayList<Customers>();
		Customers temp = new Customers();
		int index = 0;
		if(page==null) page = "1";
		
		//lấy 10 customers tương ứng với số page
		for(int i=1; i<=10; i++) {
			index = 10*(Integer.parseInt(page)-1)+i-1;
			if(index < cusList.size()) {
				temp = cusList.get(index);
				pageList.add(temp);
			}
			else break;
		}
		model.addAttribute("customer", pageList);
		
		
		//Tính số trang cần để show
		double numPage = Math.ceil((double)(cusList.size())/10);
		model.addAttribute("numPage", numPage);
		model.addAttribute("curPage",Integer.parseInt(page));
		
		
		return "dash-board/customer";
	}
	
	//Rating Review
	@RequestMapping("review")
	public String review(@RequestParam(value = "page", required = false) String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách comments
		String hql = "FROM Comments";
		Query query = session.createQuery(hql);
		List<Comments> comList = query.list();
		
		List<Comments> pageList = new ArrayList<Comments>();
		Comments temp = new Comments();
		int index = 0;
		if(page==null) page = "1";
		
		//lấy 10 customers tương ứng với số page
		for(int i=1; i<=10; i++) {
			index = 10*(Integer.parseInt(page)-1)+i-1;
			if(index < comList.size()) {
				temp = comList.get(index);
				pageList.add(temp);
			}
			else break;
		}
		model.addAttribute("review", pageList);
		
		
		//Tính số trang cần để show
		double numPage = Math.ceil((double)(comList.size())/10);
		model.addAttribute("numPage", numPage);
		model.addAttribute("curPage",Integer.parseInt(page));
		
		
		return "dash-board/review";
	}
	
	//Admin
	@RequestMapping("admin")
	public String admin(@RequestParam(value = "page", required = false) String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách Admins
		String hql = "FROM Admins";
		Query query = session.createQuery(hql);
		List<Admins> adminList = query.list();
		
		List<Admins> pageList = new ArrayList<Admins>();
		Admins temp = new Admins();
		int index = 0;
		if(page==null) page = "1";
		
		//lấy 10 customers tương ứng với số page
		for(int i=1; i<=10; i++) {
			index = 10*(Integer.parseInt(page)-1)+i-1;
			if(index < adminList.size()) {
				temp = adminList.get(index);
				pageList.add(temp);
			}
			else break;
		}
		model.addAttribute("admin", pageList);
		
		
		//Tính số trang cần để show
		double numPage = Math.ceil((double)(adminList.size())/10);
		model.addAttribute("numPage", numPage);
		model.addAttribute("curPage",Integer.parseInt(page));
		return "dash-board/admin";
	}
	
	//Thêm admin
	@RequestMapping("userinfo")
	public String userinfo(ModelMap model) {
		
		String email="newadmin@gmail.com";
		model.addAttribute("email",email);
		
		return "user/userinfo";
		
	}
	
	//Sửa thông tin admin
	@RequestMapping("adminDetail")
	public String adminDetail(@RequestParam("username") String username, @RequestParam("curPage") String page, ModelMap model) {
		Session session = factory.getCurrentSession();
		//Lấy danh sách Admins
		String hql = "FROM Admins WHERE username='%s'".formatted(username);
		Query query = session.createQuery(hql);
		List<Admins> adminList = query.list();
		
		Admins admin = adminList.get(0);
		Customers customer = new Customers();
		customer.setName(admin.getName());
		customer.setNumber(admin.getNumber());
		customer.setUsername(username);
		customer.setPassword(admin.getPassword());

		model.addAttribute("page", page);
		model.addAttribute("customer", customer);
		
		return "user/userinfo";
	}
	
	@RequestMapping(value="/addAdmin", method=RequestMethod.POST)
    @Transactional
    public String addProduct(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("username") String username,
            @RequestParam("name") String name,
            @RequestParam("phone") String number,
            ModelMap model,
            HttpServletRequest request) {
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
	        String hql = "FROM Customers Where username='%s'".formatted(username);
	        Query query = session.createQuery(hql);
			List<Customers> customerList = query.list();
			if (!customerList.isEmpty()) {
				throw new IOException("Username bị trùng");
			}
			hql = "FROM Admins Where username='%s'".formatted(username);
			query = session.createQuery(hql);
			List<Admins> adminList = query.list();
			if (!adminList.isEmpty()) {
				throw new IOException("Username bị trùng");
			}
	        
	        Admins admin = new Admins();
	        admin.setName(name);
	        admin.setNumber(number);
	        admin.setUsername(username);
	        admin.setPassword("12");
	        session.persist(admin);
	        trans.commit();
	        return "redirect:/admin/admin.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi thêm admin");
        	System.out.println(ex);
        	return "redirect:/admin/admin.htm";
        }
        finally {
			session.close();
		}
        
    }
	
	@RequestMapping("/deleteAdmin")
    @Transactional
    public String deleteAdmin(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("username") String username,
            ModelMap model,
            HttpServletRequest request) {
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
        	HttpSession http = request.getSession();
        	System.out.println(http);
        	String curUser = (String) http.getAttribute("user");
        	if (username.equals(curUser)) {
        		throw new IOException("Không xóa current username");
        	}
	        String hql = "DELETE Admins Where username='%s'".formatted(username);
	        Query query = session.createQuery(hql);
	        query.executeUpdate();
	        trans.commit();
	        return "redirect:/admin/admin.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Xóa admin bị lỗi");
        	System.out.println(ex);
        	return "redirect:/admin/admin.htm";
        }
        finally {
			session.close();
		}
        
    }
	
	@RequestMapping(value="/modifyAdmin", method=RequestMethod.POST)
    @Transactional
    public String modifyAdmin(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("username") String username,
            @RequestParam("name") String name,
            @RequestParam("phone") String number,
            ModelMap model,
            HttpServletRequest request) {
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
	        String hql = "FROM Admins Where username='%s'".formatted(username);
	        Query query = session.createQuery(hql);
			List<Admins> list = query.list();
			if (list.isEmpty()) {
				throw new IOException("Username không tồn tại");
			}
	        
	        Admins admin = list.get(0);
	        admin.setName(name);
	        admin.setNumber(number);
	        session.update(admin);
	        trans.commit();
	        return "redirect:/admin/admin.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi sửa admin");
        	System.out.println(ex);
        	return "redirect:/admin/admin.htm";
        }
        finally {
			session.close();
		}  
    }
	
	
	@RequestMapping(value="/changePassword", method=RequestMethod.POST)
    @Transactional
    public String changePassword(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("curUser") String username,
            @RequestParam("newPassword") String password,
            ModelMap model,
            HttpServletRequest request) {
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
	        String hql = "FROM Admins Where username='%s'".formatted(username);
	        Query query = session.createQuery(hql);
			List<Admins> list = query.list();
			if (list.isEmpty()) {
				throw new IOException("Username không tồn tại");
			}
	        
	        Admins admin = list.get(0);
	        admin.setPassword(password);
	        session.update(admin);
	        trans.commit();
	        return "redirect:/admin/admin.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi thay đổi mật khẩu");
        	System.out.println(ex);
        	return "redirect:/admin/admin.htm";
        }
        finally {
			session.close();
		}
        
    }
}

