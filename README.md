## Require
- GCC
- cmake
- GNU OpenMP
- Boost library


## Usage
```text
To build HASH index:
        AVS_api -i <ref.fa>
To compress:
        AVS_api -c -D 2 [ref.fa] -1 <input_file> 
To decompress:
        AVS_api -d [ref.fa] <***.arc>

	-t INT       Thread num for multi-threading, default as [1]
	-o           Set out file name
```

## Example
``` terminal
./AMGC_api -i ./refdata/hg38.fa
./AMGC_api -c -D 2 ./refdata/hg38.fa -1 ./testdata/SRR6691666_1_50M.fastq -t 1
./AMGC_api -d ./refdata/hg38.fa SRR6691666_1_50M.fastq.arc -o SRR6691666_1_50M_re -t 1
```

## Seq Part
If you want to test sequence part only, instructions below could be helpful.
``` terminal
set quality part as one signal value:
sed -n '1~4s/^@/>/p;2~4p' ./testdata/SRR6691666_1_50M.fastq > SRR6691666_1_50MA.fasta
perl ./tools/fasta_to_fastq.pl SRR6691666_1_50MA.fasta > SRR6691666_1_50MB.fastq
rm -f SRR6691666_1_50MA.fasta

set name part as simple type:
./tools/re_name.exe SRR6691666_1_50MB.fastq SRR6691666_1_50MS.fastq
rm -f SRR6691666_1_50MB.fastq
```
