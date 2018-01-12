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

## ts.orientation = 0 // 0 means left to right, 1 means right to left

tree.render(imageResultFileName("horizontal-tree"), w=200, units="mm", tree_style=ts)
