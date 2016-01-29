python_match
============

github clone for the python_match plugin on vim.org

This is an unofficial repo for the python_match.vim on vim.org, original
URL <http://www.vim.org/scripts/script.php?script_id=386>. This clone is
for easier management with `bundle`

Please open an issue if this is not updated in time or there's anything
wrong with the content.

Original description:

# python_match.vim : Extend the % motion and define g%, [%, and ]% motions for Python files

## created by

Benji Fisher
 
## script type

ftplugin
 
## description

This script redefines the % motion so that (in addition to its usual behavior)
it cycles through if/elif/else, try/except/catch, for/continue/break, and
while/continue/break structures.  The script also
defines g% to cycle in the opposite direction.  Two other motions, [% and ]%,
go to the start and end of the current block, respectively.

All of these motions should work in Normal, Visual, and Operator-pending
modes.  For example, d]% should delete (characterwise) until the end of the
current block; v]%d should do the same, going through Visual mode so that
you can see what is being deleted; and V]%d makes it linewise.
 
## install details
Copy the file to your ftplugin/ directory.  If, for some reason, you want to
change the name of the file, copy it to ftplugin/python/ or :source it from
ftplugin/python.vim .
