package eu.jpereira.trainings.designpatterns.creational.abstractfactory.xml;

import eu.jpereira.trainings.designpatterns.creational.abstractfactory.AbstractFactory;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.ReportBody;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.ReportFooter;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.ReportHeader;

public class XMLFactory implements AbstractFactory {

    @Override
    public ReportBody createReportBody() {
        return new XMLReportBody();
    }

    @Override
    public ReportFooter createReportFooter() {
        return new XMLReportFooter();
    }

    @Override
    public ReportHeader createReportHeader() {
        return new XMLReportHeader();
    }
    
}
