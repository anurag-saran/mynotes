standalone-full.xml has messaging.
standalone.sh --server-config=standalone-full.xml


domain.xml contains the server profiles and server groups. You assing server groups to the profiles.
host.xml : contains the server aand they are assigned to the server groups.

domain.sh
ps -ef | grep java --> find 4 running.
Host Controller that controls the domian.
Process Controller that controls java process on this machine.
2 server instances 1 and 2.

If you want to run domain controler on a seprate machine and host controller on a seprate machine.
host-master.xml --> conects to the host controller of the local machine that makes it the master. i.e. </domain-controller>
host-slave.xml--> <domain-controller> points to the remote host i.e. master of the domian. It contains the server definitions.
$bin/domain.sh --host-config=host-master.xml -Djboss.bind.address.management=10.1.1.10
--> you will see Process controller and Host controller now running.
host-slave.xml --> add user and password.
$bin/domain.sh --host-config=host-slave.xml --master=10.1.1.10 -->Ip of domain controller.
-->You will see HC, PC and two server processes.

# Deploying application in domain mode
Management Console 9990
Run in Domain mode and use master domain IP Address.
$bin/jboss-cli.sh
connect 10.1.1.10
[] deploy simple.war --server-groups=main-server-group
# Sharing configuration in domain mode
# Domain.xml I have two server groups. i.e. main-server-group and ha-server-group
$bin/domain.sh --host-config=host-master.xml -b 10.1.1.10 -Djboss.bind.address.management=10.1.1.10
$bin/domain.sh --host-config=host-slave.xml --master=10.1.1.10  -b 10.1.1.11
# clustering in standalone mode
$bin/standalone.sh --server-config=standalone-ha.xml  -b 10.215.9.228 -Djboss.node.name=node1 -u 230.0.0.4
$bin/standalone.sh --server-config=standalone-ha.xml  -b 10.215.9.229 -Djboss.node.name=node2 -u 230.0.0.4
# clustering in domain mode
$bin/domain.sh --host-config=host-master.xml -b 10.1.1.11 -Djboss.bind.address.management=10.1.1.10
$bin/domain.sh --host-config=host-slave.xml --master=10.1.1.10 -b 10.1.1.11