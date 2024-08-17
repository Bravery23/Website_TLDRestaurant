package ptithcm.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "Catagories")
public class Categories {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
    private List<Foods> foods;

    //Getter, setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Foods> getFoods() {
		return foods;
	}

	public void setFoods(List<Foods> foods) {
		this.foods = foods;
	}
}