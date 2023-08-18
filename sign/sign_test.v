module sign

fn test_sign() {
  assert 'a914ce04c4ec17de64dc0c6132dffaa38724ead867efb52e36d416b6be10d177' == sign('foobarbaz69420', 'fizzbuzz')
}
