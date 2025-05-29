#!/usr/bin/perl

#******************************************************************************
#* This Program Trims All Blank Spaces at The End of Text The File Lines.
#* 
#* Author: Carlos Kassab, E-Mail: laran.ikal@gmail.com
#*
#******************************************************************************

use warnings;
use strict;


# Variables declaration.
my $continue_Loop = "0";
my $file_Name = "";
my $new_File_Name = "";
my @file_Name_Parts = ();
my @file_To_Clean = ();
my @new_File_Content = ();

if ($#ARGV == -1) {
  print "This Program Trims All Blank Spaces at The End of Text The File Lines.\n";

  print "\nIt Was Used During Data Migrations From BaaN IV to BaaN V.\n";
  print "Because BaaN Was Only Recognizing Encoding ISO-8859-1\n";
  print "The Input File Must Use Encoding ISO-8859-1\n";

  print "\nYou can run this program by Providing The File Name on The Command Line:\n";
  print "usage : perl RightTrimFileLines.pl <Text File Name>\n";

  print "\nNote. The Cleaned File Name will be in ISO-8859-1: <Text File Name To Be Cleaned>_cleaned\n\n\n";

  while(!$continue_Loop) {
    print "Enter Text File Name To Trim Blank Spaces at The End of Each Line or Q to quit:\n";
    print "File Name Must be More Than 3 Character Long.\n";
    $file_Name = <>;
    $file_Name =~ s/\n//g;
    $continue_Loop = "exit" if (length($file_Name) > 3 || $file_Name eq "Q");
  }
  exit if ( $file_Name eq "Q" );
} else {
  $file_Name = $ARGV[0];
}


# Open file converting to ISO-8859-1
open (fileToClean,'<:encoding(ISO-8859-1)', $file_Name) or die "Error Opening File:$file_Name, Possible Encoding is Not ISO-8859-1";
  @file_To_Clean=<fileToClean>;
close (fileToClean);

@file_Name_Parts = split('\.',$file_Name);

foreach (@file_To_Clean)
{
	chop;
  $_ =~ s/\s+$//g; #remove trailing spaces
  push(@new_File_Content, $_ . "\n");
}

open (trimmedFile, ">".$file_Name_Parts[0]."_Trimmed.txt");
	print trimmedFile @new_File_Content;
close (trimmedFile);

