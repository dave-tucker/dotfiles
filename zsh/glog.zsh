# Add current folder to ~/.gitlogger with name specified as argument 1
# For use with gitlogger.sh
function glogger () {
    (echo "$1:`pwd`";grep -v "`pwd`$" ~/.gitlogger) | sort > ~/.gitlogger.tmp
    mv ~/.gitlogger.tmp ~/.gitlogger
}
