package eu.jpereira.trainings.designpatterns.creational.builder;

import java.util.Iterator;

import eu.jpereira.trainings.designpatterns.creational.builder.json.JSONReportBody;
import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

public class JSONReportBuilder implements ReportBuilder {
    private SaleEntry saleEntry;

	/**
	 * @param reportDate
	 */
	public void setSaleEntry(SaleEntry saleEntry) {
		this.saleEntry = saleEntry;

	}

	/**
	 * @param type
	 * @return
	 */
	public Report getReport() {
		Report report = new Report();

        JSONReportBody reportBody = new JSONReportBody();
        //Add customer info
        reportBody.putContent("sale:{customer:{");
        reportBody.putContent("name:\"");
        reportBody.putContent(saleEntry.getCustomer().getName());
        reportBody.putContent("\",phone:\"");
        reportBody.putContent(saleEntry.getCustomer().getPhone());
        reportBody.putContent("\"}");
        //add array of items
        reportBody.putContent(",items:[");
        Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
        while ( it.hasNext() ) {
            SoldItem item = it.next();
            reportBody.putContent("{name:\"");
            reportBody.putContent(item.getName());
            reportBody.putContent("\",quantity:");
            reportBody.putContent(String.valueOf(item.getQuantity()));
            reportBody.putContent(",price:");
            reportBody.putContent(String.valueOf(item.getUnitPrice()));
            reportBody.putContent("}");
            if ( it.hasNext() ) {
                reportBody.putContent(",");
            }
            
        }
        reportBody.putContent("]}");
			
			
			report.setReportBody(reportBody);


		return report;
	}
}
