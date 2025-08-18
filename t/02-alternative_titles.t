#!perl

####################
# LOAD CORE MODULES
####################
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::MockObject;
use HTTP::Tiny;
use TMDB;

# Autoflush ON
local $| = 1;

# Mocking client
my $mock = Test::MockObject->new;
$mock->set_isa('HTTP::Tiny');
$mock->set_always( 'get', { success => 'ok' , content => '{"titles": []}' } );


my $tmdb = TMDB->new( apikey => 'fake-api-key', client => $mock);
my $movie = $tmdb->movie(id => 1234);
my $show = $tmdb->tv(id => 1234);

isa_ok ($movie->alternative_titles, 'ARRAY', '$movie->alternative_titles');
isa_ok ($show->alternative_titles, 'ARRAY', '$show->alternative_titles');

TODO: {
    local $TODO = "Known bug";
    
    isa_ok ($movie->alternative_titles('US'), 'ARRAY', '$movie->alternative_titles("US")');
    isa_ok ($show->alternative_titles('US'), 'ARRAY', '$show->alternative_titles("US")');
};


# Done
done_testing();
exit 0;
