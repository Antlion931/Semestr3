package eu.jpereira.trainings.designpatterns.creational.abstractfactory;

public interface AbstractFactory {
    ReportBody createReportBody();
    ReportFooter createReportFooter();
    ReportHeader createReportHeader();
}
