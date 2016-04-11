
# This script generates all subcommands, and all options for each subcommand

# To get all subcommands:
# samtools 2>&1 | awk '{if ($1 != "" && $1 != "Program:" && $1 != "Usage:" && $1 != "Version:" && $1 != "Commands:" && $1 != "--") print $1}' | xargs -n 1 -I @ printf @" "; printf "\n"

# To get options for subcommands:
# samtools <subcommand> 2>&1 | grep -oh "\(\-\-\)\([[:alnum:]]\|\-\)* " | xargs -I @ printf @" "; printf "\n"
# This matches with two double dashed (i.e. a long option) followed by alphanums or dashes. The reason I couldn't use [[:graph:]] is that it could include commas, which are used to separate the short version of long options, which start with double dashes when they are >= 2 chars long.


SUBCOMMANDS=$(samtools 2>&1 | awk '{if ($1 != "" && $1 != "Program:" && $1 != "Usage:" && $1 != "Version:" && $1 != "Commands:" && $1 != "--") print $1}' | xargs -n 1 -I @ printf @" ")
echo "Subcommands:" $SUBCOMMANDS

for SUB in $SUBCOMMANDS; do
	echo "Options for" $SUB
	SUB_OPTS=$(samtools $SUB 2>&1 | grep -oh "\(\-\-\)\([[:alnum:]]\|\-\)* " | xargs -I @ printf @" ")
	echo $SUB_OPTS
done
