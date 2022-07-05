@def title = "Information Networks"

# Networks of Information

This chapter focuses on networks of information, networks consisting of items of data linked together in some way. Information networks are all, so far as we know, man-made, with perhaps the best known example being the World Wide Web. As we shall see, the classification of networks as information networks, social networks, and so forth is a fuzzy one.

## The World Wide Web

The Web is a network in which the nodes are web pages, containing text, pictures, or other information, and the edges are the hyperlinks that allow us to navigate from page to page; the Web is a network of links between pages of information.

Since hyperlinks run in one direction only, the Web is a directed network. the Web won the battle, largely because its inventors decided to giveaway for free the software technologies on which it was based—the Hypertext Markup Language(HTML) used to specify the appearance of pages and the Hypertext Transport Protocol (HTTP) used to transmit pages over the Internet. A crude estimate of the number of pages on the Web puts that number at around 50 billion at the time of the writing. (Note: This is only the number of reachable static pages. The number of unreachable pages is difficult to estimate, and dynamic pages (see later) are essentially unlimited in number)

The structure of the Web can be measured using a crawler--a program that automatically surfs the Web looking for pages. In its simplest form, the crawler performs a so-called breadth-first search on the web network. By repeating the process of downloading and URL extraction for a suitably long period of time, one can find a significant portion of the pages on the entire Web.

No web crawler, however, finds all the pages on the Web, for a number of reasons. First, some websites forbid crawlers to examine their pages. Websites can place a file called robots.txt in their root directory that specifies which files, if any, crawlers can look at and may optionally specify that some crawlers are allowed to look at files while others are not. Compliance with the restrictions specified in a robots.txt file is voluntary, but in practice many crawlers do comply. Second, many pages on the Web are dynamically generated: they are created on the fly by special software using, for instance, data from a database.

As a result, the number of possible web pages that can be displayed as a result of a web search is so large as to be effectively infinite. Since the Web is a directed network, not all pages are reachable from a given starting point

## Citation Networks

A less well-known but much older information network is the network of citations between academic papers. Most papers reference one or more previous works, usually in a bibliography at the end of the paper, and one can construct a network in which the nodes are papers and there is a directed edge from paper A to paper B if A cites B in its bibliography.

Quantitative studies of citation networks go back to the 1960s; perhaps the earliest is the 1965 study by Price. An example of software systems that compile citation indexes automatically without human oversight have started to appear is Google Scholar, the academic literature arm of the Google search engine. As with web crawls, the original purpose of citation indexes was not to measure network structure. Citation indexes are assembled primarily to allow researchers to discover by whom a paper has been cited, and hence to find research related to a topic of interest.

There is, however, at least one important difference between a citation net- work and the Web: a citation network is acyclic, while the Web is not.

Citation networks have some interesting statistics. For instance, one study found that about 47% of all papers have never been cited at all. Only 21% of all papers have 10 or more citations, and just 1% have 100 or more. These figures are a consequence of the power-law degree distribution of the network.

## Other Information Networks

### Peer-to-Peer Networks

When a user instructs his or her computer to search the network for a specific file, the computer sends out a message to its network neighbors asking whether they have that file. If they do, they arrange to transmit it back to the user. If they do not, they pass the message on to their neighbors, and so forth until the file is found. The networks appear to have approximately power-law degree distributions and it has been suggested that this property could be exploited to improve search performance.

### Keyword Indexes

Another type of information network, also bipartite in form, is the keyword index.
