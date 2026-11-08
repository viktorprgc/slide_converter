import io
from contextlib import redirect_stdout
from pathlib import Path
import tempfile
import importlib.util

src = r"c:\Users\User\Victor\Dev\slide_converter\convslide"
spec = importlib.util.spec_from_loader(
    "convslide_mod",
    importlib.machinery.SourceFileLoader("convslide_mod", src),
)
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)

d = Path(tempfile.mkdtemp())
(d / "in.mrxs").write_text("x")
c = m.imageConv(d / "in.mrxs", d)

buf = io.StringIO()
with redirect_stdout(buf):
    c.convert(dry_run=True)
print("DEFAULT:")
print(buf.getvalue())

buf2 = io.StringIO()
with redirect_stdout(buf2):
    c.convert(dry_run=True, progress=False)
print("NO_PROGRESS:")
print(buf2.getvalue())
print("has -p in default:", "-p" in buf.getvalue())
print("has -p in no_progress:", "-p" in buf2.getvalue())
