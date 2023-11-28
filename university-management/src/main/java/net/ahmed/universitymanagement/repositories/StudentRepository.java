package net.ahmed.universitymanagement.repositories;

import net.ahmed.universitymanagement.entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, String> {
}
