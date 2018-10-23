#!/usr/bin/perl -w
use strict;
use warnings;
use FindBin qw($Bin);
use Getopt::Long;
use Cwd;
use File::Basename;

my($contig,$reads,$outdir,$assembler,$type,$queue);
my $python3="/media/data/software/python/Python_v3.6/bin";
my $bwa="/media/data/software/bwa/bwa-0.7.15/";
my $mummer="/media/data/software/mummer/MUMmer3.23/";
my $prodigal="/media/data/software/prodigal/Prodigal-2.60/";#v2.6.3
my $samtools="/media/data/software/samtools/samtools-1.3.1/bin/";
my $canu="/media/data/software/canu/canu-1.7/Linux-amd64/bin/";
my $spades="/media/data/software/SPAdes/SPAdes-3.11.1-Linux/bin/";
my $qsub="/public/hstore1/works/yangxinchao/OE2018H0675V/qsub-pbs.pl";
my $dir||=getcwd;
my $lib="export LD_LIBRARY_PATH=/home/yangxinchao/lib/usr/lib64/:\$LD_LIBRARY_PATH";
$queue||="cu";
$outdir||="$dir/Circlator";
GetOptions(
    "c:s"=>\$contig,
    "r:s"=>\$reads,
    "o:s"=>\$outdir,
    "a:s"=>\$assembler,
    "t:s"=>\$type,
    "q:s"=>\$queue,
           );

sub usage{
    print qq{
 This script will use Circlator to automated circularization of genome assemblies using long sequencing reads.
 url:http://sanger-pathogens.github.io/circlator/
 
usage:
 perl $0 -c assembly.fasta -r reads.fasta -o $outdir -a spades -t pacbio-corrected
 
options:
 -c         Given an assembly assembly.fasta in FASTA format:froce
 -r         corrected PacBio reads in a file:froce
 -o         outputdirectory
 -a         Assembler to use for reassemblies [spades or canu]:force
 -t         data_type {pacbio-raw,pacbio-corrected,nanopore-raw,nanopore-corrected}:froce
 -q         which queue you will run(default:cu)
 
 Email:fanyucai1\@126.com
 2017.7.27
    };
    exit;
}
if(!$contig||!$reads||!$assembler||!$type)
{
    &usage();
}

system "echo 'export PATH=$samtools:$bwa:$spades:$canu:$mummer:$prodigal:$python3\$PATH'>$dir/Circlator.sh";
system "echo '$lib'>>$dir/Circlator.sh";
####################all
system "echo '$python3/circlator all --threads 30 --data_type $type --assembler $assembler $contig $reads $outdir'>>$dir/Circlator.sh";
my $line=`wc -l $dir/Circlator.sh`;
chomp($line);
`perl $qsub --queue $queue --ppn 10 --lines $line $dir/Circlator.sh`;



