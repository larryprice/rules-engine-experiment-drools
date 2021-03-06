package hello;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HelloController {
  @RequestMapping(value="/greeting", method=RequestMethod.GET)
  public String index(Model model) {
    return "hello";
  }
  
  @RequestMapping(value="/", method=RequestMethod.GET)
  public String sales(Model model) {
    return "sales";
  }
}