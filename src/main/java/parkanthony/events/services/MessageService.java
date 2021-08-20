package parkanthony.events.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import parkanthony.events.models.Message;
import parkanthony.events.repositories.MessageRepository;

@Service
public class MessageService {
	private final MessageRepository messageRepository;
	
	public MessageService(MessageRepository messageRepository) {
		this.messageRepository = messageRepository;
	}
	
	public List<Message> findAll(){
		return messageRepository.findAll();
	}
	
	public Message findById(Long id) {
		Optional<Message> optionalItem = messageRepository.findById(id);
		if (optionalItem != null) {
			return optionalItem.get();
		} else {
			return null;
		}
	}
	
	public Message createItem(Message b) {
		return messageRepository.save(b);
	}
}
