#!/usr/bin/env python3
"""Verify every surface uses the same One Dark Pro Darker values."""
import json, re, plistlib, sys

# ANSI colours match the One Dark Pro VS Code theme's terminal.ansi* values exactly (these
# are shared with the non-Darker variant); "base" is the Darker variant's editor.background
# (#23272e instead of #282c34), so the external terminals (Ghostty, iTerm2) agree with
# VS Code's integrated terminal.
ANSI_COLORS = {
    "black": "3f4451", "red": "e05561", "green": "8cc265", "yellow": "d18f52",
    "blue": "4aa5f0", "magenta": "c162de", "cyan": "42b3c2", "white": "d7dae0",
    "bright_black": "4f5666", "bright_red": "ff616e", "bright_green": "a5e075",
    "bright_yellow": "f0a45d", "bright_blue": "4dc4ff", "bright_magenta": "de73ff",
    "bright_cyan": "4cd1e0", "bright_white": "e6e6e6",
    "base": "23272e", "text": "abb2bf",
}
ANSI = {0:"black",1:"red",2:"green",3:"yellow",4:"blue",5:"magenta",6:"cyan",7:"white",
        8:"bright_black",9:"bright_red",10:"bright_green",11:"bright_yellow",
        12:"bright_blue",13:"bright_magenta",14:"bright_cyan",15:"bright_white"}
EXPECT = {i: ANSI_COLORS[n] for i, n in ANSI.items()}

# Starship's palette uses Catppuccin-style semantic names rather than raw ANSI slots,
# but every value still traces back to ANSI_COLORS -- there is only one source of truth.
STARSHIP_EXPECT = {
    "red": ANSI_COLORS["red"], "green": ANSI_COLORS["green"], "yellow": ANSI_COLORS["yellow"],
    "peach": ANSI_COLORS["bright_yellow"], "blue": ANSI_COLORS["blue"],
    "sapphire": ANSI_COLORS["bright_blue"], "mauve": ANSI_COLORS["magenta"],
    "teal": ANSI_COLORS["cyan"], "overlay1": ANSI_COLORS["bright_black"],
    "text": ANSI_COLORS["text"], "base": ANSI_COLORS["base"],
}

fails = []

g = open(".config/ghostty/config").read()
gp = {int(a): b.lower() for a, b in re.findall(r"palette\s*=\s*(\d+)=#([0-9a-fA-F]{6})", g)}
for i in range(16):
    if gp.get(i) != EXPECT[i]:
        fails.append(f"ghostty palette {i}: {gp.get(i)} != {EXPECT[i]}")
for key, want in (("background", ANSI_COLORS["base"]), ("foreground", ANSI_COLORS["text"])):
    m = re.search(rf"^{key}\s*=\s*#?([0-9a-fA-F]{{6}})", g, re.M)
    if not m or m.group(1).lower() != want:
        fails.append(f"ghostty {key} != {want}")

def unhex(d):
    return "".join(f"{round(d[k]*255):02x}"
                   for k in ("Red Component", "Green Component", "Blue Component"))

ic = plistlib.load(open("iterm2/one-dark-pro.itermcolors", "rb"))
dp = json.load(open("iterm2/One-Dark-Pro.json"))["Profiles"][0]
for label, prof in (("itermcolors", ic), ("dynamicprofile", dp)):
    for i in range(16):
        got = unhex(prof[f"Ansi {i} Color"])
        if got != EXPECT[i]:
            fails.append(f"{label} Ansi {i}: {got} != {EXPECT[i]}")
    if unhex(prof["Background Color"]) != ANSI_COLORS["base"]:
        fails.append(f"{label} background")

st = open(".config/starship.toml").read()
blk = st[st.index("[palettes.one_dark_pro]"):st.index("[character]")]
sp = {a: b.lower() for a, b in re.findall(r'^(\w+)\s*=\s*"#([0-9a-fA-F]{6})"', blk, re.M)}
for name, hexv in STARSHIP_EXPECT.items():
    if sp.get(name) != hexv:
        fails.append(f"starship {name}: {sp.get(name)} != {hexv}")

fz = open(".zsh/fzf.zsh").read().lower()
for want in (ANSI_COLORS["base"], ANSI_COLORS["text"], ANSI_COLORS["red"], ANSI_COLORS["black"]):
    if want not in fz:
        fails.append(f"fzf.zsh missing {want}")

if fails:
    print("palette drift:")
    for f in fails:
        print("  -", f)
    sys.exit(1)
print("palette: ghostty, itermcolors, dynamicprofile, starship, fzf all agree")
