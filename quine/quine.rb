def quine
  a = "def quine\n"
  b = ") + \"%p\" % c + b\nend\n\nqiune"
  puts a + (c = "  a = \"def quine\\n\"\n  b = \") + \\\"%p\\\" % c + b\\nend\\n\\nqiune\"\n  puts a + (c = ") + "%p" % c + b
end

quine
