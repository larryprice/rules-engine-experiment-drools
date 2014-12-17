package hello;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.drools.compiler.kproject.ReleaseIdImpl;
import org.drools.core.io.impl.UrlResource;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.StatelessKieSession;
import org.kie.api.builder.KieScanner;
import org.kie.api.builder.KieModule;
import org.kie.internal.io.ResourceFactory;

import java.io.InputStream;
import javax.servlet.http.HttpServletRequest;

@RestController
public class SalesController {
    private KieScanner scanner = null;
    private KieContainer kieContainer = null;

    private void loadKie(String urlBase) {
        if (kieContainer == null) {
            String url = urlBase + "/workbench/maven2/com/sep/test/greeting/1.0/greeting-1.0.jar";

            KieServices ks = KieServices.Factory.get();
            UrlResource urlResource = (UrlResource) ks.getResources().newUrlResource(url);

            try {
                InputStream is = urlResource.getInputStream();
                KieModule kModule = ks.getRepository().addKieModule(ks.getResources().newInputStreamResource(is));
                System.out.println(kModule.getReleaseId());
                kieContainer = ks.newKieContainer(new ReleaseIdImpl("com.sep.test", "greeting", "LATEST"));

                scanner = ks.newKieScanner(kieContainer);
            } catch(Exception e) {
                System.out.println("Exception thrown while constructing InputStream");
                System.out.println(e.getMessage());
            }
        }
    }

    private void runRules(Sales g, String baseUrl) {
        loadKie(baseUrl);

        scanner.scanNow(); // update resource

        StatelessKieSession kieSession = kieContainer.newStatelessKieSession();
        kieSession.execute(g);
    }

    private String getBaseURL(HttpServletRequest request) {
        String url = request.getRequestURL().toString();
        return url.substring(0, url.length() - request.getRequestURI().length());
    }

    @RequestMapping("/sales/data")
    public Sales salesData(@RequestParam(value="role", defaultValue="producer") String role,
                             @RequestParam(value="channel", defaultValue="retail") String channel,
                             @RequestParam(value="status", defaultValue="true") String isActive,
                             HttpServletRequest request) {
        Sales s = new Sales(role, channel, isActive.equals("true"));
        runRules(s, getBaseURL(request));

        return s;
    }
}