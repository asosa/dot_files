HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

bindkey -v

autoload -U compinit
compinit -u

setopt prompt_subst
setopt append_history        # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt auto_cd               # ディレクトリのみで移動
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt correct               # スペルミスを補完
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt share_history         # 履歴の共有
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除(先頭にスペースを入れておけば、ヒストリに保存されない)
unsetopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_save_no_dups     # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_expand           # 補完時にヒストリを自動的に展開
setopt list_packed           # コンパクトに補完リストを表示
unsetopt auto_remove_slash
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete       # 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
                             # 最初にマッチしたものをいきなり挿入、はしない
setopt auto_list             # ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_resume           # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt no_beep               # コマンド入力エラーでBeepを鳴らさない
setopt brace_ccl             # ブレース展開機能を有効にする
setopt bsd_echo
setopt complete_in_word
setopt equals                # =COMMAND を COMMAND のパス名に展開
setopt extended_glob         # 拡張グロブを有効にする
unsetopt flow_control        # (shell editor 内で) C-s, C-q を無効にする
setopt no_flow_control       # C-s/C-q によるフロー制御を使わない
setopt hash_cmds             # 各コマンドが実行されるときにパスをハッシュに入れる
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt ignore_eof            # C-dでログアウトしない
setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst     # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
setopt mail_warning
setopt multios               # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt numeric_glob_sort     # 数字を数値と解釈してソートする
setopt path_dirs             # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit       # 補完候補リストの日本語を適正表示
setopt short_loops           # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる
setopt auto_name_dirs
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt cdable_vars sh_word_split
setopt auto_pushd            # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups     # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home         # pushd 引数ナシ == pushd $HOME
setopt pushd_silent          # pushd,popdの度にディレクトリスタックの中身を表示しない

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# prompt
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$'\n'$GREEN'${USER}@${HOSTNAME} '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '

# alias
alias rr="rm -rf"
alias mv="mv -i"
alias pd="pushd"
alias po="popd"
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias ls="ls -hF --color=auto"
alias ll="ls -l"
alias la="ll -A"
alias cl="make -f ~/Makefile clean"
alias sqlplus='rlwrap sqlplus'

# history completion
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# set name to screen
preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

# cd 後に自動で ls
function cd() { builtin cd $@ && ls;}
