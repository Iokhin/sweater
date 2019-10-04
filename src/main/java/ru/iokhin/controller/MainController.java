package ru.iokhin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.iokhin.domain.Message;
import ru.iokhin.domain.User;
import ru.iokhin.repo.MessageRepo;
import ru.iokhin.util.ControllerUtil;

import javax.persistence.EntityManager;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class MainController {

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private EntityManager em;

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

    @PostMapping("/main")
    public String messageAdd(@AuthenticationPrincipal User user,
                             @Valid Message message,
                             BindingResult bindingResult,
                             Model model,
                             @RequestParam("file") MultipartFile file) throws IOException {
        message.setUser(user);
        message.setId(UUID.randomUUID().toString());
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtil.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("message", message);
        } else {
            fileSave(message, file);
            model.addAttribute("message", null);
            messageRepo.save(message);
        }
        model.addAttribute("messages", messageRepo.findAll());
        return "main";
    }

    private void fileSave(@Valid Message message, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
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
    }

    @GetMapping("/user-messages/{user}")
    public String userMessages(@AuthenticationPrincipal User currentUser,
                               @PathVariable User user, Model model,
                               @RequestParam(required = false) Message message) {
        Set<Message> messages = user.getMessages();
        model.addAttribute("messages", messages);
        model.addAttribute("message", message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        return "userMessages";
    }

    @PostMapping("/user-messages/{user}")
    public String updateMessage(@AuthenticationPrincipal User currentUser, @PathVariable User user,
                                @RequestParam(required = false) MultipartFile file,
                                @RequestParam String text, @RequestParam String tag,
                                @RequestParam("id") String messageId, Model model) throws IOException {
        Set<Message> messages = user.getMessages();
        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
//        model.addAttribute("user", user);
        Message messageToUpdate = messageRepo.findById(messageId).orElse(null);
        if (messageToUpdate == null) {
            model.addAttribute("messageError", "No message to edit was chosen");
            return "userMessages";
        }
        if (currentUser.equals(user)) {
            boolean isTextEmpty = StringUtils.isEmpty(text);
            if (isTextEmpty) {
                model.addAttribute("textError", "Text can't be empty");
            }
            boolean isTagEmpty = StringUtils.isEmpty(tag);
            if (isTagEmpty) {
                model.addAttribute("tagError", "Tag can't be empty");
            }
            model.addAttribute("message", messageToUpdate);
            if (isTagEmpty || isTextEmpty) {
                model.addAttribute("showEditor", true);
                return "userMessages";
            }
            messageToUpdate.setText(text);
            messageToUpdate.setTag(tag);
            fileSave(messageToUpdate, file);
            messageRepo.save(messageToUpdate);
            model.addAttribute("messageSuccess", "Message was updated");
            model.addAttribute("message", messageToUpdate);
        } else {
            model.addAttribute("messageError", "Error while updating the message");
        }
        return "userMessages";
    }

}

