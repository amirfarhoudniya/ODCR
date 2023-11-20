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
array set n {}
#Create 16 nodes
set n(0) [$ns node]
$n(0) set X_ 1097
$n(0) set Y_ 799
$n(0) set Z_ 0.0
$ns initial_node_pos $n(0) 20
set n(1) [$ns node]
$n(1) set X_ 1198
$n(1) set Y_ 801
$n(1) set Z_ 0.0
$ns initial_node_pos $n(1) 20
set n(2) [$ns node]
$n(2) set X_ 1299
$n(2) set Y_ 703
$n(2) set Z_ 0.0
$ns initial_node_pos $n(2) 20
set n(3) [$ns node]
$n(3) set X_ 1300
$n(3) set Y_ 606
$n(3) set Z_ 0.0
$ns initial_node_pos $n(3) 20
set n(4) [$ns node]
$n(4) set X_ 1199
$n(4) set Y_ 505
$n(4) set Z_ 0.0
$ns initial_node_pos $n(4) 20
set n(5) [$ns node]
$n(5) set X_ 1100
$n(5) set Y_ 499
$n(5) set Z_ 0.0
$ns initial_node_pos $n(5) 20
set n(6) [$ns node]
$n(6) set X_ 999
$n(6) set Y_ 604
$n(6) set Z_ 0.0
$ns initial_node_pos $n(6) 20
set n(7) [$ns node]
$n(7) set X_ 999
$n(7) set Y_ 704
$n(7) set Z_ 0.0
$ns initial_node_pos $n(7) 20
set n(8) [$ns node]
$n(8) set X_ 800
$n(8) set Y_ 500
$n(8) set Z_ 0.0
$ns initial_node_pos $n(8) 20
set n(9) [$ns node]
$n(9) set X_ 898
$n(9) set Y_ 502
$n(9) set Z_ 0.0
$ns initial_node_pos $n(9) 20
set n(10) [$ns node]
$n(10) set X_ 998
$n(10) set Y_ 405
$n(10) set Z_ 0.0
$ns initial_node_pos $n(10) 20
set n(11) [$ns node]
$n(11) set X_ 1000
$n(11) set Y_ 304
$n(11) set Z_ 0.0
$ns initial_node_pos $n(11) 20
set n(12) [$ns node]
$n(12) set X_ 899
$n(12) set Y_ 204
$n(12) set Z_ 0.0
$ns initial_node_pos $n(12) 20
set n(13) [$ns node]
$n(13) set X_ 799
$n(13) set Y_ 201
$n(13) set Z_ 0.0
$ns initial_node_pos $n(13) 20
set n(14) [$ns node]
$n(14) set X_ 699
$n(14) set Y_ 301
$n(14) set Z_ 0.0
$ns initial_node_pos $n(14) 20
set n(15) [$ns node]
$n(15) set X_ 700
$n(15) set Y_ 400
$n(15) set Z_ 0.0
$ns initial_node_pos $n(15) 20

#===================================
#        Nodes movment       
#===================================
# $ns at 0.3 " $n(0) setdest 600 600 10 " 
# $ns at 0.5 " $n(1) setdest 700 500 20 " 



#===================================
#        Agents Definition        
#===================================
#Setup a UDP connection
set udp14 [new Agent/UDP]
$ns attach-agent $n(14) $udp14
set null17 [new Agent/Null]
$ns attach-agent $n(1) $null17
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
array set NMC {}
array set GNMC {}
array set weight {}
array set node_X1_Position {}
array set node_Y1_Position {}
array set node_X2_Position {}
array set node_Y2_Position {}
set globalNMC 0
set nodesList {n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16}

#===================================
#          Node's Position
#===================================
proc updateNodePosition {} {
    global n node_X1_Position node_Y1_Position val

    for {set i 0} {$i < $val(nn)} {incr i} {
        set node_X1_Position($i) [$n($i) set X_]
        set node_Y1_Position($i) [$n($i) set Y_]
    }
}

updateNodePosition

#===================================
#              NMC
#===================================
proc setNMC {row col value} {
    global NMC
    set NMC($row,$col) $value
    
}

proc getNMC {row col} {
    global NMC
    # puts "the nmc is : $NMC($row,$col)"  
    return $NMC($row,$col) 
}

#===================================
#         calculate  NMC
#===================================
proc calculateDistance {node1 node2} {
    set node1_X [$node1 set X_]
    set node1_Y [$node1 set Y_]
    set node2_X [$node2 set X_]
    set node2_Y [$node2 set Y_]

    set distance [expr {sqrt(pow($node1_X - $node2_X, 2) + pow($node1_Y - $node2_Y, 2))}]
    return $distance
}

# set d [calculateDistance $n(1) $n(2)]
# puts "distance is : $d"

#we have logical error in proc below
#it seems we should change the communication calculation
# proc calculateCommunicationRange {txPower rxSensitivity pathLossExponent} {
#     set lambda [expr {3e8 / 2.4e9}]  ;# Wavelength for 2.4 GHz frequency

#     # Make rxSensitivity positive
#     set absRxSensitivity [expr {abs($rxSensitivity)}]

#     # Calculate the communication range
#     set communicationRange [expr {sqrt(($txPower / $absRxSensitivity) * pow(($lambda / (4 * 3.14159)), 2) * pow(10, $pathLossExponent / 10))}]

#     return $communicationRange
# }

proc calculateVelocity {node} {
    
    global node_X1_Position node_Y1_Position n

    for {set index 0} {$index < 16} {incr index} {

        if {$node == $n($index)} {
        
            set node_X2 [$node set X_]
            set node_Y2 [$node set Y_]
            set node_X1 $node_X1_Position($index)
            set node_Y1 $node_Y1_Position($index)

            set dispachment [expr {sqrt(pow($node_X2 - $node_X1 , 2)) + pow($node_Y2 - $node_Y1 , 2)}]
            return $dispachment
        }
    }
}

# set v [calculateVelocity $n(0)]
# puts "velocity of node(0) is $v" 


proc calculateNMC {} {
    global n NMC

    for {set i 0} {$i < 16} {incr i} {
        for {set j 0} {$j < 16} {incr j} {
            if {$i == $j} {
                continue
            } else {
                set distance [calculateDistance $n($i) $n($j)]
                set range 250
                set v1 [calculateVelocity $n($i)]
                set v2 [calculateVelocity $n($j)]
                set velocities [expr {$v1 + $v2 + 1}]
                set nmcValue [expr {($range - $distance) / $velocities}]
                setNMC $i $j $nmcValue
            }
        }
    }
}

proc calculateGlobalNMC {} {

    global NMC n GNMC
    set sum 0
    set counter 0 
    for {set i 0} {$i < 8} {incr i} {
        for {set j 0} {$j < 8} {incr j} {
            if {$i == $j} {
                continue
            } else {
                set value [getNMC $i $j]
                if {$value > 0} {
                   set sum [expr {$value + $sum}] 
                   incr counter
                }
            }
        }
    }
    set GNMC(0) [expr {$sum / $counter}]

    set sum 0
    set counter 0 

    for {set i 8} {$i < 16} {incr i} {
        for {set j 8} {$j < 16} {incr j} {
            if {$i == $j} {
                continue
            } else {
                set value [getNMC $i $j]
                if {$value > 0} {
                   set sum [expr {$value + $sum}] 
                   incr counter
                }
            }
        }
    }
    
    set GNMC(1) [expr {$sum / $counter}]
    # puts "the global NMC is : $GNMC(0)"
    # puts "the global NMC is : $GNMC(1)"
}


proc calculateWeight {} {
    global weight n NMC GNMC
    set nmcvalue 0
    set sum 0
    for {set i 0} {$i < 16} {incr i} {
        for {set j 0} { $j < 16 } { incr j } {
            if {$i == $j} {
                continue 
            } else {
                set nmcvalue [getNMC $i $j] 
                if {$nmcvalue > 0} {
                    set sum [expr {$nmcvalue + $sum}]                   
                }
            }
        }
        if {$i < 8} {
            set weight($i) [expr {$sum / $GNMC(0)}]
            puts "weight node($i) is $weight($i)"
            puts "sum of node($i) is $sum"
        } else {
            set weight($i) [expr {$sum / $GNMC(1)}]
            puts "weight node($i) is $weight($i)"
            puts "sum of node($i) is $sum"            
        }

    }



}

calculateNMC
calculateGlobalNMC
calculateWeight

# for {set i 0} {$i < 8} {incr i} {
#         for {set j 0} {$j < 8} {incr j} {
#             if {$i != $j} {
#                 set a [getNMC $i $j]
#                 puts "weight in $i - $j is $a"
#             }
#         }
# }

#===================================
#        clustring        
#===================================
proc setCluster {} {
    global n weight

    set minWeight 5000
    set minWeightNode 5000

    for {set i 0} {$i < 8} {incr i} {
        set a $weight($i)
        if {$a < $minWeight} {
            set minWeightNode $i
            set minWeight $a      
        }
    }     
    puts "the minWight is node($minWeightNode)"
    puts "the minimum weight is : $minWeight"
    $n($minWeightNode) color "red"

    set minWeight 5000
    set minWeightNode 5000

    for {set i 8} {$i < 16} {incr i} {
        set a $weight($i)
        if {$a < $minWeight} {
            set minWeightNode $i
            set minWeight $a         
        }
    }     
    puts "the minWight is node($minWeightNode)"
    puts "the minimum weight is : $minWeight"
    $n($minWeightNode) color "red"
    

}

setCluster
# $ns at 0.1 setCluster

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
    $ns at $val(stop) "\$n($i) reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run



