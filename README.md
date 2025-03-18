# AES_ENCRYPTION_FPGA

In this project, I implement a 128 bit encryption algorithm in SystemVerilog using Quartus Prime. The design is fully pipelined and optimized in terms of throughput and latency. Functionally verified using ModelSim. Fmax/resource utilization analyzed with Quartus.

https://en.wikipedia.org/wiki/Advanced_Encryption_Standard

**Main Project Components/Modules:**

aes_wrapper - Main module which implements 10 rounds of the AES encryption algorithm. Encapsulates all the other modules.

aes_key_expand_revamped - key expansion module. It computes keys used in each round.

round - computes data after a single round. Consolidates mix_cols, s_sub_revamped, shift_rows modules.

s_sub_revamped, mix_cols, shift_rows - transformations that are implemented as separate modules.

