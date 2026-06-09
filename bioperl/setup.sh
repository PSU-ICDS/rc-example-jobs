#!/bin/bash

# set up user-level perl library
mkdir -p ~/perl5/lib/perl5
cpanm --local-lib=~/perl5 local::lib

# install Bio::DB::GenBank
perl -I$HOME/perl5/lib/perl5 -Mlocal::lib
cpanm Bio::DB::GenBank
