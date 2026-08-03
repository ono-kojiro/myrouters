#!/bin/sh

echo "CONTROLLERS_PHP = \\" 
find ./OPNsense/ -name "*Controller.php" \
  | sed 's/^.\///' \
  | sed 's/\(.*\)/  \1 \\/'
echo ""



