package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name = "Order_Details")
public class Order_Details {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "food_id")
    private Foods food;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Orders order;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "price")
    private Double price;

    // Constructors, getters, and setters
    
	public Integer getId() {
		return id;
	}

	public Order_Details(Foods food, Orders order, Integer quantity, Double price) {
		super();
		this.food = food;
		this.order = order;
		this.quantity = quantity;
		this.price = price;
	}

	public Order_Details() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Foods getFood() {
		return food;
	}

	public void setFood(Foods food) {
		this.food = food;
	}

	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return food.getId() + " " + quantity + " " + price;
	}
}
