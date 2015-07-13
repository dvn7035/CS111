#! /bin/sh

# UCLA CS 111
# Tien Le (604180315)
# David Nguyen (304177673)

tmp=a
mkdir "$tmp" || exit

(
cd "$tmp" || exit

cat >test.sh << 'EOF'

true  || echo test1
false || echo test2
true  && echo test3
false && echo test4

(echo test5 && echo test6) | tr a-z A-Z
echo test7 | tr a-z A-Z

true  && false || echo test8
false || true  || echo test9
false || false || echo test10

#END TEST
EOF

cat >test.exp << 'EOF'
test2
test3
TEST5
TEST6
TEST7
test8
test10
EOF

../timetrash test.sh > test.out 2>test.err || exit

diff -u test.exp test.out || exit
test ! -s test.err || {
  cat test.err
  exit 1
}

) || exit

rm -rf "$tmp"
