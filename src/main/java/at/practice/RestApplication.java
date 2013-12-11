package at.practice;


import org.glassfish.jersey.jackson.JacksonFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.Path;
import javax.ws.rs.core.Application;

@ApplicationPath("/")
public class RestApplication extends ResourceConfig {

    public RestApplication() {
        AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(SpringConfiguration.class);

        register(JacksonFeature.class);

        for (Object o : ctx.getBeansWithAnnotation(Path.class).values()) {
            register(o);
        }
    }
}
