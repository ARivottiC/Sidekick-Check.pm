#!/usr/bin/perl
package Sidekick::App::Check;

use v5.10;

use strict;
use warnings;
use mro;

use Sidekick::Check;

use Log::Log4perl qw(:nowarn);

my $logger = Log::Log4perl->get_logger();

sub check {
    my $self   = shift;
    my $method = shift
        || return 'Sidekick::Check';

    return Sidekick::Check->$method( @_ );
}

1;
# ABSTRACT: Sidekick::App's interface for Sidekick::Check
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use parent qw(
            Sidekick::App
            Sidekick::App::Check
            ...
        );

=head1 DESCRIPTION

Adds a check method to a Sidekick::App.

=cut
