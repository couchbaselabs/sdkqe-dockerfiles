#!/usr/bin/env perl
use strict;
use warnings;

my %serviceName = (
        "8091"  => "mgmt",
        "18091" => "mgmtSSL",
        "8095"  => "cbas",
        "18095"  => "cbasSSL",
        "8096" => "eventingAdminPort",
        "18096" => "eventingSSL",
        "8094" => "fts",
        "18094" => "ftsSSL",
        "18092" => "capiSSL",
        "8092" => "capi",
        "11210" => "kv",
        "11207" => "kvSSL",
        "8093" => "n1ql",
        "18093" => "n1qlSSL"
);
my @containers = `docker ps -q`;
my ($mapped);
chomp @containers;

foreach my $container (@containers)
{
        $mapped = `docker inspect -f '{{.NetworkSettings.IPAddress }} - {{index .NetworkSettings.Ports}}' $container`;

        if ($mapped =~ /^([0-9]+\.[0-9]+\.[0-9]+\.[0-9])/) {
                my $restHost = $1;
                my $data = "";
                while ($mapped =~ /([0-9]+)\/tcp:\[\{[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ([0-9]+)/g) {
                        if (defined $serviceName{$1}) {
                                $data .= "&$serviceName{$1}=$2";
                        }
                }
                if ($data ne "") {
                        $data = "hostname=$ENV{'HOST_IP'}".$data;
                        my $cmd = "curl -X PUT -u Administrator:password -d \"$data\" http://$restHost:8091/node/controller/setupAlternateAddresses/external";
                        print "$cmd\n";
                        `$cmd`;
                }
        }
}
