package net.ahmed.universitymanagement.repositories;

import net.ahmed.universitymanagement.entities.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepartmentRepository extends JpaRepository<Department, String> {
}
