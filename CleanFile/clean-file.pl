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

  s/ä/-a-/g;
  s/ë/-e-/g;
  s/ï/-i-/g;
  s/ö/-o-/g;
  s/ü/-u-/g;

  s/Ä/--A--/g;
  s/Ë/--E--/g;
  s/Ï/--I--/g;
  s/Ö/--O--/g;
  s/Ü/--U--/g;

  s/á/---a/g;
  s/é/---e/g;
  s/í/---i/g;
  s/ó/---o/g;
  s/ú/---u/g;

  s/Á/---A/g;
  s/É/---E/g;
  s/Í/---I/g;
  s/Ó/---O/g;
  s/Ú/---U/g;

  s/ç/--c--/g;

  s/ñ/--n--/g;
  s/Ñ/--N--/g;

  s/[^[:print:]]//g;

# After cleaning, restore characters.

  s/--c--/ç/g;
  s/--n--/ñ/g;
  s/--N--/Ñ/g;

  s/-a-/ä/g;
  s/-e-/ë/g;
  s/-i-/ï/g;
  s/-o-/ö/g;
  s/-u-/ü/g;

  s/--A--/Ä/g;
  s/--E--/Ë/g;
  s/--I--/Ï/g;
  s/--O--/Ö/g;
  s/--U--/Ü/g;

  s/---a/á/g;
  s/---e/é/g;
  s/---i/í/g;
  s/---o/ó/g;
  s/---u/ú/g;

  s/---A/Á/g;
  s/---E/É/g;
  s/---I/Í/g;
  s/---O/Ó/g;
  s/---U/Ú/g;

}

# Adding new line character that was deleted at the end of each line.
foreach(@file_To_Clean) {
	$_ = $_."\n";
}

open (cleanedFile, ">$new_File_Name");
print cleanedFile @file_To_Clean;
close (cleanedFile);

