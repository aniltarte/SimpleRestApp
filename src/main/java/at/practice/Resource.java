package at.practice;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("rest")
public class Resource {

    @GET
    @Path("ping")
    public String ping() {
        return "Its running!";
    }
}
