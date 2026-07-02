use lib $ENV{PERL5LIB};
use Bio::DB::GenBank;
use Bio::DB::Query::GenBank;

$query = "Arabidopsis[ORGN] AND topoisomerase[TITL] and 0:3000[SLEN]"; 
$query_obj = Bio::DB::Query::GenBank->new(-db => 'nucleotide', 
                                          -query => $query );

$gb_obj = Bio::DB::GenBank->new;

$stream_obj = $gb_obj->get_Stream_by_query($query_obj);

while ($seq_obj = $stream_obj->next_seq) {
    # do something with the sequence object    
    print $seq_obj->display_id, "\t", $seq_obj->length, "\n";
}
