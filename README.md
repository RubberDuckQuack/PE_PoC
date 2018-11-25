# Pockethernet Experimental Linux Proof Of Concept

This is an experimental proof of concept client for the 
[Pockethernet Hardware](https://www.pockethernet.com/). This has been created 
from reverse engineering the Android applications as well as the bluetooth 
packet logs. The back end framework is more or less complete and should allow
more features to be "hopefully" developed in the near future.

This software is provided as is and is not guranteed to work correctly at all. 
If a stable working client is desired, please use the official Android/IOS
clients provided from the official company. There are bound to be crippling
bugs in this software and it should not be used in a production environment.

The software is very much a work in progress and a slow one at that. Reversing 
the packets is time consuming work and the fact that the applications that
this work is based off are hacked together does not help.

[![asciicast](https://asciinema.org/a/0KJ3zGsBWmwnKV9Lk8umGB9ce.svg)](https://asciinema.org/a/0KJ3zGsBWmwnKV9Lk8umGB9ce)

## Features

* Wiremapping (Slightly broken)
* PhyConfig   (Hard coded values)

## To Do (Short Term)

* Code cleanup
* Unit tests
* Wiremap Bug fixes
* PhyConfig packet reversing

## To Do (Long Term)

* Reversing of all packets

# Research

During development of this software there has been a few things discovered that
should be understood if anyone else is looking to create their own application.

## Packet Structure

The packet structure for the Pockethernet consists of packet types, payload 
lengths, CRC16 checksums, as well as the payload itself. Not all packets seem 
to use all fields though.

The average packet consists of the following structure:

* 1 Byte of Packet Type
* 1 Byte of Payload Length
* 2 Bytes of CRC16
* Payload Bytes

When the packet is created the 2 bytes of CRC16 are null and are filled in 
after the entire packet was ran through the CRC16 checksumming function.
Afterwards the entire packet is passed through a COBS encoded to eliminate
any null bytes from the packet so that they can be used as file delimeters.

There are a few packets that I have found thus far that do not conform strictly
to this structure. Those are of the ACK and NACK type which are the responses
for some packets such as Phy Config.
