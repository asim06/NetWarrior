
# Network Attack Script

This script allows you to perform various types of network attacks such as UDP flood, SYN flood, ICMP flood, TCP RST flood, and others using `hping3`. It supports multiple threads and logs the total number of packets sent.

## Requirements

- `hping3`
- `figlet`

Install required packages:
```bash
sudo apt-get install hping3 figlet
```

## Usage

./network_attack.sh


## Options
When you run the script, you will be prompted to enter the following information:

 Number of threads: The number of threads to use for the attack.
 
 Target IP address: The IP address of the target.
 
 Target port: The port number of the target.
 
 Type of flood: The type of flood attack you want to perform. Options are:
 
* icmp
* syn
* udp
* tcp_rst
* tcp_syn-ack
* tcp_ack-fin
* tcp_push-ack
* tcp_no-flag
* udp_fragment
* custom (for custom commands)

### Custom Command

If you choose the custom option for the flood type, you will be prompted to enter your custom hping3 command. This allows you to specify any custom attack command you need.

### Logging

The script logs the start time, end time, and details of each attack in the report.txt file.

### Monitoring

The script displays the current CPU and RAM usage while the attack is ongoing. You can choose to stop the attack by entering yes when prompted.
