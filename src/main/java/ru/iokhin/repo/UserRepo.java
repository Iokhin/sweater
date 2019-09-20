package ru.iokhin.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.iokhin.domain.User;

public interface UserRepo extends JpaRepository<User, String> {
    User findByUsername(String username);
}
