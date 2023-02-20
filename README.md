# Preparatory work for Danish laws

A text corpus comprising 19th century preparatory work for Danish laws, i.e. proposed
legalislation.  Among these are the documents that eventually became the
Danish Constitution.

Origin: We got a dump from a SQL text database behind the old sites 
grundlov.dab.dk and retsplejelov.kb.dk.  These text sources contained
text snippets per page in a homemade "sort of TEI" format.

There are 6727 of those in the directory [text-sources](text-sources)

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
doing so, transforms them into [Text Encoding Initiative XML
(TEI)](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html).

We believe that expect the whole corpus will be good enough for search and
presentation in spite of the fact that they are wanting in markup as
well as proofreading.

Note that the corresponding facsimiles are stored in KB's "preingest" repository.