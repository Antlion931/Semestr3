package main;

import static org.junit.Assert.assertTrue;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.ByteArrayInputStream;
import java.io.*;
import org.junit.Test;

public class AppTest 
{
    @Test
    public void int_readed_correctly()
    {
        String test = new String("12\n");
        System.setIn(new ByteArrayInputStream( test.getBytes()));
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        int x = App.readInt(in);
        assertTrue(x == 12);
    }

    @Test
    public void int_readed_error_handle()
    {
        String test = new String("we\n12\n");
        System.setIn(new ByteArrayInputStream( test.getBytes()));
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        int x = App.readInt(in);
        assertTrue(x == 12);
    }

    @Test
    public void date_readed_correctly() throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        String test = new String("12-12-2022\n");
        System.setIn(new ByteArrayInputStream( test.getBytes()));
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        Date x = App.readDate(in);
        assertTrue(x.compareTo(formatter.parse("12-12-2022")) == 0);
    }

    @Test
    public void date_readed_error_handle() throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        String test = new String("qweweq\n12-12-2022\n");
        System.setIn(new ByteArrayInputStream( test.getBytes()));
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        Date x = App.readDate(in);
        assertTrue(x.compareTo(formatter.parse("12-12-2022")) == 0);
    }

    @Test
    public void is_add_element_correct()
    {
        String description = "Some books";
        int quantity = 14;
        int unitValue = 67;

        Invoice invoice = new Invoice(null, null, null, null, null, null, null, null, null, 0);
        invoice.addElement(description, 0, 0);
        invoice.addElement(null, quantity, 0);
        invoice.addElement(null, 0, unitValue);


        assertTrue( description == invoice.getNthElementDescription(0) &&
                    quantity == invoice.getNthElementQuantity(1) &&
                    unitValue == invoice.getNthElementUnitValue(2));
        
    }
    
    @Test
    public void is_amount_correct()
    {
        int quantity = 14;
        int unitValue = 67;

        Invoice invoice = new Invoice(null, null, null, null, null, null, null, null, null, 0);
        invoice.addElement(null, quantity, unitValue);
        assertTrue(quantity*unitValue == invoice.getNthElementAmount(0));
    }
}
