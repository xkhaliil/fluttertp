package net.ahmed.universitymanagement.repositories;

import net.ahmed.universitymanagement.entities.Class;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClassRepository extends JpaRepository<Class, String> {
}
