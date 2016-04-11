### Tab completion for Samtools ###

#### Usage: ####

	$ sh generate_completion_file.sh > /where/to/save/tab/completion/files

This file can be stored anywhere, and then sourced from .bashrc. The default location for storing tab completion files is /etc/bash_completion.d/

#### Examples: ####

	$ samtools <TAB><TAB>
	addreplacerg  collate       faidx         flags         merge         reheader      stats       
	bedcov        depad         fasta         flagstat      mpileup       rmdup         targetcut   
	calmd         depth         fastq         idxstats      phase         sort          tview       
	cat           dict          fixmate       index         quickcheck    split         view        

	$ samtools m<TAB<TAB>
	merge    mpileup  

	$ samtools mp<TAB>
	$ samtools mpileup

	$ samtools subcommand<TAB><TAB>
	<all files in PWD displayed>

	$ samtools mpileup -<TAB>
	$ samtools mpileup --

	$ samtools mpileup --<TAB><TAB>
	--adjust-MQ         --fasta-ref         --max-depth         --output            --redo-BAQ
	--bam-list          --gap-frac          --max-idepth        --output-BP         --reference
	--BCF               --ignore-overlaps   --min-BQ            --output-MQ         --region
	--count-orphans     --ignore-RG         --min-ireads        --output-tags       --skip-indels
	--excl-flags        --illumina1.3+      --min-MQ            --per-sample-mF     --tandem-qual
	--exclude-RG        --incl-flags        --no-BAQ            --platforms         --uncompressed
	--ext-prob          --input-fmt-option  --open-prob         --positions         --VCF


#### Samtools: ####
https://github.com/samtools/samtools
