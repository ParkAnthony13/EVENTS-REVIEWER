package parkanthony.events.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import parkanthony.events.models.Event;
import parkanthony.events.repositories.EventRepository;

@Service
public class EventService {
	private final EventRepository eventRepository;
	
	public EventService(EventRepository eventRepository) {
		this.eventRepository = eventRepository;
	}
	
	public List<Event> findAll(){
		return eventRepository.findAll();
	}
	public Event createItem(Event b) {
		return eventRepository.save(b);
	}
	public Event updateItem(Event b) {
		return eventRepository.save(b);
	}
	public Event findById(Long id) {
		Optional<Event> optionalItem = eventRepository.findById(id);
		if (optionalItem.isPresent()) {
			return optionalItem.get();
		} else {
			return null;
		}
	}
	public void deleteItem(Long id) {
		eventRepository.deleteById(id);
	}
}
