#!/bin/sh

PBCOPY=/usr/bin/pbcopy
PUTCLIP=/usr/bin/putclip
SCREEN_EXCHANGE=/tmp/screen-exchange

this_script=`readlink -f $0`
cd `dirname ${this_script}`

rsync -a ${SCREEN_EXCHANGE} asosa@tr.asai24.com:${SCREEN_EXCHANGE}

case `uname` in
  Darwin*)
  ${PBCOPY} < ${SCREEN_EXCHANGE} > /dev/null 2>&1
    ;;
  CYGWIN*)
  nkf -s --overwrite ${SCREEN_EXCHANGE}
  ${PUTCLIP} < ${SCREEN_EXCHANGE} > /dev/null 2>&1
    ;;
esac

