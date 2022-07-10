# OT_ICS-VAPT-TOOL
Automated OT/ICS enumeration and recon tool


Before running the script make sure to install

1.Figlet
#sudo apt-get install figlet

2.lolcat
#sudo apt-get install lolcat

Copy all the nse scripts from nse scripts folder and paste it on path #/usr/share/nmap/scripts 

Working:

#chmod 777 ot.sh
Usage:  #./ot.sh [IP Address]
Ex:     #./ot.sh 192.168.0.2

Tool Description:

The tool has 3 options

Option 1 - This option is used to discover the OT/ICS ports,services,protocols running on the target IP. 


Option 2 - This option contains sub options of the OT/ICS protocols and we can specifically select the protocol to perform protocol enumeration and discovery of target devices.

	Note: Select the protocol which was discovered on Option 1 . If you select wrong protocol will not give any results.

Option 3 - This option contains the metasploit exploits, other specific tools to exploit, and links of the URL to download the exploits. 
	
	[For this option, manual exploitation needs to be performed and the resources to download scripts, exploits and modules are available]
