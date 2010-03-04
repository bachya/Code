#!/bin/sh
/opt/google/chrome/chrome "https://mail.google.com/mail?view=cm&tf=0&ui=1&to="`echo $1|sed -e 's/?subject=/\&su=/' -e 's/mailto://'`
