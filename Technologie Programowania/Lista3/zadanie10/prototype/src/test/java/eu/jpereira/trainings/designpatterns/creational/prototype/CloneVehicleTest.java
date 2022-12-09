package eu.jpereira.trainings.designpatterns.creational.prototype;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import eu.jpereira.trainings.designpatterns.creational.prototype.exception.CannotHaveZeroPartsException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.CouldNotCloneLastObjectException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.NeedToPackLastVehicleException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.VehicleDoesNotHavePartsException;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Shell;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Tire;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Vehicle;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.VehiclePartEnumeration;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Window;

public class CloneVehicleTest {
    @Test
    public void TestClone() throws CouldNotCloneLastObjectException, CannotHaveZeroPartsException, NeedToPackLastVehicleException, VehicleDoesNotHavePartsException, CloneNotSupportedException {
        SimpleVehicleBuilder builder = new SimpleVehicleBuilder();
        Vehicle vehicle = builder.createVehicle().with(new Tire()).times(10).with(new Window()).times(2).with(new Shell()).packIt();
		assertEquals(13, vehicle.countParts());


        Vehicle cloned = (Vehicle) vehicle.clone();

        assertEquals(vehicle.countParts(), cloned.countParts());
        assertEquals(vehicle.getParts(VehiclePartEnumeration.TIRE), cloned.getParts(VehiclePartEnumeration.TIRE));
        assertEquals(vehicle.getParts(VehiclePartEnumeration.WINDOW), cloned.getParts(VehiclePartEnumeration.WINDOW));
        assertEquals(vehicle.getParts(VehiclePartEnumeration.SHELL), cloned.getParts(VehiclePartEnumeration.SHELL));

    }
}
