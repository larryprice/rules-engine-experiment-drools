package hello;

import java.util.concurrent.atomic.AtomicLong;
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

@RestController
public class GreetingController {
    private KieScanner scanner = null;
    private KieContainer kieContainer = null;

    public GreetingController() {
        String url = "http://localhost:8088/workbench/maven2/com/sep/test/myProject/1.0/myProject-1.0.jar";

        KieServices ks = KieServices.Factory.get();
        UrlResource urlResource = (UrlResource) ks.getResources().newUrlResource(url);
        
        try {
            InputStream is = urlResource.getInputStream();
            KieModule kModule = ks.getRepository().addKieModule(ks.getResources().newInputStreamResource(is));
            System.out.println(kModule.getReleaseId());
            kieContainer = ks.newKieContainer(new ReleaseIdImpl("com.sep.test", "myProject", "LATEST"));

            scanner = ks.newKieScanner(kieContainer);
        } catch(Exception e) {
            System.out.println("Exception thrown while constructing InputStream");
            System.out.println(e.getMessage());
        }
    }

    public void runRules(Greeting g) {
        scanner.scanNow(); // update resource

        StatelessKieSession kieSession = kieContainer.newStatelessKieSession();
        kieSession.execute(g);
    }

    @RequestMapping("/greeting")
    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name, @RequestParam(value="language", defaultValue="english") String language) {
        Greeting g = new Greeting(1, name, language);
        runRules(g);

        return g;
    }
}