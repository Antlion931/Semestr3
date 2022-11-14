package main;

/*GRASP
Odpowiedzialność: Stworzenie interfejsu do wypisywania informacji zawartych w Invoice
Powiązany z:
-Invoice
*/
public interface Output
{
    void print( Invoice invoice );
}
