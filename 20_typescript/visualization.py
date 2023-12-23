import graphviz

g = graphviz.Digraph('G', filename='graph_visual.gv')

nodes = [
    (("%", "zl"), ("zp", "cl")),
    (("%", "vp"), ("dj", "vr")),
    (("%", "cc"), ("xp",)),
    (("&", "dj"), ("lq", "mb", "dc", "ns", "gz")),
    (("%", "md"), ("ts", "zp")),
    (("%", "fc"), ("zp",)),
    (("%", "px"), ("zx",)),
    (("&", "nx"), ("gl", "br", "pr", "xf", "vd", "gj", "kd")),
    (("%", "tf"), ("lt", "dj")),
    (("%", "fj"), ("pc",)),
    (("%", "mb"), ("xx",)),
    (("%", "cl"), ("mj",)),
    (("%", "pm"), ("fj",)),
    (("%", "dc"), ("dj", "vp")),
    (("%", "jc"), ("bz", "xm")),
    (("&", "vd"), ("zh",)),
    (("%", "pz"), ("sr", "nx")),
    (("&", "ns"), ("zh",)),
    (("%", "sr"), ("nx",)),
    (("%", "gl"), ("pr",)),
    (("%", "xx"), ("nt", "dj")),
    (("%", "gp"), ("md",)),
    (("%", "hb"), ("jl", "nx")),
    (("&", "zh"), ("rx",)),
    (("%", "rb"), ("gz", "dj")),
    (("%", "xm"), ("bz",)),
    (("&", "zp"), ("px", "gp", "cl", "bh", "fn", "ls", "hs")),
    (("&", "bz"), ("pm", "pc", "bv", "dl", "jp", "fj", "cc")),
    (("%", "nl"), ("bz", "pm")),
    (("&", "bh"), ("zh",)),
    (("%", "hq"), ("gj", "nx")),
    (("%", "bv"), ("bz", "nl")),
    (("%", "bj"), ("jp", "bz")),
    (("%", "gj"), ("mx",)),
    (("%", "xp"), ("bz", "bj")),
    (("%", "vr"), ("dj", "mb")),
    (("&", "dl"), ("zh",)),
    (("%", "pr"), ("hb",)),
    (("%", "nt"), ("dj", "lq")),
    (("%", "mx"), ("gl", "nx")),
    (("%", "kd"), ("hq",)),
    (("%", "fn"), ("px",)),
    (("%", "jp"), ("xc",)),
    (("%", "zx"), ("zl", "zp")),
    (("%", "br"), ("nx", "xf")),
    (("%", "lt"), ("dj",)),
    (("%", "df"), ("dj", "tf")),
    (("%", "ts"), ("zp", "fc")),
    (("%", "jl"), ("nx", "pz")),
    (("%", "xc"), ("jc", "bz")),
    (("%", "xf"), ("kd",)),
    (("%", "lq"), ("rb",)),
    (("%", "gz"), ("df",)),
    (("%", "pc"), ("cc",)),
    (("%", "hs"), ("fn",)),
    (("", "broadcaster"), ("ls", "bv", "dc", "br")),
    (("%", "mj"), ("zp", "gp")),
    (("%", "ls"), ("hs", "zp")),
]

for lhs, rhs in nodes:
    for node in rhs:
        if lhs[0] == "&":
            g.node(lhs[1], style='filled', fillcolor='#ff000042')
        elif lhs[0] == "%":
            g.node(lhs[1], style='filled', fillcolor='#a0a0ff')
        else:
            g.node(lhs[1], shape='doublecircle')
        g.edge(lhs[1], node)
    g.node("rx", shape='doublecircle')

g.view()
