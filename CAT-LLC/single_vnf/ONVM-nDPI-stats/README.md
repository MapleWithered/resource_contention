## The impact of Intel CAT on the performance of NFV systems

This directory contains data to characterize the performance impact of LLC shares on different network functions. 

Data for singleton network functions are organized under the **single_vnf** directory. The data were collected during the runtime of each network function. 
In particular, we employ Intel CAT to specify the LLC share for each network function. The LLC has 20 ways on our server with a bit mask of 0xfffff. 
CAT allows us to designate __contiguous__ bits mapped to the corresponding LLC ways, e.g., 0x1, 0x3, 0x10000, 0x10, etc. For each LLC allocation scheme, we use Intel PCM to 
collect core, memory, and PCI features. 

We also record the corresponding performance metrics, including throughput, latency, and packet losses, in the _traffic_profile.txt_ file. A sample record is 

> [Device: id=0] TX: 5.49 (StdDev 0.26) Mpps, 2812 (StdDev 132) Mbit/s (3691 Mbit/s with framing), total 8801155466 packets with 563302772384 bytes (incl. CRC)

> [Device: id=1] RX: 5.42 (StdDev 0.25) Mpps, 2776 (StdDev 126) Mbit/s (3644 Mbit/s with framing), total 8678956017 packets with 555481374744 bytes (incl. CRC)

> Samples: 1174569, Average: 11137.8 ns, StdDev: 8340.4 ns, Quartiles: 7559.0/10368.0/12454.0 ns



