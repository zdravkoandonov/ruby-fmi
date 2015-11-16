def quine
  a = "def quine\n"
  b = ") + \"%p\" % c + b\nend\n\nquine"
  puts a + (c = "  a = \"def quine\\n\"\n  b = \") + \\\"%p\\\" % c + b\\nend\\n\\nquine\"\n  puts a + (c = ") + "%p" % c + b
end

quine
