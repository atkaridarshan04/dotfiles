#!/usr/bin/env python3
"""Verify every surface uses the same Catppuccin Mocha values."""
import json, re, plistlib, sys

C = {
    "red": "f38ba8", "green": "a6e3a1", "yellow": "f9e2af", "blue": "89b4fa",
    "pink": "f5c2e7", "teal": "94e2d5", "subtext0": "a6adc8", "subtext1": "bac2de",
    "surface1": "45475a", "surface2": "585b70", "base": "1e1e2e", "text": "cdd6f4",
}
ANSI = {0:"surface1",1:"red",2:"green",3:"yellow",4:"blue",5:"pink",6:"teal",7:"subtext0",
        8:"surface2",9:"red",10:"green",11:"yellow",12:"blue",13:"pink",14:"teal",15:"subtext1"}
EXPECT = {i: C[n] for i, n in ANSI.items()}
fails = []

g = open(".config/ghostty/config").read()
gp = {int(a): b.lower() for a, b in re.findall(r"palette\s*=\s*(\d+)=#([0-9a-fA-F]{6})", g)}
for i in range(16):
    if gp.get(i) != EXPECT[i]:
        fails.append(f"ghostty palette {i}: {gp.get(i)} != {EXPECT[i]}")
for key, want in (("background", C["base"]), ("foreground", C["text"])):
    m = re.search(rf"^{key}\s*=\s*#?([0-9a-fA-F]{{6}})", g, re.M)
    if not m or m.group(1).lower() != want:
        fails.append(f"ghostty {key} != {want}")

def unhex(d):
    return "".join(f"{round(d[k]*255):02x}"
                   for k in ("Red Component", "Green Component", "Blue Component"))

ic = plistlib.load(open("iterm2/catppuccin-mocha.itermcolors", "rb"))
dp = json.load(open("iterm2/Catppuccin-Mocha.json"))["Profiles"][0]
for label, prof in (("itermcolors", ic), ("dynamicprofile", dp)):
    for i in range(16):
        got = unhex(prof[f"Ansi {i} Color"])
        if got != EXPECT[i]:
            fails.append(f"{label} Ansi {i}: {got} != {EXPECT[i]}")
    if unhex(prof["Background Color"]) != C["base"]:
        fails.append(f"{label} background")

st = open(".config/starship.toml").read()
blk = st[st.index("[palettes.catppuccin_mocha]"):st.index("[character]")]
sp = {a: b.lower() for a, b in re.findall(r'^(\w+)\s*=\s*"#([0-9a-fA-F]{6})"', blk, re.M)}
for name, hexv in C.items():
    if sp.get(name) != hexv:
        fails.append(f"starship {name}: {sp.get(name)} != {hexv}")

fz = open(".zsh/fzf.zsh").read().lower()
for want in (C["base"], C["text"], C["red"], C["surface1"]):
    if want not in fz:
        fails.append(f"fzf.zsh missing {want}")

if fails:
    print("palette drift:")
    for f in fails:
        print("  -", f)
    sys.exit(1)
print("palette: ghostty, itermcolors, dynamicprofile, starship, fzf all agree")
