package ru.iokhin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import ru.iokhin.domain.User;
import ru.iokhin.domain.dto.RecaptchaResponseDto;
import ru.iokhin.service.MailService;
import ru.iokhin.service.UserService;
import ru.iokhin.util.ControllerUtil;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    public static final String RECAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Autowired
    private MailService mailService;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String recaptchaSecret;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String userAdd(@RequestParam(name = "password2") String passwordConfirm,
                          @RequestParam("g-recaptcha-response") String recaptchaResponse,
                          @Valid User user, BindingResult bindingResult, Model model) {
        String resultUrl = String.format(RECAPTCHA_URL, recaptchaSecret, recaptchaResponse);
        RecaptchaResponseDto response = restTemplate.postForObject(resultUrl, Collections.emptyList(),
                RecaptchaResponseDto.class);
        if (!response.isSuccess()) {
            model.addAttribute("recaptchaError", "Fill the captcha");
        }
        boolean isPasswordConfirmEmpty = StringUtils.isEmpty(passwordConfirm);
        if (isPasswordConfirmEmpty) {
            model.addAttribute("password2Error", "Password confirmation can't be empty");
        }
        if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
            model.addAttribute("passwordError", "Passwords don't match");
            return "registration";
        }
        if (bindingResult.hasErrors() || isPasswordConfirmEmpty || !response.isSuccess()) {
            Map<String, String> errors = ControllerUtil.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "registration";
        }
        if (!userService.addUser(user)) {
            model.addAttribute("usernameError2", "Username already exists");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.active(code);
        if (isActivated) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "User successfully activated");
        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Activation code is not found!");
        }
        return "login";
    }
}
