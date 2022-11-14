package main;

import java.util.Date;
import java.util.Vector;

/*GRASP
Odpowiedzialność: Przochowuje informacje dotyczące jednej faktury
Powiązania z:
-PersonalInfo
-InvoiceElement
-Output (interfejs)
*/
public final class Invoice
{
    private PersonalInfo seller;
    private PersonalInfo buyer;

    private Date issueDate;
    private Date paymentDueDate;
    private Date deliveryDate;

    private int referenceNumber;

    public Vector<InvoiceElement> elements;

    public String getSellerName()
    {
        return seller.getName();
    }

    public String getSellerEmail()
    {
        return seller.getEmail();
    }

    public String getSellerAddres()
    {
        return seller.getAddres();
    }

    public String getBuyerName()
    {
        return buyer.getName();
    }

    public String getBuyerEmail()
    {
        return buyer.getEmail();
    }

    public String getBuyerAddres()
    {
        return buyer.getAddres();
    }

    public Date getIssueDate()
    {
        return issueDate;
    }

    public Date getPaymentDueDate()
    {
        return paymentDueDate;
    }

    public Date getDeliveryDate()
    {
        return deliveryDate;
    }

    public int getReferenceNumber()
    {
        return referenceNumber;
    }

    public void addElement( final String description, final int quantity, final int unitValue )
    {
        elements.add( new InvoiceElement( description, quantity, unitValue ) );
    }

    public String getNthElementDescription( final int n )
    {
        return elements.get( n ).getDescription();
    }

    public int getNthElementQuantity( final int n )
    {
        return elements.get( n ).getQuantity();
    }

    public int getNthElementUnitValue( final int n )
    {
        return elements.get( n ).getUnitValue();
    }

    public int getNthElementAmount( final int n )
    {
        return elements.get( n ).getUnitValue() * elements.get( n ).getQuantity();
    }

    public int getNumberOfElements()
    {
        return elements.size();
    }

    public Invoice( final String sellerName, final String sellerAddres, final String sellerEmail,
    final String buyerName, final String buyerAddres, final String buyerEmail,
    final Date pIssueDate, final Date pPaymentDueDate, final Date pDeliveryDate, final int pReferenceNumber )
    {
        seller = new PersonalInfo( sellerName, sellerAddres, sellerEmail );
        buyer = new PersonalInfo( buyerName, buyerAddres, buyerEmail );
        issueDate = pIssueDate;
        paymentDueDate = pPaymentDueDate;
        deliveryDate = pDeliveryDate;
        referenceNumber = pReferenceNumber;
        elements = new Vector<InvoiceElement>();
    }

    public void print( final Output out )
    {
        out.print( this );
    }
}
