package albert;
import static org.junit.Assert.*;

import org.junit.Test;

public class CounterTest {
    @Test
    public void CreateCorrectNumbersOfSheeps()
    {
        int amountOfSheeps = 13;
        boolean isThereCorrectNumber = false;
        Counter counter = new Counter(amountOfSheeps);
        try
        {
            for( int i = 0; i < amountOfSheeps; i++ )
            {
                counter.nextSheep();
            }
        }
        catch( Exception e )
        {
            assertTrue( false );
        }

        try
        {
            counter.nextSheep();
        }
        catch( Exception e )
        {
            isThereCorrectNumber = true;
        }

        assertTrue( isThereCorrectNumber );
    }
}
