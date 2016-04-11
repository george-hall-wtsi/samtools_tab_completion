### Tab completion for Samtools ###

So far I have only implemented completion for the main subcommand and for mpileup, but it shouldn't be very difficult to implement it for all other subcommands. I just first want to see what people think. 

#### Installation: ####
Source samtools_tab_completion from your .bashrc, and it seems to do the rest automatically. People that actually know how Bash works may think that this is a bad idea, I'm not sure myself. 

#### Usage: ####

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
