package at.practice;

import org.springframework.stereotype.Component;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Component
@Path("ping")
public class Resource {

    @GET
    public String ping() {
        return "Its running!";
    }
}
