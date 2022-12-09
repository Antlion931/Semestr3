package eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty;

import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.CodeMismatchException;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.IncorrectDoorCodeException;
import eu.jpereira.trainings.designpatterns.structural.adapter.model.Door;

class ThirdPartyDoorAdapter extends ThirdPartyDoor implements Door {

    @Override
    public void open(String code) throws IncorrectDoorCodeException {
        try {
            unlock(code);
        }
        catch(Exception CannotUnlockDoorException) {
            throw new IncorrectDoorCodeException();
        }
    }

    @Override
    public void close() {
        lock();
    }

    @Override
    public boolean isOpen() {
        return getLockStatus() == LockStatus.UNLOCKED;
    }

    @Override
    public void changeCode(String oldCode, String newCode, String newCodeConfirmation)
            throws IncorrectDoorCodeException, CodeMismatchException {
        if (newCode != newCodeConfirmation) {
            throw new CodeMismatchException();
        }

        try {
            open(oldCode);
            setNewLockCode(newCode);
        }
        catch(Exception e) {
            throw new IncorrectDoorCodeException();
        }
    }

    @Override
    public boolean testCode(String code) {
        try {
            open(code);
            lock();
            return true;
        }
        catch (Exception IncorrectDoorCodException) {
            return false;
        }
    }
}