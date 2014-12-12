package hello;

import java.util.concurrent.atomic.AtomicLong;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

@RestController
public class GreetingController {
    private KieContainer kieContainer = null;

    public GreetingController() {
        KieServices ks = KieServices.Factory.get();
        kieContainer = ks.getKieClasspathContainer();
    }

    public void runRules(Greeting g) {
        KieSession kieSession = kieContainer.newKieSession("ksession-rules");
        kieSession.insert(g);
        kieSession.fireAllRules();
        kieSession.dispose();
    }

    @RequestMapping("/greeting")
    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name, @RequestParam(value="language", defaultValue="english") String language) {
        Greeting g = new Greeting(1, name, language);
        runRules(g);

        return g;
    }
}