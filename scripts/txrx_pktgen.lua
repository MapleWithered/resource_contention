-- Filename: random_rate_adjustment_with_stats.lua

function setRandomRate(port, minRate, maxRate)
    -- Generate a random transmission rate between minRate and maxRate (inclusive)
    local rate = math.random(minRate, maxRate)
    print(string.format("Setting port %d rate to: %d%%", port, rate))
    -- Set the packet generation rate for the port as a percentage of the link's capacity
    pktgen.set(port, "rate", rate)
end

function printTxRxRates(port)
    -- Retrieve the current statistics for the port
    local stats = pktgen.portStats(port, "port")[tonumber(port)]
    local txRate = stats.opackets; -- Transmit rate in packets per second (pps)
    local rxRate = stats.ipackets; -- Receive rate in packets per second (pps)
    
    -- Print the TX and RX rates
    print(string.format("Port %d TX Rate: %d pps, RX Rate: %d pps", port, txRate, rxRate))
end

function runTest(duration, adjustInterval, minRate, maxRate)
    local port = 0 -- The port to configure
    local startTime = os.time()
    local currentTime = os.time()
    
    -- Start packet generation
    pktgen.start(port)
    
    while (currentTime - startTime) < duration do
        -- Set a random rate and print the TX/RX rates
        setRandomRate(port, minRate, maxRate)
        pktgen.delay(adjustInterval * 1000) -- Delay for adjustInterval seconds in milliseconds
        printTxRxRates(port)
        
        -- Update the current time
        currentTime = os.time()
    end
    
    -- Stop packet generation after completing the test
    pktgen.stop(port)
    print("Completed packet generation.")
end

-- Configuration parameters
local duration = 60        -- Total duration of the test in seconds
local adjustInterval = 10  -- Interval to adjust the rate in seconds
local minRate = 1          -- Minimum rate as a percentage
local maxRate = 30        -- Maximum rate as a percentage

-- Run the test
runTest(duration, adjustInterval, minRate, maxRate)

