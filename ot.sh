#!/bin/bash
figlet -f slant -c "ICS VAPT TOOL" | lolcat && figlet -f digital -c "Discover Enumerate Exploit" | lolcat
echo -e "\033[1m \e[32m               		Developed by K.Narahari" | lolcat
echo -e "\e[1;33m Tool Usage:  #./ot.sh [IP Address] \e[0m"
echo -e "\e[1;33m Ex:   $./ot.sh 192.168.0.4 \e[0m"
echo -e "\e[0;31m Note: only one IP should be tested at a time please do not give multiple IP's \e[0m"
if [ $UID  -eq  0 ]
then
  echo ""
  echo "Tool running as Root User"
else
  echo ""
  echo "You are not root. Please run the scan as root user"
fi

echo ""
PS3='Please enter your choice: '
options=("Information Gathering of OT Protocols and Services" "Protocol Enumearation to discover the type of OT device and Device enumeration to know the type of device,version,vendor" "Exploitation Reference" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Information Gathering of OT Protocols and Services")
            echo "you chose choice 1"
            echo ""
            if [ $# -lt 1 ]; then
	    echo "Enter the target IP Address to start the script"
            exit
            else
            echo "scanning"	| lolcat
            echo ""
            nmap -Pn -sT --scan-delay 1s --max-parallelism 1 -p 80,102,443,502,530,593,789,1089-1091,1911,1962,2222,2404,4000,4840,4843,4911,9600,19999,20000,20547,34962-34964,34980,44818,46823,46824,55000-55003 $1 | grep open
            fi
            ;;
        "Protocol Enumearation to discover the type of OT device and Device enumeration to know the type of device,version,vendor")
            echo "you chose choice 2"
            echo ""
            PS3='please select the OT/ICS protocol '
            echo ""
options=("502 - mbap (Modbus TCP)" "102 - iso-tsap (S7)" "47808 - bacnet" "9600 - Omron Fins" "34964 - Profinet" "44818 - Ethernet/IP" "1911,4911 - Niagara Fox" "20000 - dnp3" "20547 - ProConOS" "1962 - PCWorx" "5006 - Melsec-Q (Mitsubishi)" "2222 - cspv4 (Allen Bradley)" "46824 - Sielco Sistemi Winlog" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "502 - mbap (Modbus TCP)")
            echo -e "\e[0;23m Modbus selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 502 $1 | grep open
            echo ""
            echo -e "\e[0;32m Modbus discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sT -p502 --script modbus-discover $1
            nmap -Pm -sT -p502 --script modicon-info $1
            echo -e "\e[32mCompleted"
            ;;
        "102 - iso-tsap (S7)")
            echo -e "\e[0;23m S7 selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 102 $1 | grep open
            echo ""
            echo -e "\e[0;32m S7 discovery using NSE Script \e[0m"
            echo ""
            nmap --script s7-info.nse -p 102 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "47808 - bacnet")
            echo -e "\e[0;23m Bacnet Selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -sU -p 47808 $1 | grep open
            echo ""
            echo -e "\e[0;32m Bacnet discovery using NSE Script \e[0m"
            echo ""
            nmap --script bacnet-info -sU -p 47808 $1
            echo -e "\e[32mCompleted"
            ;;
        "9600 - Omron Fins")
            echo -e "\e[0;23m omron FINS selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 9600 $1 | grep open
            echo ""
            echo -e "\e[0;32m Omron FINS discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script omron-info -p 9600 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "34964 - Profinet")
            echo -e "\e[0;23m Profinet selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 34964 $1 | grep open
            echo ""
            echo -e "\e[0;32m Profinet discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script pn_discovery -p 34964 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "44818 - Ethernet/IP")
            echo -e "\e[0,23m Ethernet/IP selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -sU -p 44818 $1 | grep open
            echo ""
            echo -e "\e[0;32m Ethernet/IP discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script enip-info -p 44818 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "1911,4911 - Niagara Fox")
            echo -e "\e]0,23m Niagara Fox Selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -sT -p 1911,4911 $1 | grep open
            echo ""
            echo -e "\e[0;32m Niagara Fox using NSE Script \e[0m"
            echo ""
            nmap -Pn -sT --script fox-info -p 1911,4911 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "20000 - dnp3")
            echo -e "\e[0,23m dnp3 selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 20000 $1 | grep open
            echo ""
            echo -e "\e[0;32m dnp3 discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script dnp3-info -p 20000 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "20547 - ProConOS")
            echo -e "\e[0,23m ProConOS selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 20547 $1 | grep open
            echo ""
            echo -e "\e[0;32m ProConOS discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn --script proconos-info -p 20547 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "1962 - PCWorx")
            echo -e "\e[0,23m PCWorx selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 1962 $1 | grep open
            echo ""
            echo -e "\e[0;32m PCWorx discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn --script pcworx-info -p 1962 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "5006 - Melsec-Q (Mitsubishi)")
            echo -e "\e[0,23m Melsec-Q selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -sU -p 5006 $1 | grep open
            echo ""
            echo -e "\e[0;32m Melsec-Q discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script melsecq-discover -p 5006 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "2222 - cspv4 (Allen Bradley)")
            echo -e "\e[0,23m cspv4 selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -p 2222 $1 | grep open
            echo ""
            echo -e "\e[0;32m cspv4 discovery using NSE Script \e[0m"
            echo ""
            nmap -Pn -sU --script cspv4-info -p 2222 $1
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "46824 - Sielco Sistemi Winlog")
            echo -e "\e[0,23m Sielco Sistemi Winlog selected \e[0m"
            echo ""
            echo -e "\e[0;32m Version Detection \e[0m"
            echo ""
            nmap -Pn -sV -sT -p 46824 $1 | grep open
            echo ""
            echo -e "\e[32mCompleted"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
            ;;
        "Exploitation Reference")
        echo ""
            PS3='Please enter your choice: '
options=("502 - mbap (Modbus TCP)" "102 - iso-tsap (S7)" "47808 - bacnet" "9600 - Omron Fins" "34964 - Profinet" "44818 - Ethernet/IP" "1911,4911 - Niagara Fox" "20000 - dnp3" "20547 - ProConOS" "1962 - PCWorx" "5006 - Melsec-Q (Mitsubishi)" "2222 - cspv4 (Allen Bradley)" "46824 - Sielco Sistemi Winlog" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "502 - mbap (Modbus TCP)")
            echo ""
            echo -e "\e[1;32mModbus exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m auxiliary/scanner/scada/modbus_banner_grabbing\e[0m"
            echo -e "\e[1;36m auxiliary/scanner/scada/modbusclient\e[0m"
            echo -e "\e[1;36m auxiliary/scanner/scada/modbusdetect\e[0m"
            echo -e "\e[1;36m auxiliary/analyze/modbus_zip\e[0m"
            echo -e "\e[1;36m auxiliary/scanner/scada/modbus_findunitid\e[0m"
            echo -e "\e[1;36m auxiliary/admin/scada/modicon_command\e[0m"
            echo -e "\e[1;36m auxiliary/admin/scada/modicon_stux_transfer\e[0m"
            echo ""
            echo -e "\e[1;31mTools :\e[0m"
            echo ""
            echo -e "\e[1;36m https://github.com/sourceperl/mbtget\e[0m"
            echo -e "\e[1;36m https://github.com/0x0mar/smod\e[0m"
            echo -e "\e[1;36m https://github.com/moki-ics/modscan\e[0m"
            ;;
        "102 - iso-tsap (S7)")
            echo ""
            echo -e "\e[1;32mSiemens S7 exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m https://github.com/moki-ics/s7-metasploit-modules\e[0m"
            echo ""
            echo -e "\e[1;31mTools :\e[0m"
            echo ""
            echo -e "\e[1;36m https://github.com/klsecservices/s7scan\e[0m"
            echo -e "\e[1;36mhttp://snap7.sourceforge.net/\e[0m"
            echo -e "\e[1;36m https://github.com/dw2102/S7Comm-Analyzer\e[0m"
            echo -e "\e[1;36mhttps://github.com/hslatman/awesome-industrial-control-system-security/blob/main/source/s7-cracker.py\e[0m"
            echo -e "\e[1;36mhttps://github.com/otoriocyber/PCS7-Hardening-Tool\e[0m"
            ;;
        "47808 - bacnet")
            echo ""
            echo -e "\e[1;32mBacnet exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m exploit/windows/fileformat/bacnet_csv\e[0m"
            echo ""
            echo -e "\e[1;31mExploits can be downloaded from the below URL :\e[0m"
            echo ""
            echo -e "\e[1;36m https://www.exploit-db.com/exploits/47148\e[0m"
            echo -e "\e[1;36m https://www.exploit-db.com/exploits/48860\e[0m"
            ;;
        "9600 - Omron Fins")
            echo ""
            echo -e "\e[1;32mOmron FINS exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mExploit to perform DOS can be downloaded from below URL :\e[0m"
            echo ""
            echo -e "\e[1;36m https://www.exploit-db.com/exploits/47757\e[0m"
            ;;
        "34964 - Profinet")
            echo ""
            echo -e "\e[1;32mProfinet exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m auxiliary/scanner/scada/profinet_siemens\e[0m"
          
            ;;
        "44818 - Ethernet/IP")
            echo ""
            echo -e "\e[1;32mEthernet/IP exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mOther Enumeration Methods :\e[0m"
            echo ""
            echo -e "\e[1;36m pip3 install cpppo\e[0m"
            echo -e "\e[1;36m python3 -m cpppo.server.enip.list_services [--udp] [--broadcast] --list-identity -a <IP>\e[0m"
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m auxiliary/admin/scada/multi_cip_command\e[0m"
            echo ""
            echo -e "\e[1;31m Tool :  Ethersploit-IP\e[0m"
            echo -e "\e[1;36mhttps://github.com/thiagoralves/EtherSploit-IP :\e[0m"
            echo ""
            ;;
        "1911,4911 - Niagara Fox")
            echo ""
            echo -e "\e[1;32mNiagara Fox exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mRelated Exploitation Script can be downloaded from below URL :\e[0m"
            echo ""
            echo -e "\e[1;36m https://github.com/GainSec/CVE-2017-16744-and-CVE-2017-16748-Tridium-Niagara\e[0m"
            ;;
        "20000 - dnp3")
            echo ""
            echo -e "\e[1;32mdnp3 exploitation Resources\e[0m"
            echo ""
            echo -e "\e[1;31mExploit to perform DOS can be downloaded from below URL :\e[0m"
            echo ""
            echo -e "\e[1;36m https://www.exploit-db.com/exploits/4347\e[0m"
            ;;
        "20547 - ProConOS")
            echo ""
            echo -e "\e[1;32mProConOS exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;31mNote :  Try default port and also change the port to 20567 \e[0m"
            echo -e "\e[1;36m auxiliary/admin/scada/phoenix_command\e[0m"
            
            ;;
        "1962 - PCWorx")
            echo ""
            echo -e "\e[1;32m PCWorx exploitation Resources\e[0m"
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m auxiliary/admin/scada/phoenix_command\e[0m"
            ;;
        "5006 - Melsec-Q (Mitsubishi)")
            echo ""
            echo -e "\e[1;32mMelsec-Q Mitsubishi exploitation Resources\e[0m"
            echo ""
            echo ""
            echo -e "\e[1;31mPython Script to perform DOS can be downloaded from below URL by requesting the Author for Script:\e[0m"
            echo ""
            echo -e "\e[1;36m https://blog.scadafence.com/scadafence-researchers-discover-a-vulnerability-in-mitsubishi-electric-melsec-iq-r-series-cpu-dos?utm_content=131513143&utm_medium=social&utm_source=facebook&hss_channel=fbp-508057022655809\e[0m"
            ;;
        "2222 - cspv4 (Allen Bradley)")
            echo ""
            echo -e "\e[1;32mcspv4 exploitation Resources\e[0m"
            echo ""
            echo "NIL"
            ;;
        "46824 - Sielco Sistemi Winlog")
            echo ""
            echo -e "\e[1;32mSielco Sistemi Winlog exploitation Resources\e[0m"
            echo ""
            echo -e "\e[1;31mEnumeration Auxiliary :\e[0m"
            echo ""
            echo -e "\e[1;36m auxiliary/scanner/scada/sielco_winlog_fileaccess\e[0m"
            echo ""
            echo -e "\e[1;31mMetasploit Exploits :\e[0m"
            echo ""
            echo -e "\e[1;36m exploit/windows/scada/winlog_runtime\e[0m"
            echo -e "\e[1;36m exploit/windows/scada/winlog_runtime_2\e[0m"
            
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
            ;;
        "Quit")
            echo ""
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


