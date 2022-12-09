package eu.jpereira.trainings.designpatterns.structural.facade;

import eu.jpereira.trainings.designpatterns.structural.facade.model.Book;
import eu.jpereira.trainings.designpatterns.structural.facade.model.DispatchReceipt;
import eu.jpereira.trainings.designpatterns.structural.facade.model.Order;
import eu.jpereira.trainings.designpatterns.structural.facade.service.BookDBService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.CustomerDBService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.CustomerNotificationService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.OrderingService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.WharehouseService;

public class DefaultBookStoreFacade implements BookstoreFacade{

    protected OrderingService os;
    protected BookDBService bookdb;
    protected CustomerDBService customerdb; 
    protected WharehouseService wh;

    public DefaultBookStoreFacade(OrderingService os, BookDBService bookdb, CustomerDBService customerdb, WharehouseService wh){
        this.os = os;
        this.bookdb = bookdb;
        this.customerdb = customerdb;
        this.wh = wh;
    }

    @Override
    public void placeOrder(String customerId, String isbn) {
        wh.dispatch(os.createOrder(customerdb.findCustomerById(customerId), bookdb.findBookByISBN(isbn)));
    }
}