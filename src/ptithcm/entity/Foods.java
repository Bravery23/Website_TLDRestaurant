package ptithcm.entity;

import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "Foods")
public class Foods {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "url")
    private String url;

    @Column(name = "price")
    private Double price;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Categories category;

    @OneToMany(mappedBy = "food", fetch = FetchType.EAGER)
    private List<Order_Details> orderDetails;

    // Constructors, getters, and setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public List<Order_Details> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<Order_Details> orderDetails) {
		this.orderDetails = orderDetails;
	}

    
}

