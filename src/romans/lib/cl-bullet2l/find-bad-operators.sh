cat dump.xml | \
	perl -ne 'if (/"classtype".*value="(.+?)"/) { $class = $1 } 
	elsif (/operator (([^\(\[\"]+)[^\"\{]*)/ 
		&& $1 ne "new" && $1 ne "delete" && $1 ne "new[]" && $1 ne "delete[]") 
	{ $fn = $1;
	  $op = $2;
	  $op =~ s/([\+\-\*\/])=/set_$1/;
	  $op =~ s/\*/mult/;
	  $op =~ s/\+/add/;
	  $op =~ s/\-/sub/;
	  $op =~ s/\==/equal/;
	  $op =~ s/\=/set/;
	  $op =~ s/\//div/;
	  $fn =~ s/&amp;/&/g;
	  $fn =~ s/;$//;
	  die "$1 no oper?" unless $op;
	  print "%rename (${class}::operator $fn) bullet_${class}_$op\n" }' \
	| sort | uniq 
