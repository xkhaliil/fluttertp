package net.ahmed.universitymanagement.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;

import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Class {
    @Id
    @UuidGenerator
    private String id;
    private String name;
    private int numberOfStudents;

    /*@ManyToOne
    @JsonBackReference
    @JsonIgnore
    private Department department;*/
    @ManyToOne
    private Department departmentSpace;

    @OneToMany(mappedBy = "classRoom")
    @JsonManagedReference
    @JsonIgnore
    private List<Student> students;
}
