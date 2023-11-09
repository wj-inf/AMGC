# AMGC

API for "Adaptive match-based genomic compression algorithm". 

**Jia Wang**<sup>1</sup>,  [Yi Niu](https://web.xidian.edu.cn/niuyi/)<sup>1,2</sup>, Tianyi Xu<sup>1</sup>, Mingming Ma<sup>1</sup>, [Dahua Gao](https://web.xidian.edu.cn/dhgao/)<sup>1</sup> and [Guangming Shi](https://web.xidian.edu.cn/gmshi/)<sup>1,2</sup>

<sup>1</sup>Xidian University, <sup>2</sup>Pengcheng Laboratory

[[preprint](https://arxiv.org/abs/2304.01031)] | [[code](https://github.com/wj-inf/AMGC)]

> **Motivation**: Despite significant advances in Third-Generation Sequencing (TGS) technologies, Next-Generation Sequencing (NGS) technologies remain dominant in the current sequencing market. This is due to the lower error rates and richer analytical software of NGS than that of TGS. NGS technologies generate vast amounts of genomic data including short reads, quality values and read identifiers. As a result, efficient compression of such data has become a pressing need, leading to extensive research efforts focused on designing FASTQ compressors. Previous researches show that lossless compression of quality values seems to reach its limits. But there remain lots of room for the compression of the reads part. 
>
> **Results**: By investigating the characters of the sequencing process, we present a new algorithm for compressing reads in FASTQ files, which can be integrated into various genomic compression tools. We first reviewed the pipeline of reference-based algorithms and identified three key components that heavily impact storage: the matching positions of reads on the reference sequence (refpos), the mismatched positions of bases on reads (mispos) and the matching failed reads (unmapseq). To reduce their sizes, we conducted a detailed analysis of the distribution of matching positions and sequencing errors and then developed the three modules of AMGC. According to the experiment results, AMGC outperformed the current state-of-the-art methods, achieving an 81.23% gain in compression ratio on average compared with the second-best-performing compressor.
>
> **Availability**: https://github.com/wj-inf/AMGC

(We will release the source code together with the [AVS](http://www.avs.org.cn/index/index.html) gene compression standard)


## Preparation

### Data

We conducted experiments on ten data, including five Homo sapiens, three Mus musculus and two Arabidopsis thaliana.

| Reference data                              | Species              | Source                                                       |
| ------------------------------------------- | -------------------- | ------------------------------------------------------------ |
| hg38.fa                                     | Homo sapiens         | [Link](https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz) |
| Mus_musculus.GRCm39.dna.toplevel.fa         | Mus musculus         | [Link](https://ftp.ensembl.org/pub/release-108/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.toplevel.fa.gz) |
| Arabidopsis_thaliana.TAIR10.dna.toplevel.fa | Arabidopsis thaliana | [Link](https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-55/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz) |



| Test data    | Original size | Species name         | Technology | Platform                           | SE/PE | Read length |
| ------------ | ------------- | -------------------- | ---------- | ---------------------------------- | ----- | ----------- |
| SRR4017489_1 | 16.5 GB       | Homo sapiens         | WCS        | Illumina HiSeq 2000                | PE    | 101,101     |
| SRR6691666_1 | 316.1 GB      | Homo sapiens         | WGS        | TruSeq + Illumina HiSeq X          | PE    | 151,151     |
| ERR753370_1  | 12.7 GB       | Homo sapiens         | FINISHING  | Illumina HiScanSQ                  | PE    | 101,101     |
| SRR1238539   | 74.2 GB       | Homo sapiens         | WGS        | Ion Torrent Proton                 | SE    | 177         |
| SRR6178157   | 37.0 GB       | Homo sapiens         | WXS        | Ion Torrent Proton                 | SE    | 135         |
| SRR3479107   | 5.9 GB        | Mus musculus         | MBD-Seq    | MBD-Seq AB 5500xl Genetic Analyzer | PE+SE | 30,30       |
| SRR3479107_1 | 21.9 GB       |                      |            |                                    |       |             |
| SRR5572323   | 29.8 GB       | Mus musculus         | FAIRE-seq  | FAIRE-seq Illumina HiSeq 2000      | SE    | 76          |
| SRR6240776   | 8.5 GB        | Arabidopsis thaliana | ATAC-Seq   | ATAC-Seq Illumina HiSeq 4000       | PE+SE | 50, 50      |
| SRR6240776_1 | 14.9 GB       |                      |            |                                    |       |             |

All these test data could be downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/). You can take this [Link](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR4017489&display=download) as an example.

We also offer tiny test data for test: `./testdata/SRR6691666_1_50M.fastq`. The corresponding reference fasta file could be downloaded from [hg38.fa](https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz). You need to download it before the test.

## Docker(important)

Since the environment of each machine is different, **we recommend using docker** and testing it with the image we provide. [DockerDir](./docker)



## Seq Part
If you want to test the sequence part only, the instructions below could be helpful.

set quality part as one signal value:
``` terminal
sed -n '1~4s/^@/>/p;2~4p' ./testdata/SRR6691666_1_50M.fastq > SRR6691666_1_50MA.fasta
perl ./tools/fasta_to_fastq.pl SRR6691666_1_50MA.fasta > SRR6691666_1_50MB.fastq
rm -f SRR6691666_1_50MA.fasta
```



We still keep the old test information below.

### Require
- GCC 7.5.0
- cmake 3.6
- GNU OpenMP
- Boost library

### Compilation environment
CPU type: **11th Gen Intel(R) Core(TM) i7-11700F @ 2.50GHz**

`./API/AMGC18` was compiled in ubuntu18.04.2 (libboost_system.so.1.65.1)

`./API/AMGC20` was compiled in ubuntu20.04.6 (libboost_system.so.1.71.0)

`./API/AMGC22` was compiled in ubuntu22.04.2 (libboost_system.so.1.74.0)

We recommend running AMGC with ubuntu version 20.04.6. 

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


set name part as simple type:
``` terminal
./tools/re_name.exe SRR6691666_1_50MB.fastq SRR6691666_1_50MS.fastq
rm -f SRR6691666_1_50MB.fastq
```

## Tips 


The instructions below could be helpful.
```terminal
sudo apt-get update
sudo apt install cmake
sudo apt install gcc
sudo apt install g++
sudo apt-get install zlib1g-dev
sudo apt-get install -y libboost-filesystem-dev
```

If an error is encountered: "**./API/AMGC18 Instruction not found**", you can use "**chmod +x ./API/AMGC18**" to give executable permissions to the file.



## Citation

Please consider citing our paper if you find it helpful in your research:

```
@article{wang2023amgc,
  title={AMGC: Adaptive match-based genomic compression algorithm},
  author={Wang, Jia and Niu, Yi and Xu, Tianyi and Ma, Mingming and Gao, Dahua and Shi, Guangming},
  journal={arXiv preprint arXiv:2304.01031},
  year={2023}
}
```





Contact at: wang_jia AT stu DOT xidian DOT edu DOT cn
