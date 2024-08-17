package ptithcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.Order;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javassist.expr.NewArray;
import ptithcm.entity.*;

@Transactional
@Controller
@RequestMapping("/admin/")
public class FoodController {
	@Autowired
	SessionFactory factory;

	@Transactional
	@RequestMapping(value="/addProduct", method=RequestMethod.GET)
	public String addProduct(ModelMap model) {
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        String hql = "FROM Categories";
        Query query = session.createQuery(hql);
		List<Categories> list = query.list();
		model.addAttribute("list",list);
		model.addAttribute("page",1);
		return "dash-board/editProduct";
	}
	
    @RequestMapping(value="/addProduct", method=RequestMethod.POST)
    public String addProduct(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("file") MultipartFile file,
            @RequestParam("name") String name,
            @RequestParam("price") double price,
            @RequestParam("category") String category_name,
            ModelMap model,
            HttpServletRequest request) {
        if (category_name.equals("new")) {
        	category_name = request.getParameter("new");
        }
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
        	if (file.isEmpty()) {
        		throw new IOException("Lỗi ảnh trống");
        	}
        	String url = upload(file);
	        String hql = "FROM Categories";
	        Query query = session.createQuery(hql);
			List<Categories> list = query.list();
			Categories category = null;
	        for (Categories cat : list) {
	        	if (cat.getName().equals(category_name)) {
	        		category = cat;
	        	}  	
	        }
	        if (category == null) {
	        	category = new Categories();
	        	category.setName(category_name);
	        	session.persist(category);
	        }
	        
	        Foods food = new Foods();
	        food.setName(name);
	        food.setPrice(price);
	        food.setCategory(category);
	        food.setUrl(url);
	        session.persist(food);
	        trans.commit();
	        return "redirect:/admin/product.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Thêm món bị lỗi");
        	System.out.println(ex);
        	return "redirect:/admin/addProduct.htm";
        }
        finally {
			session.close();
		}
        
    }
    
    @RequestMapping(value="/modifyProduct", method=RequestMethod.POST)
    @Transactional
    public String modifyProduct(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("productId") int id,
    		@RequestParam("file") MultipartFile file,
            @RequestParam("name") String name,
            @RequestParam("price") double price,
            @RequestParam("category") String category_name,
            ModelMap model,
            HttpServletRequest request) {
        
        if (category_name.equals("new")) {
        	category_name = request.getParameter("new");
        }
        
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
	        String hql = "FROM Categories";
	        Query query = session.createQuery(hql);
	        List<Categories> list = query.list();
			Categories category = null;
	        for (Categories cat : list) {
	        	if (cat.getName().equals(category_name)) {
	        		category = cat;
	        	}  	
	        }
	        if (category == null) {
	        	category = new Categories();
	        	category.setName(category_name);
	        	session.persist(category);
	        }
	        
	        hql = String.format("FROM Foods WHERE id=%s", id);
	        query = session.createQuery(hql);
	        Foods food = (Foods) query.list().get(0);
	        if (!file.isEmpty()) {
	        	String url = food.getUrl();
		        File f = new File(url);
		        f.delete();
		        url = upload(file);
	        	food.setUrl(url);
        	}
//	        if (f.delete()) {
//	        	url = upload(file);
//	        	food.setUrl(url);
//	        }else {
//	        	throw new IOException("Lỗi Xóa file");
//	        }
	        food.setName(name);
	        food.setPrice(price);
	        food.setCategory(category);
	        session.update(food);
	        trans.commit();
	        return "redirect:/admin/product.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Chỉnh sửa món bị lỗi");
        	System.out.println(ex);
        	return "redirect:/admin/editProduct.htm?productId=%s&page=%d".formatted(id, 1);
        }
        finally {
			session.close();
		}  
    }
    
    
    @RequestMapping(value="/deleteProduct")
    @Transactional
    public String deleteProduct(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("productId") int id,
            ModelMap model,
            HttpServletRequest request) {
        
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
        	String hql = String.format("FROM Order_Details WHERE food.id=%s", id);
        	Query query = session.createQuery(hql);
	        List<Order_Details> order_list = query.list();
	        if (!order_list.isEmpty()) {
	        	throw new IOException("Sản phẩm đã được thanh toán");        	
	        }
	        
	        hql = String.format("Delete FROM Foods WHERE id=%s", id);
	        query = session.createQuery(hql);
	        query.executeUpdate();
	        trans.commit();
	        return "redirect:/admin/product.htm";
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi xóa sản phẩm");
        	System.out.println(ex);
        	return "redirect:/admin/editProduct.htm?productId=%s&page=%d".formatted(id, 1);
        }
        finally {
			session.close();
		}  
    }
    
    @RequestMapping(value="/modifyCategory")
    @Transactional
    public String modifyCategory(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("categoryId") int id,
    		@RequestParam("categoryName") String categoryName,
            ModelMap model,
            HttpServletRequest request) {
        
        Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {	        
	        String hql = String.format("FROM Categories WHERE id=%s", id);
	        Query query = session.createQuery(hql);
	        Categories category = (Categories) query.list().get(0);
	        category.setName(categoryName);
	        session.update(category);
	        trans.commit();
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi sửa category");
        	System.out.println(ex);
        }
        finally {
			session.close();
		}
        return "redirect:/admin/product.htm";
    }
    
    @RequestMapping(value="/deleteCategory")
    @Transactional
    public String deleteCategory(
    		RedirectAttributes redirectAttributes,
    		@RequestParam("categoryId") int id,
            ModelMap model,
            HttpServletRequest request) {
        
    	Session session = factory.openSession();
        Transaction trans = session.beginTransaction();
        try {
        	String hql = String.format("FROM Foods WHERE category.id=%s", id);
        	Query query = session.createQuery(hql);
	        List<Order_Details> order_list = query.list();
	        if (!order_list.isEmpty()) {
	        	throw new IOException("Category đang đước sử dụng");        	
	        }
	        hql = String.format("Delete FROM Categories WHERE id=%s", id);
	        query = session.createQuery(hql);
	        query.executeUpdate();
	        trans.commit();
	        redirectAttributes.addFlashAttribute("Message", "Xóa category thành công");
        }
        catch (Exception ex){
        	trans.rollback();
        	redirectAttributes.addFlashAttribute("Message", "Lỗi xóa category");
        	System.out.println(ex);
        }
        finally {
			session.close();
		}
        return "redirect:/admin/product.htm";
    }
    
    
    public String upload(MultipartFile image) throws IOException
    {
    	
    	DateTimeFormatter dfm = DateTimeFormatter.ofPattern("ddMMyyyyHHmmss");  
		LocalDateTime now = LocalDateTime.now();
    	
    	String filename =  "%s.png".formatted(dfm.format(now));
    	System.out.println(filename);
    	String uploadDir = "D:/Web_dev/WebProject/WebProject/WebContent/Resources/images";
    	Path uploadPath = Paths.get(uploadDir);
    	if(!Files.exists(uploadPath))
    	{
    		Files.createDirectories(uploadPath);
    	}
    	
    	try
    	{
    		InputStream inputStream = image.getInputStream();
    		Path filePath = uploadPath.resolve(filename);
    		System.out.println(filePath.toFile().getAbsolutePath());
    		Files.copy(inputStream,filePath, StandardCopyOption.REPLACE_EXISTING);
    		return filename;
    	}
    	catch(IOException e)
    	{
    		throw new IOException("Could not save");
    	}
    }
}
