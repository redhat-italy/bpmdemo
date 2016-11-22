package it.mef.bpm.rest;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/session")
public interface SessionController {
    @POST
    @Path("/logout")
    @Produces(MediaType.APPLICATION_JSON)
    Response logout(@Context HttpServletRequest req);
}
