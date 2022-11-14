package main;

/*GRASP
Odpowiedzialność: Przochowuje informacje jednej osoby
*/
public final class PersonalInfo
{
    private String name;
    private String addres;
    private String email;

    public String getName()
    {
        return name;
    }

    public String getAddres()
    {
        return addres;
    }

    public String getEmail()
    {
        return email;
    }

    public PersonalInfo( final String pName, final String pAddres, final String pEmail )
    {
        name = pName;
        addres = pAddres;
        email = pEmail;
    }
}
