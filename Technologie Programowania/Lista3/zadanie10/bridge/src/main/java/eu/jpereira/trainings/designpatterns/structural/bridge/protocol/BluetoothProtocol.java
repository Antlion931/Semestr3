package eu.jpereira.trainings.designpatterns.structural.bridge.protocol;


public class BluetoothProtocol extends Protocol {

    @Override
    public void startSession() {
        setSessionActive(true);
        
    }

    @Override
    public void endSession() {
        setSessionActive(false);
        
    }
    
}