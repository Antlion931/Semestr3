package albert;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public final class App
{
    public static void main( final String[] args )
    {
        int amountOfSheeps = getIntFromUser( "How many sheeps you want me to count:  " );
        int delay = getIntFromUser( "How long you want me to wait between counts:  " );

        Counter counter = new Counter( amountOfSheeps );

        while(counter.areThereMoreSheeps()){
            try
            {
                TimeUnit.SECONDS.sleep( delay );
                System.out.println( counter.whatSheepIsNow() );
                counter.nextSheep();
            }
            catch( Exception e )
            {
                System.out.println( e.getMessage() );
                System.exit( 1 );
            }
        }

        input.close();
    }

    private static Scanner input;

    private App()
    {
        input = new Scanner( System.in );
    }

    private static int getIntFromUser( final String question )
    {
        System.out.print( question );
        return input.nextInt();
    }
}
