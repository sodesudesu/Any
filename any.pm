#!/usr/bin/perl
use 5.010;
use v5.10;
use strict;
use warnings;
use utf8;
use Tkx;

### メインウィンドウ生成
my $top = Tkx::widget -> new(".");

### テキスト作成のための関数
# ウィンドウバー
sub bar {
  my $text = shift @_;
  $top -> g_wm_title("$text");
}

my $c = $top -> new_canvas(-bg=>"white", -width=>200, -height=>200); # 新キャンバス
$c -> g_pack(-fill=>"both", -expand=>1);

# タイトルなど
sub title {
  my $text = @_; # 関数の変数
  my $label = $c -> new_label(-text=>$text, -font=>["", 120], -justify=>"left", -bg=>"white");
  $label -> g_pack(-anchor=>"n"); # タイトルの表示
}
sub author {
  my $text = @_; # 関数の変数
  my $label = $c -> new_label(-text=>$text, -font=>["", 50], -justify=>"left", -bg=>"white");
  $label -> g_pack(-anchor=>"n"); # 発表者の表示
}
sub date {
  my $text = @_; # 関数の変数
  my $label = $c -> new_label(-text=>$text, -font=>["", 30], -justify=>"left", -bg=>"white");
  $label -> g_pack(-anchor=>"n"); # 日付の表示
}

# 見出し
sub head {
  my $text = shift @_;
  my $label = $c -> new_label(-text=>$text, -font=>["", 90], -bg=>"white", -justify=>"left");
  $label -> g_pack(-anchor=>"nw");
}

# 本文
sub text {
  my $text = shift @_;
  my $label = $c -> new_label(-text=>$text, -font=>["", 50], -bg=>"white", -justify=>"left");
  $label -> g_pack(-anchor=>"nw");
}

# つぶやき
sub tweet {
  my $text = shift @_;
  my $label = $c -> new_message(-text=>$text, -font=>["", 50], -aspect=>700, -bg=>"white");
  $label -> g_pack();
}

# 矢印キーで進む機能
my @page; # 1ページ分
my $current_word = -1;
my $current_page = 0;
my $counter = 0; # $pageにテキストを格納する用

sub p {
  for (my $i=0; $i<@_; $i++) {
    $page[$counter][$i][0] = $_[$i][0]; # タイプ
    $page[$counter][$i][1] = $_[$i][1]; # 言葉
  }
  $counter++;
}

sub show_page {
  say $page[$current_page][$current_word][1];
  if ($page[$current_page][$current_word][0] eq "h") {
    &head($page[$current_page][$current_word][1]);
  } elsif ($page[$current_page][$current_word][0] eq "t") {
    &text($page[$current_page][$current_word][1]);
  } elsif ($page[$current_page][$current_word][0] eq "tw") {
    &tweet($page[$current_page][$current_word][1]);
  } elsif ($page[$current_page][$current_word][0] eq undef) {
    &page_reset;
  }
}

# 改ページ
sub page_reset {
  $c -> g_destroy;
  $c = $top -> new_canvas(-bg=>"white", -width=>200, -height=>200);
  $c -> g_pack(-fill=>"both", -expand=>1);
  $current_page++;
  $current_word = -1;
}

# 矢印キーを関数にバインド
$top -> g_bind("<Right>", \&next_word);
$c -> g_bind("<Left>", \&back_word);

# 右矢印キーが押されたときの処理を行う関数
sub next_word {
  $current_word++;
  show_page();
}

sub back_word {
  $current_word = $current_word - 1;
  if ($current_word eq 0) {
    $current_page = $current_page - 1;
    $current_word = -1;
  }
  show_page();
}

# 箇条書きの点
sub pch {
  return "\x{2744}";
}

1;
