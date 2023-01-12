#!/usr/bin/perl -w

use strict;

my $vol_dir = "volumes";

my $start = '<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">';
my $end   = '</TEI>';

my $last_vol = "new";

open my $PAGES,"find text-sources -type f -name '*.txt' -print | sort |" or die "cannot open pipe from find: $@ \n";

while(my $file = <$PAGES>) {
    chomp $file;
    $file =~ m/(text-sources\/)(.+?)(.txt$)/;
    my $page_id = $2;

    # print "$page_id\n";

    if($page_id =~ m/((g|r)\d\d)/) {

	my $volume_id = $1;

	if($last_vol ne 'new' && $volume_id ne $last_vol) {
	    my $f = "$vol_dir/$last_vol" . ".xml";
	    open my $v, ">>$f" or die "cannot open last volume file $f";
	    print $v $end;
	    close $v;
	}

	open my $source, "<$file" or die "cannot open page $file\n";
	open my $volume, ">>$vol_dir/$volume_id" . ".xml"
	    or die "cannot open page $volume_id file\n";
	
	my $text = "";
	my $pp = 0;
	while(my $line = <$source>) {
	    next if($line =~ m/<pb/);
	    next if($line =~ m/<\/pb/);
	    $line =~ s/&nbsp;/ /g;
	    $line =~ s/<pt>/<tp>/g;
	    $line =~ s/<\/pt>/<\/tp>/g;
	    $line =~ s/<</</g;
	    $line =~ s/”/"/g;
	    $line =~ s/<undertitloe>/<undertitle>/;
#	    $line =~ s/<\/?underpage>//;
	    $line =~ s/<\/?rightside>//;
	    $line =~ s/<\/?leftside>//;
	    $line =~ s/<\?\././;
	    $line =~ s/\s&\s/ &amp;/g;
	    $line =~ s/<\/lb>/ /g;
	    
	    $text .= $line;

	}
	print $volume $start if($volume_id ne $last_vol);
	print $volume "<?page  $page_id ?>\n";
	print $volume "<div>$text</div>";

	close $source;
	close $volume;
	
	print "done with $volume_id $page_id\n";
	$last_vol = $volume_id;
    }
    
}

open my $volume, ">>$vol_dir/$last_vol" . ".xml"
    or die "cannot open page $last_vol file\n";

print $volume $end;

close $volume;
