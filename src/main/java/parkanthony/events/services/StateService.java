package parkanthony.events.services;

import java.util.List;

import org.springframework.stereotype.Service;

import parkanthony.events.models.State;
import parkanthony.events.repositories.StateRepository;

@Service
public class StateService {
	private final StateRepository stateRepository;
	
	public StateService(StateRepository stateRepository) {
		this.stateRepository = stateRepository;
	}
	
	public List<State> allItems(){
		return stateRepository.findAll();
	}
}
