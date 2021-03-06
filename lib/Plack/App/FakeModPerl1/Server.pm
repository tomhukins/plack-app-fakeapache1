package Plack::App::FakeModPerl1::Server;

# ABSTRACT: Mimic Apache mod_perl1's server
use strict;
use warnings;
use 5.10.1;
use Carp;

=head2 new

=cut
sub new {
    my $class = shift;
    bless {@_}, $class;
}

our $AUTOLOAD;

sub AUTOLOAD {
    my $what = $AUTOLOAD;
    $what =~ s/.*:://;
    carp "!!server->$what(@_)" unless $what eq 'DESTROY';
}

=head2 dir_config

=cut
sub dir_config {
    my ( $self, $c ) = @_;

    # Translate the legacy WebguiRoot and WebguiConfig PerlSetVar's into known values
    return $self->{env}->{'wg.WEBGUI_ROOT'} if $c eq 'WebguiRoot';
    return $self->{env}->{'wg.WEBGUI_CONFIG'} if $c eq 'WebguiConfig';

    # Otherwise, we might want to provide some sort of support (which Apache is still around)
    return $self->{env}->{"wg.DIR_CONFIG.$c"};
}

1;
