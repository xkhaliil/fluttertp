
package net.ahmed.universitymanagement.repositories;

import net.ahmed.universitymanagement.entities.User;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Integer> {
    User findByEmailAndPassword(String email,String password);
}
