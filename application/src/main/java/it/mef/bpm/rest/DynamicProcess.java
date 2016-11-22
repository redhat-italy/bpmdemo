package it.mef.bpm.rest;

import org.jbpm.bpmn2.xml.XmlBPMNProcessDumper;
import org.jbpm.ruleflow.core.RuleFlowProcess;
import org.jbpm.ruleflow.core.RuleFlowProcessFactory;
import org.kie.api.KieServices;
import org.kie.api.builder.KieFileSystem;
import org.kie.api.builder.ReleaseId;
import org.kie.api.io.Resource;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.Logger;


@Path("/dynamic")
public class DynamicProcess {
    private static final Logger logger = Logger.getLogger("it.mef.bpm");
    public final static String GROUPID = "it.mef.bpm";
    public final static String ARTIFACT = "assets";
    public final static String VERSION = "1.0-SNAPSHOT";
    public final static String ID = "remote.test";
    public final static String NAME = "test";

    @GET
    public String getInfo() {
        return "Service to access core KIE API - ver. 1.0-SNAPSHOT";
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/build")
    public Response buildAndRun(@QueryParam("review") boolean addReview) {
        logger.info("=== [Dynamic Process] creating process...");
        RuleFlowProcess process = createProcess(addReview);
        boolean result = executeProcess(process);
        return Response.status(Response.Status.OK).entity(result ? "OK" : "ERR").build();
    }

    private boolean executeProcess(RuleFlowProcess process) {
        logger.info("=== [Dynamic Process] building process...");
        KieServices ks = KieServices.Factory.get();
        KieFileSystem kfs = ks.newKieFileSystem();
        Resource resource = ks.getResources().newByteArrayResource(XmlBPMNProcessDumper.INSTANCE.dump(process).getBytes());
        resource.setSourcePath(NAME + ".bpmn2");
        kfs.write(resource);
        ReleaseId releaseId = ks.newReleaseId(GROUPID, ARTIFACT, VERSION);
        kfs.generateAndWritePomXML(releaseId);
        ks.newKieBuilder(kfs).buildAll();
        logger.info("=== [Dynamic Process] running process...");
        ks.newKieContainer(releaseId).newKieSession().startProcess(ID);
        return true;
    }

    private RuleFlowProcess createProcess(boolean addReview) {
        RuleFlowProcessFactory factory = RuleFlowProcessFactory.createProcess(ID);
        factory.name(NAME)
                .packageName(GROUPID).version(VERSION)
                .startNode(1).name("Start").done()
                .actionNode(20).name("Audit").action("java", "System.out.println(\"=== [Dynamic Process] ===> AUDIT service\");").done();

        if (addReview) {
            factory.actionNode(30).name("Review").action("java","System.out.println(\"=== [Dynamic Process] ===> REVIEW service\");").done();
        }

        factory.endNode(100).name("Exit").done();

        factory.connection(1, 20);

        if (addReview){
            factory.connection(20,30).connection(30,100);
        } else {
            factory.connection(20,100);
        }

        return factory.validate().getProcess();
    }

}