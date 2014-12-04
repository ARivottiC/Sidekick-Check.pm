# NAME

Sidekick::Check - Plugin based validation mechanism

# VERSION

version 0.0.1

# SYNOPSIS

    my $sc = Sidekick::Check->new();

    my $ok       = $sc->is( $value, 'filled', [ 'length', 10 ] );
    my @errors   = $sc->errors( $value, 'defined', sub { $_[1] eq 'test' } );
    my $lengthok = $sc->is_length( $value, 10 );

# DESCRIPTION

`Sidekick::Check` provides a simple interface to handle validations and the ability to add additional plugins in a easy manner.

# METHODS

## new

Returns 'Sidekick::Check'.

## is

    my $ok = $sc->is( $value, @checks );

Returns 1 if all checks passed.

See ["errors"](#errors).

## errors

    my @errors = $sc->errors( $value, 'defined', sub { $_[1] =~ /^\w+$/ }, )
    my $error  = $sc->errors(
            $value,
            [ 'length', 10 ],
            {
                'is'   => \&sub,
                'args' => [ 1, 2 ],
                'name' => 'special_test',
            },
        );

Returns an array of failed checks. In SCALAR context, returns the first error and exits.

### Allowed check types:

#### ARRAY

    @errors = $sc->errors( ..., [ 'length', 10 ] );
    @errors = $sc->errors( ..., [ \&sub, 1, 2, 3 ] );

An array ref with the check to use and the arguments to pass.

#### CODE

    @errors = $sc->errors( ..., \&sub );
    @errors = $sc->errors( ..., sub { ... } );

An anonymous subroutine or a reference to one. Must return 1 for success.

#### HASH

    @errors = $sc->errors( ..., { 'is' => 'filled' } );
    @errors = $sc->errors( ..., { 'is' =>  \&sub, 'args' => [...], 'name' => 'teste' } );

A hash ref with the following keys:

**is**
The check to use.

**args**
The arguments to use with check.

**name**
The name that is returned on error. This is specially usefull with anonymous subroutines.

#### SCALAR

    @errors = $sc->errors( ..., 'defined' );

The name of the plugin to use.

## is\_\*

    my $defined  = $sc->is_defined( $value );
    my $lengthok = $sc->is_length( $value, 10 );

All plugins are mapped as a is\_\* method in Sidekick::Check. See ["PLUGINS"](#plugins).

# PLUGINS

    package Sidekick::Check::Plugin::NAME

    sub check {
        my $self  = shift; # 'Sidekick::Check'
        my $value = shift; # the value to validate
        my @args  = @_   ; # additional args

        # return 0 if it fails, otherwise 1.
        ...
    }

# SEE ALSO

- [Sidekick::Check::Plugin::Defined](https://metacpan.org/pod/Sidekick::Check::Plugin::Defined)
- [Sidekick::Check::Plugin::Filled](https://metacpan.org/pod/Sidekick::Check::Plugin::Filled)

# AUTHOR

André Rivotti Casimiro <rivotti@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by André Rivotti Casimiro.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
