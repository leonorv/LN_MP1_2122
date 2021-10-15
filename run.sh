#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done


# TODO

echo "Testing the transducer 'mm2mmm' with the input 'tests/mm2mmm-test.txt' (generating pdf)"
fstcompose compiled/mm2mmm-test.fst compiled/mm2mmm.fst | fstshortestpath > compiled/mm2mmm-res.fst

echo "Testing the transducer 'd2dd' with the input 'tests/d2dd-test.txt' (generating pdf)"
fstcompose compiled/d2dd-test.fst compiled/d2dd.fst | fstshortestpath > compiled/d2dd-res.fst

echo "Testing the transducer 'd2dddd' with the input 'tests/d2dddd-test.txt' (generating pdf)"
fstcompose compiled/d2dddd-test.fst compiled/d2dddd.fst | fstshortestpath > compiled/d2dddd-res.fst

echo "Testing the transducer 'copy' with the input 'tests/copy-test.txt' (generating pdf)"
fstcompose compiled/copy-test.fst compiled/copy.fst | fstshortestpath > compiled/copy-res.fst

echo "Testing the transducer 'skip' with the input 'tests/skip-test.txt' (generating pdf)"
fstcompose compiled/skip-test.fst compiled/skip.fst | fstshortestpath > compiled/skip-res.fst

echo "Testing the transducer 'date2year' with the input 'tests/date2year-test.txt' (generating pdf)"
fstcompose compiled/date2year-test.fst compiled/date2year.fst | fstshortestpath > compiled/date2year-res.fst

echo "Testing the transducer 'leap' with the input 'tests/leap-test.txt' (generating pdf)"
fstcompose compiled/leap-test.fst compiled/leap.fst | fstshortestpath > compiled/leap-res.fst

echo "Testing the transducer 'R2A' with the input 'tests/R2A-test.txt' (generating pdf)"
fstcompose compiled/R2A-test.fst compiled/R2A.fst | fstshortestpath > compiled/R2A-res.fst

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done

echo "Testing the transducer 'mm2mmm' with the input 'tests/mm2mmm-test.txt' (stdout)"
fstcompose compiled/mm2mmm-test.fst compiled/mm2mmm.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'd2dd' with the input 'tests/d2dd-test.txt' (stdout)"
fstcompose compiled/d2dd-test.fst compiled/d2dd.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'd2dddd' with the input 'tests/d2dddd-test.txt' (stdout)"
fstcompose compiled/d2dddd-test.fst compiled/d2dddd.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'copy' with the input 'tests/copy-test.txt' (stdout)"
fstcompose compiled/copy-test.fst compiled/copy.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'skip' with the input 'tests/skip-test.txt' (stdout)"
fstcompose compiled/skip-test.fst compiled/skip.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'date2year' with the input 'tests/date2year-test.txt' (stdout)"
fstcompose compiled/date2year-test.fst compiled/date2year.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'leap' with the input 'tests/leap-test.txt' (stdout)"
fstcompose compiled/leap-test.fst compiled/leap.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'R2A' with the input 'tests/R2A-test.txt' (stdout)"
fstcompose compiled/R2A-test.fst compiled/R2A.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
