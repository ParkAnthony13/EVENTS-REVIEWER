package parkanthony.events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import parkanthony.events.models.State;

public interface StateRepository extends CrudRepository<State, Long> {
	List<State> findAll();
}
