@def title = "Technological Networks"

# Technological Networks

## The Internet

The Internet is a packet-switched data network, meaning that messages sent over it are broken up into packets, small chunks of data, that are sent separately over the network and reassembled into a complete message again at the other end. The format of the packets follows a standard known as the Internet Protocol (IP) and includes an IP address in each packet that specifies the packet’s destination, so that it can be routed correctly across the network.

The simplest network representation of the Internet is one in which the nodes of the network represent computers and other devices, and the edges represent data connections between them, such as optical fiber lines or wireless connections. The “interior” nodes of the Internet are primarily routers, powerful special-purpose machines at the junctions between data lines that receive data packets and forward them in one direction or another towards their intended destination.

The innermost circle, the core of the network, is called the backbone and contains the trunk lines that provide long-distance high-bandwidth data transport across the globe, along with the high-performance routers and switching centers that link the trunk lines together. The backbone is owned and operated by a set of network backbone providers, who are primarily national governments and major telecommunications companies such as Level 3 Communications, Cogent, NTT, and others.

The second circle of the Internet is composed of Internet service providers or ISPs—commercial companies, governments, universities, and others who contract with NBPs for connection to the backbone and then resell or otherwise provide that connection to end users, the ultimate consumers of Internet band- width, who form the third circle are further subdivided into regional ISPs and local or consumer ISPs, the former being larger organizations whose primary customers are the local ISPs, who in turn sell network connections to the end users. This distinction is somewhat blurred however, because large consumer ISPs, such as AT&T or British Tele- com, often act as their own regional ISPs (and some may be backbone providers as well.

There is a certain amount of human oversight involved, to make sure the system keeps running smoothly, but no “Internet government” is needed to steer things from on high; the system organizes itself by the combined actions of many local and essentially autonomous computer systems. While this is an excellent feature of the system from the point of view of robustness and flexibility, it is a problem for those who want to study the structure of the Internet.

There are two primary methods for doing this. The first uses “traceroute”; the second uses BGP.

### Measuring Internet Structure Using Traceroute

There is currently no simple means by which to probe the network structure of the Internet directly. We can, however, quite easily discover the particular path taken by data packets sent from one computer to another on the Internet. The standard tool for doing this is called traceroute.

Each Internet data packet contains, among other things, a destination ad- dress, which says where it is going; a source address, which says where it started from; and a time-to-live (TTL). The TTL is a number that specifies the maximum number of hops that the packet can make to get to its destination, a hop being the traversal of one edge in the network. At every hop, the TTL is decreased by one, and if it reaches zero the packet is discarded, meaning it is deleted and not forwarded any further over the network.

First, we send out a packet with the destination address of the network node we are interested in and a TTL of 1. The packet makes a single hop to the first router along the way, its TTL is decreased to 0, the packet is discarded by the router, and a message is returned to us telling us, among other things, the IP address of the router. We record this address and then repeat the process with a TTL of 2. This time the packet makes two hops before dying and the returned message tells us the IP address of the second router along the path. The process is repeated with larger and larger TTL until the destination is reached, and the set of IP addresses received as a result tells us the entire route taken to get there. On many operating systems the tool that does this is called “traceroute.” (Note: On the Windows operating system it is called “tracert.” On some Linux systems it is called “tracepath”)

Once one has a suitable set of traceroute paths, a simple union of them gives us our snapshot of the network structure. But this procedure will find all the edges in the network, and for studies based on small numbers of sources there can be significant biases in the sampling of edges. It is the structure of the network at the router level that is responsible for most aspects of the performance, robustness, and efficiency of the network, that dictates the patterns of traffic flow on the network, and that forms the focus of most work on Internet structure and design.An example of a study of the topology of the Internet at the router level is that of Faloutsos et al., who looked at the “degree distribution” of the network and discovered it to follow, approximately, a power law.

A subnet is a group of IP addresses defined as follows. IP addresses consist of four numbers, each one in the range from 0 to 255 (eight bits in binary) and typically written in a string separated by periods or dots. Since all the addresses in a class C subnet are usually allocated to the same organization, a reasonable way of coarse-graining the Internet’s network structure is to group nodes into class C subnets. This will group together nodes in the same organization, although larger organizations, like the University of Michigan, may own more than one class C subnet, so there will still be more than one node in the coarse-grained network corresponding to such organizations.

The second common type of coarse-graining is coarse-graining at the do- main level. A domain is a group of computers and routers under, usually, the control of a single organization and identified by a single domain name, normally the last two or three parts of a computer’s address when the address is written in human-readable text form. The name of the domain to which a computer belongs can be determined from the computer’s IP address by a “reverse DNS lookup,” a network service set up to provide precisely this type of information. Thus, given the network topology in terms of IP addresses, it is a straightforward task to determine the domain to which each IP address belongs and group nodes in the network according to their domain. Then an edge is placed between two nodes if any IP address in one has a direct network connection to any address in the other.

### Measuring Internet Structure Using Routing Tables

Internet routers maintain routing tables that allow them to decide in which direction incoming packets should be sent to best reach their destination. For efficient calculation of routes using BGP it is highly desirable that routers be aware of the entire path to each destination, and since the earliest days of the Internet all routers have operated in this way.

An autonomous system (or AS) is a collection of routers, computers, or other devices, usually under single administrative control, within which data routing is handled independently of the wider Internet—when a data packet arrives at a router belonging to an autonomous system, it is the responsibility of the autonomous system to get the packet the last few steps to its final destination. However, data passing between autonomous systems is handled by the Internet-wide mechanisms of BGP.

We must first obtain a set of router tables, which is normally done simply by asking router operators for access to their tables. Each router table contains a large number of paths starting from a single source, and the union of the paths from many routers gives a good, though not complete, network snapshot in which the nodes are autonomous systems and the edges are the connections between autonomous systems.

## The Telephone Network

There are other technological networks that are of interest, including the telephone network and various distribution and transportation networks, and we look at some of these in the remainder of this chapter. Networks such as software call graphs and electronic circuits could also be considered technological networks and have been studied occasionally, but are beyond the scope of this book.

The structure of the phone network is known in principle, but the data are largely proprietary to the telephone companies that operate the network and, while not precisely secret, they are not openly shared with the research community in the same way that Internet data are. The telephone network is a circuit-switched network, which means that the telephone company has a number of lines or circuits available to carry telephone calls between different points and it assigns them to individual callers when those callers place phone calls. Since the early part of the twentieth century, however, phone companies have employed techniques for multiplexing phone signals, i.e., sending many calls down the same wire simultaneously. The exception is the “last mile” of connection to the individual subscriber.

Most countries with a mature landline telephone network use a three-tiered design. In particular, at the trunk level a lot of telephone networks are no longer circuit switched. Instead they are now digital packet-switched networks that work in a manner not dissimilar to the Internet, with voice calls being digitized, broken into packets, and transmitted over optical fiber links.

## Power Grids

The power grid is the network of high-voltage transmission lines that provide long-distance transport of electric power within and between countries. The networks are usually overseen by a single authority and complete maps of grids are readily available. There is much of interest to be learned by looking at the structure of power grids.

## Transportation Networks

Airline networks can be reconstructed from published airline timetables, road and rail networks from maps. One of the earliest examples of a study of a transportation network is the 1965 study by Pitts of waterborne transport on Russian rivers in the Middle Ages. More recently, a number of authors have produced studies applying new network analysis ideas to road, rail, air, and sea transportation networks.

For instance, in studies of road networks the nodes usually represent road intersections and the edges roads. The study by Sen et al. argue, plausibly, that in the context of rail travel what matters to most people is whether there is a direct train to their destination or, if there is not, how many trains they will have to take to get there. People do not care so much about how many stops there are along the way, so long as they don’t have to change trains. Thus, Sen et al. argue, a useful network representation in the case of rail travel is one in which the nodes represent locations and two nodes are connected by an edge if a single train runs between them. Then the distance between two nodes in the network—the number of edges you need to traverse to get from A to B—is equal to the number of trains you would have to take

## Delivery And Distribution Networks

Distribution networks include things like oil and gas pipelines, water and sewerage lines, and the routes used by the post office and package delivery companies.
