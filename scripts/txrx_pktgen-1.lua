function setRandomRate(port, minRate, maxRate)
    local rate = math.random(minRate, maxRate)
    pktgen.set(port, "rate", rate)
    print(string.format("Setting port %d rate to: %d%%", port, rate))
end

function logTxRxRates(port, file)
    local stats = pktgen.portStats(port, "port")[tonumber(port)]
    local txRate = stats.opackets; -- Transmit rate in packets per second (pps)
    local rxRate = stats.ipackets; -- Receive rate in packets per second (pps)
    
    -- Log the TX and RX rates to the CSV file
    file:write(string.format("%d, %d\n", txRate, rxRate))
    file:flush() -- Ensure data is written to the file immediately
end

function runTest(duration, rateAdjustInterval, statsInterval, minRate, maxRate, filename)
    local port = 0 -- The port to configure
    local startTime = os.time()
    local currentTime = os.time()
    local nextRateAdjustTime = startTime + rateAdjustInterval
    
    -- Open a CSV file for writing
    local file = io.open(filename, "w")
    if not file then
        print("Error opening file for writing.")
        return
    end
    
    -- Write CSV header
    file:write("TX Rate (pps),RX Rate (pps)\n")
    
    pktgen.start(port)
    
    while (currentTime - startTime) < duration do
        if currentTime >= nextRateAdjustTime then
            setRandomRate(port, minRate, maxRate)
            nextRateAdjustTime = currentTime + rateAdjustInterval
        end

        -- Measure and log TX/RX rates every second
        logTxRxRates(port, file)
        pktgen.delay(statsInterval * 1000) -- Delay for statsInterval seconds in milliseconds
        
        currentTime = os.time()
    end
    
    pktgen.stop(port)
    file:close() -- Close the CSV file
    print("Completed packet generation and logging.")
end

-- Configuration parameters
local duration = 60          -- Total duration of the test in seconds
local rateAdjustInterval = 10 -- Interval to adjust the rate in seconds
local statsInterval = 1      -- Interval to collect and log stats in seconds
local minRate = 0            -- Minimum rate as a percentage
local maxRate = 30          -- Maximum rate as a percentage
local filename = "tx_rx_rates.csv" -- Output filename

-- Run the test
runTest(duration, rateAdjustInterval, statsInterval, minRate, maxRate, filename)

