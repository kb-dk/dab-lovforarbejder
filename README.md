# Some Danish bills

A text corpus comprising 19th century bills, i.e., proposed
legalislation.  Among these are the bills that eventually became the
Danish Constitution.

I got a dump from a text database somewhere, with text snippets per
page. There are 6727 of those in the directory [text-sources](text-sources)

The text source pages have a bit too creative markup lacking coherence
and stringence. For instance there are at least 11 kinds of `head elements`

* title
* middle
* btitle
* dtitle
* htitle
* lowtitle
* maintitle
* stitle
* subtitle
* undertitle
* wtitle

The script [run-sequence.sh](run-sequence.sh) assembles those pages
into 33 volumes stored in the directory [volumes](volumes), and while
doing so, transforms them into [Text Encoding Initiative xml
(TEI)](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html).

I expect the whole corpus will be good enough for search and
presentation in spite of the fact that they are wanting in markup as
well as proofreading.




