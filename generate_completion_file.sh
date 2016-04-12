

# This script works out all subcommands and their corresponding options, and 
# then prints a file allowing for tab completion of these subcommands and their 
# options to stdout. It is up to the user to store this file in the correct 
# location (see README).


# Get subcommands:

SUBCOMMANDS=$(samtools 2>&1 | \
	awk '{if ($1 != "" && \
	$1 != "Program:" && \
	$1 != "Usage:" && \
	$1 != "Version:" && \
	$1 != "Commands:" && \
	$1 != "--") print $1}' | \
	xargs -n 1 -I @ printf @" ")

out_str="_samtools_options()\n"
out_str=$out_str"{\n"
out_str=$out_str"\tlocal cur current_sub opts\n"
out_str=$out_str"\tCOMPREPLY=()\n"
out_str=$out_str"\tcur=\"\${COMP_WORDS[COMP_CWORD]}\"\n\n"

out_str=$out_str"\tif [[ \$COMP_CWORD == 1 ]] ; then\n"
out_str=$out_str"\t\t# Complete main subcommand\n"
out_str=$out_str"\t\topts=\"$SUBCOMMANDS\"\n\n"

out_str=$out_str"\t\tCOMPREPLY=(\$(compgen -W \"\${opts}\" -- \${cur}))\n"
out_str=$out_str"\t\treturn 0\n\n"

printf "$out_str"

printf "\telse\n"
printf "\t\t# Complete options for subcommands\n\n"
printf "\t\tcurrent_sub=\"\${COMP_WORDS[1]}\"\n\n"

printf "\t\tcase \$current_sub in\n\n"

for SUB in $SUBCOMMANDS; do

	# This matches with two double dashed (i.e. a long option) followed by alphanums
	# or dashes. The reason I couldn't use [[:graph:]] is that it could include commas,
	# which are used to separate the short version of long options, which start with
	# double dashes when they are >= 2 chars long.
	SUB_OPTS=$(samtools $SUB 2>&1 | \
		grep -oh "\(\-\-\)\([[:alnum:]]\|\-\)* " | \
		xargs -I @ printf @)

	# Only print options when option list is non-empty
	OPTS_LEN=${#SUB_OPTS}
	if [ $OPTS_LEN != 0 ]; then
		printf "\t\t\t\"$SUB\")\n"
		printf "\t\t\t\t# Completion for $SUB - only triggered after first '-'\n"
		printf "\t\t\t\tif [[ \${cur} == -* ]] ; then\n"
		printf "\t\t\t\t\topts=\"$SUB_OPTS\"\n\n"
		printf "\t\t\t\t\tCOMPREPLY=(\$(compgen -W \"\${opts}\" -- \${cur}))\n"
		printf "\t\t\t\t\treturn 0\n"
		printf "\t\t\t\tfi\n"
		printf "\t\t\t\t;;\n\n"
	fi
done

printf "\t\t\t*)\n"
printf "\t\t\t\t;;\n\n"
printf "\t\tesac\n\n"

printf "\tfi\n\n"

out_str="\t# If we have not returned by now, assume the user is looking for files\n"
out_str=$out_str"\tcompopt -o filenames # Don't append a space\n"
out_str=$out_str"\tCOMPREPLY=(\$(compgen -f \"\${cur}\"))\n"
out_str=$out_str"\treturn 0\n"
out_str=$out_str"}\n"
out_str=$out_str"complete -F _samtools_options samtools\n"

printf "$out_str"
