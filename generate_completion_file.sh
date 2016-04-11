
# This script generates all subcommands, and all options for each subcommand

# To get all subcommands:
# samtools 2>&1 | awk '{if ($1 != "" && $1 != "Program:" && $1 != "Usage:" && $1 != "Version:" && $1 != "Commands:" && $1 != "--") print $1}' | xargs -n 1 -I @ printf @" "; printf "\n"

# To get options for subcommands:
# samtools <subcommand> 2>&1 | grep -oh "\(\-\-\)\([[:alnum:]]\|\-\)* " | xargs -I @ printf @" "; printf "\n"
# This matches with two double dashed (i.e. a long option) followed by alphanums or dashes. The reason I couldn't use [[:graph:]] is that it could include commas, which are used to separate the short version of long options, which start with double dashes when they are >= 2 chars long.

out_str="_samtools_options()\n"
out_str=$out_str"{\n"
out_str=$out_str"\tlocal cur prev opts\n"
out_str=$out_str"\tCOMPREPLY=()\n"
out_str=$out_str"\tcur=\"\${COMP_WORDS[COMP_CWORD]}\"\n"
out_str=$out_str"\tprev=\"\${COMP_WORDS[COMP_CWORD-1]}\"\n\n"

out_str=$out_str"\tif [[ \$COMP_CWORD == 1 ]] ; then\n"
out_str=$out_str"\t\t# Complete main subcommand\n"
SUBCOMMANDS=$(samtools 2>&1 | awk '{if ($1 != "" && $1 != "Program:" && $1 != "Usage:" && $1 != "Version:" && $1 != "Commands:" && $1 != "--") print $1}' | xargs -n 1 -I @ printf @" ")
out_str=$out_str"\t\topts=\"$SUBCOMMANDS\b\"\n\n"

out_str=$out_str"\t\tCOMPREPLY=(\$(compgen -W \"\${opts}\" -- \${cur}))\n"
out_str=$out_str"\t\treturn 0\n\n"

printf "$out_str"

for SUB in $SUBCOMMANDS; do
	SUB_OPTS=$(samtools $SUB 2>&1 | grep -oh "\(\-\-\)\([[:alnum:]]\|\-\)* " | xargs -I @ printf @)
	OPTS_LEN=${#SUB_OPTS}
	if [ $OPTS_LEN != 0 ]; then
		printf "\telif [[ \$prev == \"$SUB\" ]]; then\n"
		printf "\t\t# Completion for $SUB - only triggered after first '-'\n"
		printf "\t\tif [[ \${cur} == -* ]] ; then\n"
		printf "\t\t\topts=\"$SUB_OPTS\b\"\n\n"
		printf "\t\t\tCOMPREPLY=(\$(compgen -W \"\${opts}\" -- \${cur}))\n"
		printf "\t\t\treturn 0\n"
		printf "\t\tfi\n\n"
	fi
done
printf "\tfi\n\n"

out_str="\t# Default case: Assume user is looking for files\n"
out_str=$out_str"\tcompopt -o filenames # Don't append a space\n"
out_str=$out_str"\tCOMPREPLY=(\$(compgen -f \"\${cur}\"))\n"
out_str=$out_str"\treturn 0\n"
out_str=$out_str"}\n"
out_str=$out_str"complete -F _samtools_options samtools"
printf "$out_str"
