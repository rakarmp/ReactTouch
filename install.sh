SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

REPLACE="
"

print_modname() {
  ui_print "[=================================]"
  ui_print "          ReactTouch v1.0          "
  ui_print "         @Zyarexx Telegram         "
  ui_print "[=================================]"
}

on_install() {
  sleep 1
  ui_print "+.+.+ Extract Tweaks ..."
  sleep 1
  ui_print "+.+.+ Successfully Installed ReactTouch ..."
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}