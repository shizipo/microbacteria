基因岛的预测，可以通过在线网站预测：http://www.pathogenomics.sfu.ca/islandviewer 。
   难点在于，这个网站预测基因岛，提交数据的格式必须为genebank或EMBL格式，所以网上搜了一下gff转化genebank格式的脚本，主要有两个：
   
1、即本目录下的gff2genbank.pl脚本，使用此脚本可以将gff和fna文件转化为genebank文件格式，使用方法为 USAGE: ./gff2genbank <FASTA> <GFF>  
   本脚本的原始来源为：https://github.com/Ecogenomics/Mannotator/blob/master/bin/gff2genbank
   本脚本需要安装Bio::SeqIO ,使用cpanm Bio::SeqIO 对其进行了安装。

2、gff_to_genbank.py 脚本，
   来源于https://github.com/AAFC-BICoE/annotation-scripts。但是需要安装BCBio，安装方法如下：
   git clone git://github.com/chapmanb/bcbb.git
   cd bcbb/gff
   python setup.py build
   sudo python setup.py install
