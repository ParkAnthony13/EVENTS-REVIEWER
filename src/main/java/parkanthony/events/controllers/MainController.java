package parkanthony.events.controllers;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import parkanthony.events.models.Event;
import parkanthony.events.models.Message;
import parkanthony.events.models.State;
import parkanthony.events.models.User;
import parkanthony.events.repositories.EventRepository;
import parkanthony.events.services.EventService;
import parkanthony.events.services.MessageService;
import parkanthony.events.services.StateService;
import parkanthony.events.services.UserService;
import parkanthony.events.validator.UserValidator;

@Controller
public class MainController {
	// Service dependency injection
	private final UserService userService;
	private final UserValidator userValidator;
	private final StateService stateService;
	private final EventService eventService;
	private final MessageService messageService;
	//constructor this service inside
	public MainController (UserService userService,
			UserValidator userValidator,
			StateService stateService,
			EventService eventService,
			MessageService messageService
			) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.stateService = stateService;
		this.eventService = eventService;
		this.messageService = messageService;
	}
	
	// Routes
// ============================Landing Login Reg ===================//
	@RequestMapping("/")
	public String Landing(@ModelAttribute("user") User user,Model model) {
		List<State> listOfStates = stateService.allItems();
		model.addAttribute("listOfStates", listOfStates);
		return "/events/loginRegPage.jsp";
	}
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session,RedirectAttributes redirectAttributes) {
	// if result has errors, return the registration page (don't worry about validations just now)
		userValidator.validate(user, result);
		if (userService.findByEmail(user.getEmail())!=null) {
//			result.rejectValue("email", "Unique", "This email is already in use!");
//			redirectAttributes.addFlashAttribute("error","Invalid Email/Password");
//			return "redirect:/registration";
		}
		if(result.hasErrors()) {
			return "/events/loginRegPage.jsp";
		} else {
			// else, save the user in the database, save the user id in session, and redirect them to the /home route
			Long id = userService.registerUser(user).getId();
			session.setAttribute("userSesh", id);
			return "redirect:/events";
		}
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session,RedirectAttributes redirectAttributes) {
	// if the user is authenticated, save their user id in session
		if(userService.authenticateUser(email, password)) {
			User user = userService.findByEmail(email);
			Long id = user.getId();
			session.setAttribute("userSesh", id);
			return "redirect:/events";
		} else {
			// else, add error messages and return the login page
			redirectAttributes.addFlashAttribute("errorLogin","Invalid Email/Password");
			return "redirect:/";
		}
	}
	// ============================LOGGED IN ACTIVITIES ===================//
	// LOGGED IN SESSION EXISTS
	@RequestMapping("/events")
	public String allEventsPage(HttpSession session, Model model, @ModelAttribute("event") Event event) {
		// if user not logged in
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		Long id = (Long) session.getAttribute("userSesh");
		User user = userService.findUserById(id);
		List<Event> events = eventService.findAll();
		List<State> listOfStates = stateService.allItems();
		model.addAttribute("listOfStates", listOfStates);
		model.addAttribute("user", user);
		model.addAttribute("events",events);
		return "/events/events.jsp";
	}
	@RequestMapping(value="/events",method=RequestMethod.POST)
	public String postEvent(@Valid @ModelAttribute("event") Event event,
			BindingResult result,
			HttpSession session,Model model) {
		if (result.hasErrors()) {
			Long id = (Long) session.getAttribute("userSesh");
			User user = userService.findUserById(id);
			List<Event> events = eventService.findAll();
			List<State> listOfStates = stateService.allItems();
			model.addAttribute("listOfStates", listOfStates);
			model.addAttribute("user", user);
			model.addAttribute("events",events);
			return "/events/events.jsp";
		} else {
			User user = userService.findUserById((Long)session.getAttribute("userSesh"));
			event.setHost(user);
			eventService.createItem(event);
		}
		return "redirect:/events";
	}

	@RequestMapping("/events/{id}")
	public String viewEvent(@PathVariable("id") Long id,
			HttpSession session,Model model) {
		// if user not logged in
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		Event event = eventService.findById(id);
		model.addAttribute("event", event);
		List<Message> log = event.getMessages();
		model.addAttribute("log",log);
		User user = userService.findUserById((Long) session.getAttribute("userSesh"));
		model.addAttribute("user", user);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		String date = sdf.format(event.getDate());
		model.addAttribute("eventDate",date);
		
		return "/events/showEvent.jsp";
	}
//==============================ADDING MESSAGES TO MESSAGE BOARD=========================//
	@RequestMapping(value="/messages/{id}",method=RequestMethod.POST)
	public String addMessageToEvent(Model model,@RequestParam("message") String message,
			RedirectAttributes redirectAttributes,HttpSession session,
			@PathVariable("id") Long id) {
		if(message.length()==0 || message.equals("")) {
			redirectAttributes.addFlashAttribute("error","Message Required");
			return "redirect:/events/"+id;
		} else {
			Message msg = new Message();
			msg.setMessage(message);
			User user = userService.findUserById((Long) session.getAttribute("userSesh"));
			msg.setName(user.getFirstName()+" "+user.getLastName());
			Event event = eventService.findById(id);
			msg.setEvent(event);
			msg = messageService.createItem(msg);
			
			return "redirect:/events/"+id;
		}
	}
//==============================EDIT EVENTS======================================//
	@RequestMapping("/events/{id}/edit")
	public String editEvent(Model model,@PathVariable("id") Long id,HttpSession session) {
		// if user not logged in
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		Event event = eventService.findById(id);
		model.addAttribute("event",event);
		List<State> listOfStates = stateService.allItems();
		model.addAttribute("listOfStates", listOfStates);
		return "/events/editEvent.jsp";
	}
	@RequestMapping(value="/events/{id}/edit",method=RequestMethod.PUT)
	public String saveEdittedEvent(@Valid @ModelAttribute("event") Event eventt,
			BindingResult result, @PathVariable("id") Long id,HttpSession session,
			Model model,RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			List<State> listOfStates = stateService.allItems();
			model.addAttribute("listOfStates", listOfStates);
			return "/events/editEvent.jsp";
		} else {
//			event.setId(id);
//			User user = userService.findUserById((Long) session.getAttribute("userSesh"));
//			event.setHost(user);
			eventService.updateItem(eventt);
			return "redirect:/events";
		}
	}
	//=========================USERS JOINING AND QUITING EVENTS==========================//
	@RequestMapping("/events/join/{id}")
	public String attendAnEvent(@PathVariable("id")Long id,HttpSession session) {
		// if user not logged in
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		Event event = eventService.findById(id);
		User user = userService.findUserById((Long) session.getAttribute("userSesh"));
		event.getUsers().add(user);
		eventService.updateItem(event);
		return "redirect:/events/";
	}
	@RequestMapping("/cancel/{id}")
	public String cancelEventJoin(@PathVariable("id")Long id,HttpSession session) {
		// if user not logged in
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		Event event = eventService.findById(id);
		User user = userService.findUserById((Long) session.getAttribute("userSesh"));

		event.getUsers().remove(user);

		eventService.updateItem(event);
		return "redirect:/events/";
	}
	
	@RequestMapping(value="/delete/{id}",method=RequestMethod.DELETE)
	public String deleteEvent(@PathVariable("id") Long id,HttpSession session) {
		if (session.getAttribute("userSesh")==null) {
			return "redirect:/";
		}
		eventService.deleteItem(id);
		return "redirect:/events";
	}
	// ============================LOGGED OUT===================//
	// LOG OUT BUTTON
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	// invalidate session
		session.invalidate();
	// redirect to login page
		return "redirect:/";
	}
	
	
}
