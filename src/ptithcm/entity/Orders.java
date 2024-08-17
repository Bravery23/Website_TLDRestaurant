package ptithcm.entity;

import javax.persistence.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Orders")
public class Orders {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "Order_date")
    private Date orderDate;

    @ManyToOne
    @JoinColumn(name = "cus_id")
    private Customers customer;

    @Column(name = "total_price")
    private Double totalPrice;
    
    @Column(name = "status")
    private String status;

    @OneToMany(mappedBy = "order", fetch = FetchType.EAGER)
    private List<Order_Details> orderDetails;
    
    //Constructor

    public Orders(Date orderDate, Customers customer, Double totalPrice) {
		super();
		this.orderDate = orderDate;
		this.customer = customer;
		this.totalPrice = totalPrice;
	}
    
    
    public Orders() {
		super();
		// TODO Auto-generated constructor stub
	}


  //Thêm 2 biến để in cho dễ
    @Transient
    private String orderDay="";
    
    @Transient
    private String orderTime="";
    
    
    public String getOrderDay() {
		return orderDay;
	}

	public void setOrderDay(String orderDay) {
		this.orderDay = orderDay;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	// Constructors, getters, and setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Customers getCustomer() {
		return customer;
	}

	public void setCustomer(Customers customer) {
		this.customer = customer;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public List<Order_Details> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<Order_Details> orderDetails) {
		this.orderDetails = orderDetails;
	}

    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	// Phương thức để thiết lập orderDay và orderTime cho mỗi đơn hàng trong orderList
    public static void setOrderDayAndTime(List<Orders> orderList) {
        SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");

        for (Orders order : orderList) {
            // Thiết lập orderDay từ orderDate
            if (order.getOrderDate() != null) {
                String orderDay = dateFormatter.format(order.getOrderDate());
                order.setOrderDay(orderDay);
            }

            // Thiết lập orderTime từ orderDate
            if (order.getOrderDate() != null) {
                String orderTime = timeFormatter.format(order.getOrderDate());
                order.setOrderTime(orderTime);
            }
        }
    }
    
}
