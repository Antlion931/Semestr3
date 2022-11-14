package main;

/*GRASP
Odpowiedzialność: Przochowuje informacje dotyczące jednego elementu z Faktury
*/
public final class InvoiceElement
{
    private String description;
    private int quantity;
    private int unitValue;

    public String getDescription()
    {
        return description;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public int getUnitValue()
    {
        return unitValue;
    }

    public InvoiceElement( final String pDescription, final int pQuantity, final int pUnitValue )
    {
        description = pDescription;
        quantity = pQuantity;
        unitValue = pUnitValue;
    }
}
