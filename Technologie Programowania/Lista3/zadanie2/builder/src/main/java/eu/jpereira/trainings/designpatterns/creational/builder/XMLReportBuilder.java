package eu.jpereira.trainings.designpatterns.creational.builder;

import eu.jpereira.trainings.designpatterns.creational.builder.xml.XMLReportBody;

import java.util.Iterator;

import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

public class XMLReportBuilder implements ReportBuilder {
    private SaleEntry saleEntry;

    @Override
	public void setSaleEntry(SaleEntry saleEntry) {
		this.saleEntry = saleEntry;

	}

    @Override
	public Report getReport() {
		Report report = new Report();

        XMLReportBody reportBody = new XMLReportBody();
        reportBody.putContent("<sale><customer><name>");
        reportBody.putContent(this.saleEntry.getCustomer().getName());
        reportBody.putContent("</name><phone>");
        reportBody.putContent(this.saleEntry.getCustomer().getPhone());
        reportBody.putContent("</phone></customer>");
        
        reportBody.putContent("<items>");
        
        Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
        while ( it.hasNext() ) {
            SoldItem soldEntry= it.next();
            reportBody.putContent("<item><name>");
            reportBody.putContent(soldEntry.getName());
            reportBody.putContent("</name><quantity>");
            reportBody.putContent(soldEntry.getQuantity());
            reportBody.putContent("</quantity><price>");
            reportBody.putContent(soldEntry.getUnitPrice());
            reportBody.putContent("</price></item>");
        }
        reportBody.putContent("</items></sale>");
        report.setReportBody(reportBody);
    
		return report;
	}
}
