#! /bin/sh

# UCLA CS 111
# Tien Le (604180315)
# David Nguyen (304177673)

# Modeled after test-p-ok and test-p-bad.

tmp=$0-$$.tmp
mkdir "$tmp" || exit


(
cd "$tmp" || exit

cat >test.sh << 'EOF'
#Checks WAW, RAW, and WAR dependencies respectively

echo Test 0;

#WAW

echo A > a

echo B > a

#RAW

cat a

#WAR

echo C > a

cat a

#END TEST
EOF

cat >test.exp << 'EOF'
Test 0
B
C
EOF

../timetrash -t test.sh > test.out 2>test.err || exit

rm a
diff -u test.exp test.out || exit
test ! -s test.err || {
  cat test.err
  exit 1
}

) || exit
rm -fr "$tmp"
