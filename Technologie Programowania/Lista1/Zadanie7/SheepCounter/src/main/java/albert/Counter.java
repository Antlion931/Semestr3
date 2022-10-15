package albert;
import java.util.ArrayList;
import java.util.List;

public final class Counter
{
    private List<Sheep> sheeps;
    private int index;

    public Counter( final int howMany )
    {
        sheeps = new ArrayList<Sheep>();
        index = 0;
        for( int i = 0; i < howMany; i++ )
        {
            sheeps.add( new Sheep() );
        }
    }

    public String whatSheepIsNow()
    {
        return sheeps.get( index ).name + " is " + Integer.toString( index + 1 ) + ". sheep";
    }

    public boolean areThereMoreSheeps()
    {
        if( index < sheeps.size() )
        {
            return true;
        }
        return false;
    }

    public void nextSheep() throws CounterExeption
    {
        if( !areThereMoreSheeps() )
        {
            throw new CounterExeption( "There isn't next Sheep" );
        }
        index++;
    }
}
