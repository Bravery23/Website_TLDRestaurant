package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name = "Admins")
public class Admins {
    @Id
    @Column(name = "username")
    private String username;

    @Column(name = "number")
    private String number;

    @Column(name = "name")
    private String name;

    @Column(name = "password")
    private String password;

    // Getters and setters
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


    
}
