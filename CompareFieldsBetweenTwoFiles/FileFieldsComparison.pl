#!/usr/bin/perl

#******************************************************************************
#* This Program Compares Two Fields From Two Files And Creates a New File
#* With The Field Values Not Found in The File to Compare.
#*
#* Author: Carlos Kassab, E-Mail: laran.ikal@gmail.com
#*
#******************************************************************************

use warnings;
use strict;

# Variables declaration.
my $continue_Loop = "0";
my $file_Name = "";
my $field_number = "";
my $compare_to_file_Name = "";
my $field_number_to_compare = "";
my @file_Name_Parts = ();
my @file_For_Comparison = ();
my @file_To_Compare = ();
my @new_File_Content = ();
my $line_Counter = 0;

print "This Program Compares Two Fields From Two Files And Creates a New File\n";
print "With The Field Values Not Found in The File To Compare.\n";

while(!$continue_Loop) {
  print "Enter Text File Name For Comparison or Q to quit:\n";
  print "File Name Must be More Than 3 Character Long.\n";
  $file_Name = <>;
  $file_Name =~ s/\n//g;
  $continue_Loop = "exit" if (length($file_Name) > 3 || $file_Name eq "Q");
}
exit if ( $file_Name eq "Q" );

$continue_Loop = "0";
while(!$continue_Loop) {
  print "Enter The Field Position/Number For Comparison or Q to quit:\n";
  print "The Field Number Must Start With 0 \n";
  $field_number = <>;
  $field_number =~ s/\n//g;
  $continue_Loop = "exit" if (length($field_number) > 0 || $field_number eq "Q");
}
exit if ( $field_number eq "Q" );

$continue_Loop = "0";
while(!$continue_Loop) {
  print "Enter Text File Name To Compare or Q to quit:\n";
  print "File Name Must be More Than 3 Character Long.\n";
  $compare_to_file_Name = <>;
  $compare_to_file_Name =~ s/\n//g;
  $continue_Loop = "exit" if (length($compare_to_file_Name) > 3 || $compare_to_file_Name eq "Q");
}
exit if ( $compare_to_file_Name eq "Q" );

$continue_Loop = "0";
while(!$continue_Loop) {
  print "Enter The Field Position/Number To Compare or Q to quit:\n";
  print "The Field Number Must Start With 0 \n";
  $field_number_to_compare = <>;
  $field_number_to_compare =~ s/\n//g;
  $continue_Loop = "exit" if (length($field_number_to_compare) > 0 || $field_number_to_compare eq "Q");
}
exit if ( $field_number_to_compare eq "Q" );

# Open file converting to ISO-8859-1
open (fileForComparison,'<:encoding(ISO-8859-1)', $file_Name) or die "Error Opening File: $file_Name, Possible Encoding is Not ISO-8859-1";
  @file_For_Comparison=<fileForComparison>;
close (fileForComparison);

# Open file converting to ISO-8859-1
open (fileToCompare,'<:encoding(ISO-8859-1)', $compare_to_file_Name) or die "Error Opening File: $compare_to_file_Name, Possible Encoding is Not ISO-8859-1";
  @file_To_Compare=<fileToCompare>;
close (fileToCompare);


@file_Name_Parts = split('\.',$file_Name);
open (NEWFILE, ">", $file_Name_Parts[0] . "_With_Different_Field_Values.txt");
	
print NEWFILE "File For Comparison Line Number - Field Value\n";

foreach(@file_For_Comparison)	{		
  my @all_Fields = split('\|',$_);
  my $field_Value = $all_Fields[$field_number];
  $line_Counter +=1;
  print "Line Number, Field value: $line_Counter, $all_Fields[$field_number]\n";

  my $found = 0;
  for ( my $i=0; $i<@file_To_Compare; $i++) {
    my @fields_To_Compare = split('\|',$file_To_Compare[$i]);
    $found = 1 if($all_Fields[$field_number] eq $fields_To_Compare[$field_number_to_compare]);
  }

  print NEWFILE "$line_Counter - $all_Fields[$field_number]\n" if($found == 0); # Not found
}
close(NEWFILE);

