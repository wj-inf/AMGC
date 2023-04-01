## Require
- gcc
- g++
- cmake
- GNU OpenMP
- Boost library


## Usage
```text
To build HASH index:
        AMGC20 -i <ref.fa>
To compress:
        AMGC20 -c -D 2 [ref.fa] -1 <input_file> 
To decompress:
        AMGC20 -d [ref.fa] <***.arc>

	-t INT       Thread num for multi-threading, default as [1]
	-o           Set out file name
```

## Example
``` terminal
./API/AMGC20 -i ./refdata/hg38.fa
./API/AMGC20 -c -D 2 ./refdata/hg38.fa -1 ./testdata/SRR6691666_1_50M.fastq -t 1
./API/AMGC20 -d ./refdata/hg38.fa SRR6691666_1_50M.fastq.arc -o SRR6691666_1_50M_re -t 1
```

## Seq Part
If you want to test the sequence part only, the instructions below could be helpful.
``` terminal
set quality part as one signal value:
sed -n '1~4s/^@/>/p;2~4p' ./testdata/SRR6691666_1_50M.fastq > SRR6691666_1_50MA.fasta
perl ./tools/fasta_to_fastq.pl SRR6691666_1_50MA.fasta > SRR6691666_1_50MB.fastq
rm -f SRR6691666_1_50MA.fasta

set name part as simple type:
./tools/re_name.exe SRR6691666_1_50MB.fastq SRR6691666_1_50MS.fastq
rm -f SRR6691666_1_50MB.fastq
```

## Tips 
We recommend running AMGC with ubuntu version 20.04. 
./API/AMGC18 is for ubuntu18.04 .2(with shared libraries: libboost_system.so.1.65.1)
./API/AMGC20 is for ubuntu20.04.6 (with shared libraries: libboost_system.so.1.71.0)
./API/AMGC22 is for ubuntu22.04.2 (with shared libraries: libboost_system.so.1.74.0)

The instructions below could be helpful may be helpful
```terminal
sudo apt-get update
sudo apt install cmake
sudo apt install gcc
sudo apt install g++
sudo apt-get install zlib1g-dev
sudo apt-get install -y libboost-filesystem-dev
```

If an error is encountered: "**./API/AMGC18 Instruction not found**", you can use "**chmod +x ./API/AMGC18**" to give executable permissions to the file.

