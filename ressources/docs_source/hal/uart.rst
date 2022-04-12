U(S)ART 
====
USART(Universal Synchronous Asynchronous Transmitter Receiver) is the peripheral wich implements the USART/UART protocol. USART is full-duplex communication protocol, which means that it can transfer data in both directions at the same time. 

Physical characteristics
************************
USART protocol defines 3 lines:
    * Tx - Transmit line
    * Rx - Receive line
    * Sck - Synchronization line

Unlike the USART, UART has only two lines:
    * Tx - Transmit line
    * Rx - Receive line

USART/UART can have software or hardware flow-control. For this purpose we have two additional lines:
    * CTS - Clear to send
    * RTS - Requst to send


Connection diagram
******************
USART/UART network is point-to-point network, which means that only two devicees can be connected to each other. Connection diagram is shown bellow.

.. image:: images/hal-uart-connection.png

As we can see, *Tx* line of first device is connected to the *Rx* line of the second device. Also, *Tx* line of second device is connected to *Rx* line of first device. Additionally, in the case of the USART, *Sck* line of the first device is connected to the *Sck* line of the second device.

Same as the Rx and Tx lines are croswise connected, CTS and RTS lines are also croswise connected as shown on the image bellow:

.. image:: images/hal-uart-cts-rts.png


Timing diagram
**************
UART doesn't have synchronization mechanisam, so data on the transmission line is sampled in the middle of the bit interval. Timing diagram is shown on the image bellow:

.. image:: images/hal-uart-timing-diagram.png

Because UART doesn't have synchronization mechanisam, it is essential that the two devices that communicate using the UART protocl have set the same transfer speed. Also, both device must have stable clock source for this protocol to work. Transfer speeds are standardised and some of them are:
    * 300
    * 600
    * 1200
    * 2400
    * 4800
    * 9600
    * 19200
    * 38400
    * 57600
    * 115200
    * 230400
    * 460800
    * 921600

Package Format
**************
USART/UART consists of:
    * Start bit - 1b
    * Data frame - 7b,8b or 9b depending on the aplication
    * Parity bit - 1b
    * Stop bit(s) - 1b or 2b
    
Start bit
---------
The UART data transmission line is normally held at a high voltage level when it’s not transmitting data. To start the transfer of data, the transmitting UART pulls the transmission line from high to low for one clock cycle. When the receiving UART detects the high to low voltage transition, it begins reading the bits in the data frame at the frequency of the baud rate.

Data Frame
----------
The data frame contains the actual data being transferred. It can be 7 or 8 bits long if a parity bit is used. If no parity bit is used, the data frame can be 9 bits long. In most cases, the data is sent with the least significant bit first.

Parity bit
----------
Parity describes the evenness or oddness of a number. The parity bit is a way for the receiving UART to tell if any data has changed during transmission. Bits can be changed by electromagnetic radiation, mismatched baud rates, or long distance data transfers. After the receiving UART reads the data frame, it counts the number of bits with a value of 1 and checks if the total is an even or odd number. If the parity bit is a 0 (even parity), the 1 bits in the data frame should total to an even number. If the parity bit is a 1 (odd parity), the 1 bits in the data frame should total to an odd number. When the parity bit matches the data, the UART knows that the transmission was free of errors. But if the parity bit is a 0, and the total is odd; or the parity bit is a 1, and the total is even, the UART knows that bits in the data frame have changed.

Stop bit
--------
To signal the end of the data packet, the sending UART drives the data transmission line from a low voltage to a high voltage for at least two bit durations.

Example
*******
