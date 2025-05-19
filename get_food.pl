#!/usr/bin/perl

use warnings;
use strict;

# Variables declaration.
my $continue_loop = "0";
my $file_name = "";
my $food = "";
my @food_file = ();


while(!$continue_loop){
  print "Dataset File Name or Q to quit:";
  $file_name = <>;
  $file_name =~ s/\n//g;
  $continue_loop = "exit" if (length($file_name) > 3 || $file_name eq "Q");
}

exit if ($file_name eq "Q");

$continue_loop = "0";
while(!$continue_loop){
  print "Food to search or Q to quit(It is asking for food, but it will search all line):";
  $food = <>;
  $food =~ s/\n//g;
  $continue_loop = "exit" if (length($food) > 3 || $food eq "Q");
}

exit if ($food eq "Q");

if( open (food_file, $file_name)) {
  @food_file=<food_file>;
  close (food_file);
} else {
  print "File not found.\n";
  exit;
}

# One way to do it
#foreach(@food_file) {
#  if( $_ =~ /$food/ ) {
#    print "Food found:$food \n";
#    print $_;
#  }
#}

# Shorter.
foreach(@food_file) { 
  print "Food found:$food \n $_" if $_ =~ /$food/; 
}



