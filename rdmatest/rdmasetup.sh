#!/bin/bash
#
# because of switch problems, Pod VFs must be on same PF.
#
# Server side.
ib_write_bw -d rocep177s0f0v7 --report_gbits     # rocep177s0f0v7  is the server listen device
# Client side
ib_write_bw 192.168.177.6 --report_gbits         # 192.168.177.6 target server RoCE IP address


