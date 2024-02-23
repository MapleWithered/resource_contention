-- pktgen-measure-performance.lua
-- Script to generate packets, measure throughput and latency with pktgen-DPDK

local function configure_port(port)
    -- Basic configuration for the port
    pktgen.set(port, "size", 64); -- Set packet size to 64 bytes
    pktgen.set(port, "rate", 50); -- Set rate to 50%
end

local function measure_performance(port, duration)
    local startTime = os.time()
    local endTime = startTime + duration

    -- Start packet generation
    pktgen.start(port)

    while os.time() < endTime do
        pktgen.delay(1000) -- Delay for 1 second between measurements

        -- Retrieve and log throughput and latency
        -- local stats = pktgen.portStats(port, "rate")
        -- print("Throughput: " .. stats.opackets .. " PPS, " .. stats.obytes .. " BPS")
    end

    -- Stop packet generation
    pktgen.stop(port)
end

local function main()
    local port = 0 -- Define the port to test
    local duration = 60 -- Duration of the test in seconds

    configure_port(port)
    measure_performance(port, duration)
end

main()
