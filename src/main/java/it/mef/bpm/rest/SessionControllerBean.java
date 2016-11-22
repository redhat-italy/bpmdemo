package it.mef.bpm.rest;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

public class SessionControllerBean implements SessionController {
    public Response logout(@Context HttpServletRequest req) {
        req.getSession().invalidate();
        return Response.status(Response.Status.OK).build();
    }
}
