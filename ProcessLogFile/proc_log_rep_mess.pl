#!/usr/bin/perl

#******************************************************************************
#* This Program Filters All Duplicated Log Messages And Creates an Output File
#* That Can be Open Using Excel.
#*
#* Author: Carlos Kassab, E-Mail: laran.ikal@gmail.com
#*
#******************************************************************************

use warnings;
use strict;


# Variables declaration.
my $continue_Loop = "0";
my $file_Name = "";
my @error_Log_File = ();
my $result_File_Name = "";
my $text_To_Find = "";
my @file_Name_Parts = ();

print "This Program Filters All Duplicated Log Messages And Creates an Output File\n";
print "That Can be Open Using Excel.\n";

while(!$continue_Loop) {
  print "Enter Log Text File Name For Filtering or Q to quit:\n";
  print "File Name Must be More Than 3 Character Long.\n";
  $file_Name = <>;
  $file_Name =~ s/\n//g;
  $continue_Loop = "exit" if (length($file_Name) > 3 || $file_Name eq "Q");
}
exit if ( $file_Name eq "Q" );

$continue_Loop = "0";
while(!$continue_Loop) {
  print "Error or Part of Error Message to Find or Q to quit:\n";
  $text_To_Find = <>;
  $text_To_Find =~ s/\n//g;
  $continue_Loop = "exit" if (length($text_To_Find) > 3 || $text_To_Find eq "Q");
}
exit if ( $text_To_Find eq "Q" );

# Open file converting to ISO-8859-1
open (ERRORLOG,'<:encoding(ISO-8859-1)', $file_Name) or die "Error Opening File:$file_Name, Possible Encoding is Not ISO-8859-1";
  @error_Log_File=<ERRORLOG>;
close (ERRORLOG);


#Create output error file
@file_Name_Parts = split('\.',$file_Name);
open (OUTERRFILE, ">", $file_Name_Parts[0] . "_Filtered.xls");
print OUTERRFILE "<table border=1>\n";
print OUTERRFILE "<tr><td><b>Line Number</b></td><td><b>Line Text</b></td></tr>\n";

foreach my $index (0 .. $#error_Log_File) {
  if ($error_Log_File[$index] =~ /$text_To_Find/) {
    print OUTERRFILE "<tr><td>$index</td><td>$error_Log_File[$index]</td></tr>\n";
  }
}

print OUTERRFILE "</table>";	
close (OUTERRFILE);



