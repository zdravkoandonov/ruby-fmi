def complement(f)
  ->(*arguments) { !f.call(*arguments) }
end

def compose(f, g)
  ->(*arguments) { f.call(g.call(*arguments)) }
end
