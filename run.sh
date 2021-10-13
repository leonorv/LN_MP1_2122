#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done


# TODO

#echo "Testing the transducer 'd2dd' with the input 'tests/numeroR.txt' (generating pdf)"
#fstcompose compiled/numeroR.fst compiled/d2dd.fst | fstshortestpath > compiled/numeroA.fst
#
#echo "Testing the transducer 'mm2mmm' with the input 'tests/numeroR.txt' (generating pdf)"
#fstcompose compiled/numeroR.fst compiled/mm2mmm.fst | fstshortestpath > compiled/numeroA.fst

#echo "Testing the transducer 'd2dddd' with the input 'tests/numeroR.txt' (generating pdf)"
#fstcompose compiled/numeroR.fst compiled/d2dddd.fst | fstshortestpath > compiled/numeroA.fst

#echo "Testing the transducer 'copy' with the input 'tests/numeroR.txt' (generating pdf)"
#fstcompose compiled/numeroR.fst compiled/copy.fst | fstshortestpath > compiled/numeroA.fst

echo "Testing the transducer 'date2year' with the input 'tests/numeroR.txt' (generating pdf)"
fstcompose compiled/numeroR.fst compiled/date2year.fst | fstshortestpath > compiled/numeroA.fst

#echo "Testing the transducer 'R2A' with the input 'tests/numeroR.txt' (generating pdf)"
#fstcompose compiled/numeroR.fst compiled/R2A.fst | fstshortestpath > compiled/numeroA.fst

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done

#echo "Testing the transducer 'd2dd' with the input 'tests/numeroR.txt' (stdout)"
#fstcompose compiled/numeroR.fst compiled/d2dd.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
#
#echo "Testing the transducer 'mm2mmm' with the input 'tests/numeroR.txt' (stdout)"
#fstcompose compiled/numeroR.fst compiled/mm2mmm.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

#echo "Testing the transducer 'd2dddd' with the input 'tests/numeroR.txt' (stdout)"
#fstcompose compiled/numeroR.fst compiled/d2dddd.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
#
#echo "Testing the transducer 'copy' with the input 'tests/numeroR.txt' (stdout)"
#fstcompose compiled/numeroR.fst compiled/copy.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'date2year' with the input 'tests/numeroR.txt' (stdout)"
fstcompose compiled/numeroR.fst compiled/date2year.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt


#echo "Testing the transducer 'R2A' with the input 'tests/numeroR.txt' (stdout)"
#fstcompose compiled/numeroR.fst compiled/R2A.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt