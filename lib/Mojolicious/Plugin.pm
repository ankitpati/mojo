# Copyright (C) 2008-2010, Sebastian Riedel.

package Mojolicious::Plugin;

use strict;
use warnings;

use base 'Mojo::Base';

# This is Fry's decision.
# And he made it wrong, so it's time for us to interfere in his life.
sub register { }

1;
__END__

=head1 NAME

Mojolicious::Plugin - Plugin Base Class

=head1 SYNOPSIS

    use base 'Mojolicious::Plugin';

=head1 DESCRIPTION

L<Mojolicous::Plugin> is an abstract base class for L<Mojolicious> plugins.

=head1 METHODS

L<Mojolicious::Plugin> inherits all methods from L<Mojo::Base> and implements
the following new ones.

=head2 C<register>

    $plugin->register;
    
This method will be called by L<Mojolicious::Plugins> at startup time. Your 
plugin should use this to hook into the application. For instace this by 
adding handlers or helpers  to the L<MojoX::Renderer>, or it could use the
add_hooks method of L<Mojolicious::Plugins> to hook into the request flow.

=cut
