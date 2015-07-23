#!/bin/sh
# UCLA CS 111
# Tien Le (604180315)
# David Nguyen (304177673)

# Testing parallelization

tmp=$0-$$.tmp
mkdir "$tmp" || exit


(
cd "$tmp" || exit

cat >test.sh << 'EOF'
echo test2 > tempfile && echo TEST1
cat tempfile | tr a-z A-Z
echo TEST3 > tempfile1
cat tempfile1 && echo TEST4 > tempfile1 && cat tempfile1
echo TEST6 > tempfile2
echo TEST5 > tempfile2 && cat tempfile2 

#END TEST
EOF

cat >test.exp << 'EOF'
TEST1
TEST2
TEST3
TEST4
TEST5
EOF

../timetrash -t test.sh > test.out 2>test.err || exit

diff -u test.exp test.out || exit
test ! -s test.err || {
  cat test.err
  exit 1
}

) || exit

rm -fr "$tmp"
