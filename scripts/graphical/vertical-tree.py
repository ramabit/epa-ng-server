from graphics import *

tree = createTree()

ts = TreeStyle()
ts.show_leaf_name = False
ts.show_scale = False
ts.show_branch_length = True
ts.margin_top = 5
ts.margin_bottom = 5
ts.margin_left = 5
ts.margin_right = 5
ts.mode = "r" ## rectangular graphic
ts.rotation = 90

## ts.orientation = 0 // 0 means up to down, 1 means down to up

tree.render(imageResultFileName("vertical-tree"), w=200, units="mm", tree_style=ts)
