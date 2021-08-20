package parkanthony.events.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import parkanthony.events.models.User;
import parkanthony.events.services.UserService;

@Component
public class UserValidator implements Validator {
	private final UserService userService;
	
	
	public UserValidator(UserService userService) {
		this.userService = userService;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		
		if (!user.getPasswordConfirmation().equals(user.getPassword())) {
			errors.rejectValue("passwordConfirmation","Match");
		}
		
		if (userService.findByEmail(user.getEmail())!=null) {
//			redirectAttributes.addFlashAttribute("error","Invalid Email/Password");
			errors.rejectValue("email", "EmailUnique");
//			return "redirect:/registration";
		}

	}

}

