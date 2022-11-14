package main;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.TreeMap;
import java.util.Date;

/*GRASP
Jest to Ekspert zajmujący się wykonywaniem żądań użytkownika
Powiązania z:
-Invoice
-StabdardOutput
*/
public final class App
{
    private App()
    {}

    public static void main( final String[] args )
    {
        BufferedReader in = new BufferedReader( new InputStreamReader( System.in ) );
        TreeMap<Integer, Invoice> invoices = new TreeMap<Integer, Invoice>();

        boolean isUpRunning = true;

        while ( isUpRunning )
        {
            System.out.print(   "1: Browse invoices\n"
                               +"2: Create new invoice\n"
                               +"3: End\n"
                               +"Your choice: " );
            int c = readInt( in );

            final int browse = 1;
            final int create = 2;
            final int end = 3;

            switch ( c )
            {
                case browse:

                    if ( invoices.isEmpty() )
                    {
                        System.out.println( "There is no invoice to browse" );
                        break;
                    }

                    System.out.println();
                    for ( Invoice i : invoices.values() )
                    {
                        System.out.println( i.getReferenceNumber() + ": from " + i.getSellerName() + " to "
                                          + i.getBuyerName() + " on " + i.getIssueDate().toString() );
                    }

                    System.out.print( "Your choice: " );
                    c = readInt( in );
                    System.out.println();

                    if ( invoices.containsKey( c ) )
                    {
                        invoices.get( c ).print( new StandardOutput() );
                    }
                    break;


                case create:

                    try {
                        System.out.print( "Reference number: " );
                        int referenceNumber = readInt( in );

                        System.out.print( "Seller name: " );
                        String sellerName = in.readLine();

                        System.out.print( "Seller addres: " );
                        String sellerAddres = in.readLine();

                        System.out.print( "Seller e-mail: " );
                        String sellerEmail = in.readLine();

                        System.out.print( "Buyer name: " );
                        String buyerName = in.readLine();

                        System.out.print( "Buyer addres: " );
                        String buyerAddres = in.readLine();

                        System.out.print( "Buyer e-mail: " );
                        String buyerEmail = in.readLine();

                        System.out.print( "Issue date: " );
                        Date issueDate = readDate( in );

                        System.out.print( "Payment due date: " );
                        Date paymentDueDate = readDate( in );

                        System.out.print( "Delivery date: " );
                        Date delivDate = readDate( in );

                        invoices.put( referenceNumber, new Invoice( sellerName, sellerAddres, sellerEmail,
                                                        buyerName, buyerAddres, buyerEmail,
                                                        issueDate, paymentDueDate, delivDate, referenceNumber ) );

                        boolean isAddingNewElements = true;

                        while ( isAddingNewElements )
                        {
                            System.out.print( "1: Add new element\n"
                                    + "2: End\n"
                                    + "Your choice: " );
                            c = readInt( in );

                            final int add = 1;
                            final int end2 = 2;

                            switch ( c )
                            {
                                case add:
                                    System.out.print( "Description: " );
                                    String description = in.readLine();

                                    System.out.print( "Quantity: " );
                                    int quantity = readInt( in );

                                    System.out.print( "unit value: " );
                                    int unitValue = readInt( in );

                                    invoices.get( referenceNumber ).addElement( description, quantity, unitValue );

                                    break;

                                case end2:

                                    isAddingNewElements = false;
                                    break;

                                default:
                            }

                        }
                    }
                    catch ( Exception e )
                    {
                        e.printStackTrace();
                    }
                    break;

                case end:

                    isUpRunning = false;
                    break;

                default:
            }
        }
    }

    public static int readInt( final BufferedReader in )
    {
        boolean check;
        int i = 0;
        do
        {
            check = true;
            try{
                i = Integer.parseInt( in.readLine() );
            }
            catch ( Exception e )
            {
                System.err.println( "Input error - Invalid value for an int." );
                System.out.print( "Reinsert: " );
                check = false;
            }
        } while ( !check );
        return i;
    }

    public static Date readDate( final BufferedReader in )
    {
        SimpleDateFormat formatter = new SimpleDateFormat( "dd-MM-yyyy" );
        boolean check;
        Date result = new Date();
        do
        {
            check = true;
            try{
                result = formatter.parse( in.readLine() );
            }
            catch ( Exception e )
            {
                System.err.println( "Input error - Invalid value for an date, format: dd-MM-yyyy" );
                System.out.print( "Reinsert: " );
                check = false;
            }
        } while ( !check );
        return result;
    }
}
