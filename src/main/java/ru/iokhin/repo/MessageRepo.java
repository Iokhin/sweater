package ru.iokhin.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.iokhin.domain.Message;

import java.util.List;

public interface MessageRepo extends JpaRepository<Message, String> {

    List<Message> findAllByTag(String tag);

}
