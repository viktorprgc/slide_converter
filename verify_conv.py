import ast
p = r"c:\Users\User\Victor\Dev\slide_converter\convslide"
s = open(p, encoding="utf-8").read()
ast.parse(s)
print("AST_PARSE_OK lines=", s.count("\n") + 1)
print("has_stray", "tiff_out_filenv" in s or "env: use -[v]S" in s)
import importlib.util, sys
spec = importlib.util.spec_from_loader("convslide_mod", loader=None)
