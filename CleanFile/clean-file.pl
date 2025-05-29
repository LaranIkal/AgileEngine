#!/usr/bin/perl

#******************************************************************************
#* This Program Search Unrecognized Characters From Text Files
#* And Sets The Correct Values.
#* 
#* Author: Carlos Kassab, E-Mail: laran.ikal@gmail.com
#*
#* Notes: Ensure this program is saved using encoding: ISO-8859-1
#*   in Order to be Able to Work With Files Using Encoding ISO-8859-1
#******************************************************************************

use warnings;
use strict;
#use Encode;

# Variables declaration.
my $continue_Loop = "0";
my $file_Name = "";
my $new_File_Name = "";
my @file_To_Clean = ();

if ($#ARGV == -1) {
  print "This Program Search Unrecognized Characters From Text Files Using Encoding ISO-8859-1\n";
  print "And Sets The Correct Values. \n"; 

  print "\nIt Was Used During Data Migrations From BaaN IV to BaaN V\n";
  print "Because BaaN Was Only Recognizing Encoding ISO-8859-1\n";
  print "The Input File Must Use Encoding ISO-8859-1\n";

  print "\nThe Process Also Deletes Non Printing Characters From File.\n";

  print "\nYou can run this program by Providing The File Name on The Command Line:\n";
  print "usage : perl clean-file.pl <Text File Name To Be Cleaned>\n";

  print "\nNote. The Cleaned File Name will be in ISO-8859-1: <Text File Name To Be Cleaned>_cleaned\n\n\n";

  while(!$continue_Loop) {
    print "Enter Text File Name To Be Cleaned or Q to quit:\n";
    print "File Name Must be More Than 3 Character Long.\n";
    $file_Name = <>;
    $file_Name =~ s/\n//g;
    $continue_Loop = "exit" if (length($file_Name) > 3 || $file_Name eq "Q");
  }
  exit if ( $file_Name eq "Q" );
} else {
  $file_Name = $ARGV[0];
}

$new_File_Name = $file_Name."_cleaned";

# Open file converting to ISO-8859-1
open (fileToClean,'<:encoding(ISO-8859-1)', $file_Name) or die "Error Opening File:$file_Name, Possible Encoding is Not ISO-8859-1";
  @file_To_Clean=<fileToClean>;
close (fileToClean);

# Cleaning Each Line in The File.
foreach(@file_To_Clean) {

  s/�/-a-/g;
  s/�/-e-/g;
  s/�/-i-/g;
  s/�/-o-/g;
  s/�/-u-/g;

  s/�/--A--/g;
  s/�/--E--/g;
  s/�/--I--/g;
  s/�/--O--/g;
  s/�/--U--/g;

  s/�/---a/g;
  s/�/---e/g;
  s/�/---i/g;
  s/�/---o/g;
  s/�/---u/g;

  s/�/---A/g;
  s/�/---E/g;
  s/�/---I/g;
  s/�/---O/g;
  s/�/---U/g;

  s/�/--c--/g;

  s/�/--n--/g;
  s/�/--N--/g;

  s/[^[:print:]]//g;

# After cleaning, restore characters.

  s/--c--/�/g;
  s/--n--/�/g;
  s/--N--/�/g;

  s/-a-/�/g;
  s/-e-/�/g;
  s/-i-/�/g;
  s/-o-/�/g;
  s/-u-/�/g;

  s/--A--/�/g;
  s/--E--/�/g;
  s/--I--/�/g;
  s/--O--/�/g;
  s/--U--/�/g;

  s/---a/�/g;
  s/---e/�/g;
  s/---i/�/g;
  s/---o/�/g;
  s/---u/�/g;

  s/---A/�/g;
  s/---E/�/g;
  s/---I/�/g;
  s/---O/�/g;
  s/---U/�/g;

}

# Adding new line character that was deleted at the end of each line.
foreach(@file_To_Clean) {
	$_ = $_."\n";
}

open (cleanedFile, ">$new_File_Name");
print cleanedFile @file_To_Clean;
close (cleanedFile);

