package ru.iokhin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.iokhin.domain.Message;
import ru.iokhin.domain.User;
import ru.iokhin.repo.MessageRepo;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
public class MainController {

    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String path;

    @GetMapping("/")
    public String greeting(@RequestParam(name = "name", required = false, defaultValue = "World") String name,
                           Model model) {
        model.addAttribute("name", name);
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false) String tag, Model model) {
        if (tag == null || tag.trim().isEmpty()) {
            List<Message> allMessages = messageRepo.findAll();
            model.addAttribute("messages", allMessages);
            model.addAttribute("filter", "");
            return "main";
        }
        List<Message> filteredMessages = messageRepo.findAllByTag(tag);
        model.addAttribute("messages", filteredMessages);
        model.addAttribute("filter", tag);
        return "main";
    }

    @PostMapping("/message-add")
    public String messageAdd(@AuthenticationPrincipal User user,
                             @RequestParam String text,
                             @RequestParam String tag,
                             @RequestParam("file") MultipartFile file,
                             Model model) throws IOException {
        Message message = new Message();
        message.setUser(user);
        message.setTag(tag);
        message.setText(text);
        if (file != null) {
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdir())
                    System.out.println("GOOD");
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(path + "/" + resultFilename));
            message.setFilename(resultFilename);
        }
        messageRepo.save(message);
        model.addAttribute("messages", messageRepo.findAll());
        return "redirect:/main";
    }

}

