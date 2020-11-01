package pro.laplacelab.bridge.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.laplacelab.bridge.Strategy;
import pro.laplacelab.bridge.exception.AdvisorNotFoundException;
import pro.laplacelab.bridge.exception.StrategyNotFoundException;
import pro.laplacelab.bridge.model.Advisor;
import pro.laplacelab.bridge.model.Market;
import pro.laplacelab.bridge.model.Signal;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
@Service
public class SignalServiceImpl implements SignalService {

    private final AdvisorService advisorService;

    private final List<Strategy> strategies;

    @Autowired
    public SignalServiceImpl(final @NotNull List<Strategy> strategies,
                             final @NotNull AdvisorService advisorService) {
        this.strategies = new CopyOnWriteArrayList<>(strategies);
        this.advisorService = advisorService;
    }

    @Override
    public Signal onTick(final @NotNull Market market) {
        log.debug("Market request: {}", market);
        final Advisor advisor = advisorService
                .get(market.getAdvisorId())
                .orElseThrow(AdvisorNotFoundException::new);
        final Strategy strategy = strategies.stream()
                .filter(item -> market.getStrategyName().equals(item.getName()))
                .findFirst().orElseThrow(StrategyNotFoundException::new);
        final Signal signal = strategy.apply(advisor, market.getIndicators());
        log.debug("Signal response: {}", signal);
        return signal;
    }

}
