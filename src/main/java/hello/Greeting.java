package hello;

public class Greeting {
    private final long id;
    private final String name;
    public final String language;
    private String content;

    public Greeting(long id, String name, String language) {
        this.id = id;
        this.name = name;
        this.content = "Hello, " + name + ".";
        this.language = language;
    }

    public long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String newGreeting) {
        this.content = newGreeting + ", " + name + ".";
    }
}