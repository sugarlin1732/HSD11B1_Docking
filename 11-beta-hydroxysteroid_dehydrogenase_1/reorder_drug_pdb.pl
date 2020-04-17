use strict;

($#ARGV != 0)?
	die "Please give your pdb filename.\n":
	open(INF, "$ARGV[0]") || die "Can't open $ARGV[0].\n";
	
my $order = 1;
my %num_class;

while(my $line=<INF>){
	if($line =~ /^ATOM/ || $line =~ /^HETATM/){
		my @word=split(//, $line);
		my $name;
		for(my $i=13; $i<=15; $i++){
			if($word[$i] ne ' '){
				$name.=$word[$i];
			}
			else{
				last;
			}
		}
		if(exists $num_class{$name}){
			$num_class{$name}++;
		}
		else{
			$num_class{$name} = 1;
		}
		my @reorder = split(//, $num_class{$name});
		for(my $i=13; $i<=15; $i++){
			if($word[$i] eq ' '){
				if($#reorder >=0){
					$word[$i] = shift @reorder;
				}
			}
		}

		print @word;
	}
	else{
		print $line;
	}

}