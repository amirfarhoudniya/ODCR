#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     16                         ;# number of mobilenodes
set val(rp)     DSR                       ;# routing protocol
set val(x)      1400                      ;# X dimension of topography
set val(y)      901                      ;# Y dimension of topography
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open code.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open code.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 16 nodes
set n0 [$ns node]
$n0 set X_ 1097
$n0 set Y_ 799
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 1198
$n1 set Y_ 801
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 1299
$n2 set Y_ 703
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 1300
$n3 set Y_ 606
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 1199
$n4 set Y_ 505
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 1100
$n5 set Y_ 499
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 999
$n6 set Y_ 604
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 999
$n7 set Y_ 704
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 800
$n8 set Y_ 500
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 898
$n9 set Y_ 502
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 998
$n10 set Y_ 405
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 1000
$n11 set Y_ 304
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 899
$n12 set Y_ 204
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 799
$n13 set Y_ 201
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 699
$n14 set Y_ 301
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 700
$n15 set Y_ 400
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20

#===================================
#        Agents Definition        
#===================================
#Setup a UDP connection
set udp14 [new Agent/UDP]
$ns attach-agent $n14 $udp14
set null17 [new Agent/Null]
$ns attach-agent $n1 $null17
$ns connect $udp14 $null17
$udp14 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp14
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$ns at 1.0 "$cbr0 start"
$ns at 10.0 "$cbr0 stop"


#===================================
#       Energy sets
#===================================

set energylist(0) 100
set energylist(1) 100
set energylist(2) 100
set energylist(3) 100
set energylist(4) 100
set energylist(5) 100
set energylist(6) 100
set energylist(7) 100
set energylist(8) 100
set energylist(9) 100
set energylist(10) 100
set energylist(11) 100
set energylist(12) 100
set energylist(13) 100
set energylist(14) 100
set energylist(15) 100
set energylist(16) 100
set maxEnergyNode 0

#===================================
#       global variables
#===================================



#===================================
#              NMC
#===================================
array set NMC {}

proc setNMC {row col value} {
    global NMC
    set NMC($row $col) [$value]
}

proc getNMC {row col} {
    global NMC
   return $NMC($row $col)   
}

#===================================
#         calculate  NMC
#===================================
proc calculateDistance {node1 node2} {
    set distance [expr {sqrt(pow($node1(X_) - $node2(Y_), 2) + pow($node1(Y_) - $node2(X_), 2))}]
    return $distance
}

proc calculateCommunicationRange {txPower rxSensitivity pathLossExponent} {
    set lambda 3e8 / 2.4e9  ;# Wavelength for 2.4 GHz frequency

    # Calculate the communication range
    set communicationRange [expr {sqrt((txPower / rxSensitivity) * pow($lambda / (4 * 3.14159), 2) * pow(10, pathLossExponent / 10))}]

    return $communicationRange
}

proc calculateVelocities {node1 node2} {
    set v1 [[$n1 set ragent_] set speed_]
    set v2 [[$n2 set ragent_] set speed_]
    return $v1 + $v2
}

proc calculateNMC {node1 node2} {
    set d [calculateDistance $n1 $n2]

}


#===================================
#       clustering
#===================================
proc setcluster {} {

    
    
}


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
