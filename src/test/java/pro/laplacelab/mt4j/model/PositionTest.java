package pro.laplacelab.mt4j.model;

import org.junit.Test;
import pro.laplacelab.mt4j.BaseTestPreparation;
import pro.laplacelab.mt4j.enums.SignalType;
import pro.laplacelab.mt4j.exception.InvalidSignalException;

import static org.junit.Assert.assertEquals;

public class PositionTest extends BaseTestPreparation {

    @Test
    public void whenPositionConstructedSuccessfulThenStateSaved() {
        final Position position = new Position(advisorId, SignalType.BUY, positionId,
                lot, stopLoss, takeProfit, openAt, closeAt, profit);
        assertEquals(SignalType.BUY, position.getType());
        assertEquals(positionId, position.getPositionId());
        assertEquals(takeProfit, position.getTakeProfit());
        assertEquals(advisorId, position.getAdvisorId());
        assertEquals(stopLoss, position.getStopLoss());
        assertEquals(lot, position.getLot());
        assertEquals(openAt, position.getOpenAt());
        assertEquals(closeAt, position.getCloseAt());
    }

    @Test(expected = InvalidSignalException.class)
    public void whenPositionBuildWithWrongSignalTypeThenThrowException() {
        new Position(advisorId, SignalType.UPDATE, positionId,
                lot, stopLoss, takeProfit, openAt, closeAt, profit);
    }

}