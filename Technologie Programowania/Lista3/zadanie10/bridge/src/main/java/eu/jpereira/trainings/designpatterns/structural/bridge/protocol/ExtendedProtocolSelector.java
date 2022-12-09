package eu.jpereira.trainings.designpatterns.structural.bridge.protocol;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class ExtendedProtocolSelector extends ProtocolSelector {
    @Override
    protected Collection<Protocol> createAditionalProtocols() {
		List<Protocol> list = new ArrayList<Protocol>();
        list.add(new BluetoothProtocol());
        return list;
	}
}
