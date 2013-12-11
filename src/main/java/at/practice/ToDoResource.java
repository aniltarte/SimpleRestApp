package at.practice;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.List;

@Component
@Path("todo")
public class ToDoResource {

    private ToDoRepository toDoRepository;

    @Autowired
    public ToDoResource(ToDoRepository toDoRepository) {
        this.toDoRepository = toDoRepository;
    }

    @GET
    public Response get() throws IOException {
        List<ToDo> toDos = toDoRepository.findAll();
        ObjectMapper mapper = new ObjectMapper();
        String response = mapper.writeValueAsString(toDos);

        return Response.ok(response, MediaType.APPLICATION_JSON_TYPE).build();
    }

}
