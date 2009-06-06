use strict;
use Irssi;
use POSIX qw(strftime);
use Data::Dumper;

use vars qw($VERSION %IRSSI);
$VERSION = "0.1";
%IRSSI = (
	  authors	=> "Jari Matilainen",
	  contact	=> "vague_666 \[at\] hotmail.com",
	  name		=> "unimp",
	  description	=> "Do not display unimportant levels",
	  licence	=> "GPLv2",
	  changed	=> "08.05.2009 17:45 CEST"
);

my %users = ();

sub sig_public {
  my ($server,$msg,$nick,$host,$witem) = @_;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $chanstr = lc($server->{tag}) . "/" . lc($witem);
  my $foundit = 0;

  foreach (@channels) {
    if(/$chanstr/) {
      $foundit = 1;
    }
  }

  return if(!$foundit);

  if(exists $users{lc($server->{tag})}{lc($nick)}{lc($witem)}{join}) {
    $server->channel_find($witem)->print("$nick($host) joined at: " . $users{lc($server->{tag})}{lc($nick)}{lc($witem)}{join});
    delete $users{lc($server->{tag})}{lc($nick)}{lc($witem)}{join};
  }

  $users{lc($server->{tag})}{lc($nick)}{last_active} = time();
}

sub sig_log_join {
  my ($server,$witem,$nick,$host) = @_;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $chanstr = lc($server->{tag}) . "/" . lc($witem);
  my $foundit = 0;

  foreach (@channels) {
    if(/$chanstr/) {
      $foundit = 1;
    }
  }

  return if(!$foundit);

  $users{lc($server->{tag})}{lc($nick)}{lc($witem)}{join} = strftime "%F %T", localtime;
  $users{lc($server->{tag})}{lc($nick)}{last_active} = 0;
  Irssi::signal_stop();
}

sub sig_log_part {
  my ($server,$witem,$nick,$host,$reason) = @_;
  my $ignore_after = Irssi::settings_get_time("ignore_after")/1000;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $chanstr = lc($server->{tag}) . "/" . lc($witem);
  my $foundit = 0;

  foreach (@channels) {
    if(/$chanstr/) {
      $foundit = 1;
    }
  }

  return if(!$foundit);

  if(!exists $users{lc($server->{tag})}{lc($nick)} || time() - $users{lc($server->{tag})}{lc($nick)}{last_active} >= $ignore_after) {
    if($server->{nick} eq $nick) {
      delete $users{lc($server->{tag})};
    } else {
      Irssi::signal_stop();
    }
  }

  delete $users{lc($server->{tag})}{lc($nick)}{lc($witem)};
}

sub sig_log_quit {
  my ($server,$nick,$host,$reason) = @_;
  my $ignore_after = Irssi::settings_get_time("ignore_after")/1000;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $servstr = lc($server->{tag});
  my $foundit = 0;

  foreach (@channels) {
    my ($serv,undef) = split /\//, $_;
    if($servstr eq $serv) {
      $foundit = 1;
    }
  }
  return if(!$foundit);

  if(!exists $users{lc($server->{tag})}{lc($nick)} || time() - $users{lc($server->{tag})}{lc($nick)}{last_active} >= $ignore_after) {
    if($server->{nick} eq $nick) {
      delete $users{lc($server->{tag})};
    } else {
      Irssi::signal_stop();
    }
  }

  delete $users{lc($server->{tag})}{lc($nick)};
}

sub sig_log_kick {
  my ($server,$witem,$nick,$kicker,$host,$reason) = @_;
  my $ignore_after = Irssi::settings_get_time("ignore_after")/1000;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $chanstr = lc($server->{tag}) . "/" . lc($witem);
  my $foundit = 0;

  foreach (@channels) {
    if(/$chanstr/) {
      $foundit = 1;
    }
  }

  return if(!$foundit);

  if(!exists $users{lc($server->{tag})}{lc($nick)} || time() - $users{lc($server->{tag})}{lc($nick)}{last_active} >= $ignore_after) {
    if($server->{nick} eq $nick) {
      delete $users{lc($server->{tag})};
    } else {
      Irssi::signal_stop();
    }
  }

  delete $users{lc($server->{tag})}{lc($nick)};
}

sub sig_log_priv {
  my ($server,$msg,$nick,$host) = @_;

  $users{lc($server->{tag})}{lc($nick)}{last_active} = time();
}

sub sig_log_nick {
  my ($server,$newnick,$oldnick,$host) = @_;
  my @channels = split / /, lc(Irssi::settings_get_str("ignore_in_channels"));
  my $servstr = lc($server->{tag});
  my $foundit = 0;

  foreach (@channels) {
    my ($serv,undef) = split /\//, $_;
    if($servstr eq $serv) {
      $foundit = 1;
    }
  }
  return if(!$foundit);

  $users{lc($server->{tag})}{lc($oldnick)}{last_active} = time();
  $users{lc($server->{tag})}{lc($newnick)} = $users{lc($server->{tag})}{lc($oldnick)};
  delete $users{lc($server->{tag})}{lc($oldnick)};
  Irssi::signal_stop();
}

Irssi::signal_add_first('message public', \&sig_public);
Irssi::signal_add_last('message join', \&sig_log_join);
Irssi::signal_add_last('message part', \&sig_log_part);
Irssi::signal_add_last('message quit', \&sig_log_quit);
Irssi::signal_add_last('message nick', \&sig_log_nick);
#Irssi::signal_add_last('message kick', \&sig_log_kick);
Irssi::signal_add_first('message private', \&sig_log_priv);
Irssi::signal_add_first('message irc action', \&sig_public);

Irssi::settings_add_time("unimportant","ignore_after","5m");
Irssi::settings_add_str("unimportant","ignore_in_channels","EFNet/#foo DALNet/#bar");
