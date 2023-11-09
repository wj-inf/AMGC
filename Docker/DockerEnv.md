# Docker Envs for AMGC

This directory offers docker envs for AMGC.

## Docker Install
This part is referenced to: [zhihu](https://zhuanlan.zhihu.com/p/651148141)

```terminal
sudo apt update
```
Install docker dependencies:
```terminal
sudo apt-get install ca-certificates curl gnupg lsb-release
```
Add the official Docker GPG key:
```terminal
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```
Add a Docker repositories:
```terminal
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```
Docker install:
```terminal
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
Verify and check docker version:
```terminal
service docker restart
sudo docker run hello-world
sudo docker version
```


## Container Preparation

Load image:
```terminal
sudo docker load -i ./env_image_amgc.tar.gz
```
Create container:
```terminal
sudo docker run --name amgc --shm-size 32g -it -v ../data:/data env_image_amgc /bin/bash 
```
ps: 

1. Our program needs shm to storage processed reference  gene data.(eg: ~9GB shm for hg38.fa ~3GB) 
2. '../data:/data' stand for '**soure data path**:container data path' likes shared folder.

Copy api into data dir:

```terminal
cp /api/AMGC /data && cd /data
```

## Usage
```text
To build HASH index:
        AMGC -i <ref.fa>
To compress:
        AMGC -c -D 2 [ref.fa] -1 <input_file> 
To decompress:
        AMGC -d [ref.fa] <***.arc>

	-t INT       Thread num for multi-threading, default as [1]
	-o           Set out file name
```

## Example
``` terminal
./AMGC -i ./refdata/hg38.fa
./AMGC -c -D 2 ./refdata/hg38.fa -1 ./testdata/SRR6691666_1_50M.fastq -t 1
./AMGC -d ./refdata/hg38.fa SRR6691666_1_50M.fastq.arc -o SRR6691666_1_50M_re -t 1
```

## Tips
``` terminal
sudo docker images -a # show already exist iamges
sudo docker ps -a # show already exist containers
sudo docker start ce2c487c79c6(this is your contianerID) # start a container
```


## Seq Part Only

If you want to test the sequence part only, the instructions [here](../README.md) could be helpful.
