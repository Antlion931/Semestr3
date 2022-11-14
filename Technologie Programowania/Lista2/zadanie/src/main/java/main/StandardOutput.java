package main;

/*GRASP
Odpowiedzialność: Stworzenie standardowego sposobu na wypisywanie informacji do terminala
Powiązany z:
-Output
-Invoice
*/
public final class StandardOutput implements Output
{
    public void print( final Invoice invoice )
    {
        System.out.println(
                "BILL FROM" + "\n"
               + invoice.getSellerName() + "\n"
               + invoice.getSellerAddres() + "\n"
               + invoice.getSellerEmail() + "\n"
               + "\n"
               + "BILL TO \n"
               + invoice.getBuyerName() + "\n"
               + invoice.getBuyerAddres() + "\n"
               + invoice.getBuyerEmail()  + "\n"
               + "\n"
               + "Invoide ID: " + invoice.getReferenceNumber()  + "\n"
               + "Issue date: " + invoice.getIssueDate().toString()  + "\n"
               + "Payment due date: " + invoice.getPaymentDueDate().toString()  + "\n"
               + "Delivery date: " + invoice.getDeliveryDate().toString() + "\n"
               + "\n"
               + "DESCRIPTION\tQTY\tUNIT PRICE\tAMOUNT" );

        for ( int i = 0; i < invoice.getNumberOfElements(); i++ ) {
            System.out.println( invoice.getNthElementDescription( i ) + "\t" + invoice.getNthElementQuantity( i )
            + "\t" + invoice.getNthElementUnitValue( i ) + "\t" + invoice.getNthElementAmount( i ) );
        }
    }
}
