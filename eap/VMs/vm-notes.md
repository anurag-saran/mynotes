1. Not Attached --> Network card is present but no coonection.
2. NAT-  --> VM in seperate network but access to internet. No one from nternet can access it.
VM To VM: No. VM To Host:NO, VM To Internet: Yes Internet To VM: Port Forwarding
3. NAT Network -> VM's can talk to each other. 
VM To VM: Yes. VM To Host:NO, VM To Internet: Yes Internet To VM: Port Forwarding
File-->Preferences-->Netowrk --CIDR 172.16.1.0/24
4. Bridge Networking --> Put your VM on your network.
VM To VM: Yes. VM To Host:Yes, VM To Internet: Yes Internet To VM: Yes : host and VM on same network

5. Internal Networking --> Interneal netwoek
VM To VM: Yes. VM To Host:NO, VM To Internet: No Internet To VM: NO
Select internal network i.e. Inet. Same same is same network
6. Host-only Networking --> 
VM To VM: Yes VM To Host:Yes, VM To Internet: No Internet To VM: Port Forwarding
File-->Host Netork Manager. Enable DHCP.
Select this adapter now.
7. Generic Networking
