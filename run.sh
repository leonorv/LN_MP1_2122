#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

echo "Compiling: compiled/A2R.fst"
fstinvert compiled/R2A.fst > compiled/A2R.fst # A2R

echo "Compiling: compiled/birthR2A.fst"
fstcompose compiled/R2A.fst compiled/d2dd.fst > compiled/tmp.fst # R2A2dd
fstconcat compiled/tmp.fst compiled/copy.fst > compiled/tmp2.fst # R2A2dd copy
fstconcat compiled/tmp2.fst compiled/tmp2.fst > compiled/tmp3.fst # R2A2dd copy R2A2dd copy
fstcompose compiled/R2A.fst compiled/d2dddd.fst > compiled/tmp4.fst # R2A2dddd
fstconcat compiled/tmp3.fst compiled/tmp4.fst > compiled/birthR2A.fst # R2A2dd copy R2A2dd copy R2A2dddd
rm compiled/tmp*

echo "Compiling: compiled/birthA2T.fst"
fstconcat compiled/copy.fst compiled/copy.fst > compiled/tmp.fst # copy2
fstconcat compiled/tmp.fst compiled/copy.fst > compiled/tmp2.fst # copy3
fstconcat compiled/tmp2.fst compiled/mm2mmm.fst > compiled/tmp3.fst # copy3 mm2mmm
fstconcat compiled/tmp3.fst compiled/copy.fst > compiled/tmp4.fst # copy3 mm2mmm copy
fstconcat compiled/tmp4.fst compiled/tmp.fst > compiled/tmp5.fst # copy3 mm2mmm copy3
fstconcat compiled/tmp5.fst compiled/tmp.fst > compiled/birthA2T.fst # copy3 mm2mmm copy5
rm compiled/tmp*

echo "Compiling: compiled/birthT2R.fst"
fstinvert compiled/d2dd.fst > compiled/tmp.fst # dd2d
fstcompose compiled/tmp.fst compiled/A2R.fst > compiled/tmp2.fst # dd2d2R
fstinvert compiled/mm2mmm.fst > compiled/tmp3.fst # mmm2mm
fstcompose compiled/tmp3.fst compiled/tmp.fst > compiled/tmp4.fst # mmm2d
fstcompose compiled/tmp4.fst compiled/A2R.fst > compiled/tmp5.fst # mmm2d2R
fstinvert compiled/d2dddd.fst > compiled/tmp6.fst # dddd2d
fstcompose compiled/tmp6.fst compiled/A2R.fst > compiled/tmp7.fst # dddd2d2R
fstconcat compiled/tmp2.fst compiled/copy.fst > compiled/tmp8.fst # dd2d2R copy
fstconcat compiled/tmp5.fst compiled/copy.fst > compiled/tmp9.fst # mmm2d2R copy
fstconcat compiled/tmp8.fst compiled/tmp9.fst > compiled/tmp10.fst # dd2d2R copy mmm2R copy
fstconcat compiled/tmp10.fst compiled/tmp7.fst > compiled/birthT2R.fst # dd2d2R copy mmm2R copy dddd2d2R
rm compiled/tmp*

echo "Compiling: compiled/birthR2L.fst"
fstcompose compiled/birthR2A.fst compiled/date2year.fst > compiled/tmp.fst # date2yearA
fstcompose compiled/tmp.fst compiled/leap.fst > compiled/birthR2L.fst # date2yearAleap
rm compiled/tmp*

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

echo "Testing the transducer 'A2R' with the input 'tests/A2R-test.txt' (generating pdf)"
fstcompose compiled/A2R-test.fst compiled/A2R.fst | fstshortestpath > compiled/A2R-res.fst

echo "Testing the transducer 'birthR2A' with the input 'tests/birthR2A-test.txt' (generating pdf)"
fstcompose compiled/birthR2A-test.fst compiled/birthR2A.fst | fstshortestpath > compiled/birthR2A-res.fst

echo "Testing the transducer 'birthA2T' with the input 'tests/birthA2T-test.txt' (generating pdf)"
fstcompose compiled/birthA2T-test.fst compiled/birthA2T.fst | fstshortestpath > compiled/birthA2T-res.fst

echo "Testing the transducer 'birthT2R' with the input 'tests/birthT2R-test.txt' (generating pdf)"
fstcompose compiled/birthT2R-test.fst compiled/birthT2R.fst | fstshortestpath > compiled/birthT2R-res.fst

echo "Testing the transducer 'birthR2L' with the input 'tests/birthR2L-test.txt' (generating pdf)"
fstcompose compiled/birthR2L-test.fst compiled/birthR2L.fst | fstshortestpath > compiled/birthR2L-res.fst

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

echo "Testing the transducer 'A2R' with the input 'tests/A2R-test.txt' (stdout)"
fstcompose compiled/A2R-test.fst compiled/A2R.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'birthR2A' with the input 'tests/birthR2A-test.txt' (stdout)"
fstcompose compiled/birthR2A-test.fst compiled/birthR2A.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'birthA2T' with the input 'tests/birthA2T-test.txt' (stdout)"
fstcompose compiled/birthA2T-test.fst compiled/birthA2T.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'birthT2R' with the input 'tests/birthT2R-test.txt' (stdout)"
fstcompose compiled/birthT2R-test.fst compiled/birthT2R.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'birthR2L' with the input 'tests/birthR2L-test.txt' (stdout)"
fstcompose compiled/birthR2L-test.fst compiled/birthR2L.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
