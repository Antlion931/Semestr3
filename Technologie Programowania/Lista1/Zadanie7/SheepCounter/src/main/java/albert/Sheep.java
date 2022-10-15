package albert;
import com.github.javafaker.Faker;

public class Sheep
{
    public String name;

    public Sheep()
    {
        Faker faker = new Faker();
        name = faker.name().firstName();
    }
}
