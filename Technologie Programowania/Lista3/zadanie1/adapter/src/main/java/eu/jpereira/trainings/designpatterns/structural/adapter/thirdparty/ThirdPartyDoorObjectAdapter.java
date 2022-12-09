package eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty;

import eu.jpereira.trainings.designpatterns.structural.adapter.model.Door;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.CodeMismatchException;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.IncorrectDoorCodeException;

class ThirdPartyDoorObjectAdapter implements Door {

	private ThirdPartyDoor door = new ThirdPartyDoor();

    @Override
    public void open(String code) throws IncorrectDoorCodeException {
        try {
            door.unlock(code);
        }
        catch(Exception CannotUnlockDoorException) {
            throw new IncorrectDoorCodeException();
        }
    }

    @Override
    public void close() {
        door.lock();
    }

    @Override
    public boolean isOpen() {
        return door.getLockStatus() == ThirdPartyDoor.LockStatus.UNLOCKED;
    }

    @Override
    public void changeCode(String oldCode, String newCode, String newCodeConfirmation)
            throws IncorrectDoorCodeException, CodeMismatchException {
		if (newCode != newCodeConfirmation) {
			throw new CodeMismatchException();
		}
		
        try {
            open(oldCode);
            door.setNewLockCode(newCode);
        }
        catch(Exception e) {
            throw new IncorrectDoorCodeException();
        }
    }

    @Override
    public boolean testCode(String code) {
        try {
            open(code);
            door.lock();
            return true;
        }
        catch (Exception IncorrectDoorCodException) {
            return false;
        }
    }
}
