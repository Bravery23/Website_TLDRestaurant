package ptithcm.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "Custommers")
public class Customers {

    @Id
    @Column(name = "username")
    private String username;

    @Column(name = "number")
    private String number;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "balance")
    private Double balance;

    @OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
    private List<Comments> comments;

    @OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
    private List<Orders> orders;

    // Constructors, getters, and setters
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public List<Comments> getComments() {
		return comments;
	}

	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}

	public List<Orders> getOrders() {
		return orders;
	}

	public void setOrders(List<Orders> orders) {
		this.orders = orders;
	}
}

