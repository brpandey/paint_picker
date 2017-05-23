# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PaintPicker.Repo.insert!(%PaintPicker.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 1, color: "salmon", sheen: "gloss", picked: true })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 2, color: "tomato", sheen: "flat", picked: true })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 3, color: "darkorange", sheen: "satin", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 4, color: "indianred", sheen: "gloss", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 5, color: "greenyellow", sheen: "eggshell", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 6, color: "mediumspringgreen", sheen: "eggshell", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 7, color: "khaki", sheen: "flat", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 8, color: "gold", sheen: "flat", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 9, color: "teal", sheen: "semi-gloss", picked: false })
PaintPicker.Repo.insert!(%PaintPicker.Paint{ cart: 10, color: "maroon", sheen: "semi-gloss", picked: false })
