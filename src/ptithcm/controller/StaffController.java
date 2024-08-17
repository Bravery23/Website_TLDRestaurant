package ptithcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.entity.Orders;

@Transactional
@Controller
@RequestMapping("/staff/")
public class StaffController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value = "orderManagement") 
	public String orderManagement() {
		return "staff/Orders";
	}
	
	@RequestMapping(value = "updateOrder") 
	public String updateOrder(@RequestParam("id") int id, HttpServletResponse response) {
        Session session = factory.getCurrentSession();
        Orders order = (Orders)session.load(Orders.class, id);
        order.setStatus("Completed");
        session.update(order);
        
        //Không gửi respone, server tự động gửi tới view lỗi
	    response.setContentType("text/html");
	    // Write the generated HTML table to the response
	    try (PrintWriter writer = response.getWriter()) {
	    	//gửi respone text tới view
	      writer.write("dung");
	    } catch (IOException e) {
	      // Handle exception
	    }
        return null;
	}
	
	@RequestMapping(value = "getOrderData") 
	public String orderManager(ModelMap model,@RequestParam(value = "curId", defaultValue = "-1") int curId, HttpServletRequest request, HttpServletResponse response) {
	    Session session = factory.getCurrentSession();
	    String hql = "FROM Orders WHERE status = 'Pending' ORDER BY Order_date DESC";
	    Query query = session.createQuery(hql);
	    List<Orders> orderList = query.list();
	    Orders.setOrderDayAndTime(orderList);
	    
	    //Tạo mã vẽ bảng
	    String htmlTable = generateOrdersTable(orderList);
	    if( orderList.size() > 0)
	    {
		    htmlTable = orderList.get(0).getId()+htmlTable;
	    }
	    //Thêm mã đầu tiên để check
	    response.setContentType("text/html");
	    // Write the generated HTML table to the response
	    try (PrintWriter writer = response.getWriter()) {
	    	//gửi respone text tới view
	      writer.write(htmlTable);
	    } catch (IOException e) {
	      // Handle exception
	    }
	    return null; // No further view rendering needed
	}
	private String generateOrdersTable(List<Orders> orderList) {
		  StringBuilder tableHtml = new StringBuilder();
		  tableHtml.append("<table>"); // Open table tag

		// Generate table headers
		  tableHtml.append("<thead class=\"table-light\"> <tr>")
		           .append("<th>No.</th>")
		           .append("<th>Customer</th>")
		           .append("<th>Date</th>")
		           .append("<th>Time</th>")
		           .append("<th>Price</th>")
		           .append("<th>Detail</th>")
		           .append("<th>Confirm</th>")
		           .append("</tr> </thead>");

		  // Build table rows using a loop
		  int stt = 1;
		  for (Orders order : orderList) {
		      tableHtml.append("<tr>")
		               .append("<td>").append(stt++).append("</td>") // Order ID
		               .append("<td>").append(order.getCustomer().getUsername()).append("</td>") // Customer
		               .append("<td>").append(order.getOrderDay()).append("</td>") // Date
		               .append("<td>").append(order.getOrderTime()).append("</td>") // Time
		               .append("<td>").append(order.getTotalPrice()).append("</td>") // Price
		               .append("<td>")
		               .append("<a href=\"../user/orderdetail.htm?orderId=").append(order.getId()).append("\">")
		               .append("<i class=\"mdi mdi-format-list-bulleted\"></i>")
		               .append("</a>")
		               .append("</td>") // Detail link
		               .append("<td>")
		               .append("<button type=\"button\" class=\"btn btn-outline-success btn-sm\" id=\"" + order.getId() + "\" onclick=\"updateOrdersTable(" + order.getId() + ")" + "\">Finish</button>")
		               .append("</td>") // Confirm button
		               .append("</tr>");
		  }

		  tableHtml.append("</table>"); // Close table tag
		  return tableHtml.toString();
		}

}
