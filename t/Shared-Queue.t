# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Shared-Queue.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 38;
BEGIN { use_ok('Shared::Queue') };

my $file = "/tmp/Shared-Queue".rand().".dat";
my $q = new Shared::Queue(file=>$file,queue=>10,length=>12);

my $str6 = "012345";
my $str12 = "012345678901";
my $str18 = "012345678901234567";
my $str200 = "0123456789" x 20;
my $str80 = "0123456789" x 8;

my($t,$b) = $q->stat;
is($t,0);
is($b,0);
is($q->length,0);

$q->push($str6);
($t,$b) = $q->stat;
is($t,0);
is($b,1);
is($q->length,1);

$q->push($str12);
($t,$b) = $q->stat;
is($t,0);
is($b,2);
is($q->length,2);

$q->push($str18);
($t,$b) = $q->stat;
is($t,0);
is($b,4);
is($q->length,4);

is($q->pop,$str6);
($t,$b) = $q->stat;
is($t,1);
is($b,4);
is($q->length,3);

is($q->pop,$str12);
($t,$b) = $q->stat;
is($t,2);
is($b,4);
is($q->length,2);

is($q->pop,$str18);
($t,$b) = $q->stat;
is($t,4);
is($b,4);
is($q->length,0);

is($q->pop,undef);
($t,$b) = $q->stat;
is($t,4);
is($b,4);
is($q->length,0);

is($q->push($str200),undef);

$q->push($str80);
($t,$b) = $q->stat;
is($t,4);
is($b,1);
is($q->length,7);

$q->push($str80);
($t,$b) = $q->stat;
is($t,1);
is($b,8);
is($q->length,7);

is($q->pop,$str80);
is($q->pop,undef);

unlink $file;


#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

