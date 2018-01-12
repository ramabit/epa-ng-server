
def circularQueryNode(leaf):
	nsQuery = NodeStyle()
	nsQuery["fgcolor"] = "red"
	nsQuery["shape"] = "sphere"
	nsQuery["size"] = 15
	nsQuery["hz_line_type"] = 1
	nsQuery["hz_line_color"] = "red"
	faceQuery = AttrFace("name", fsize=25, fstyle="italic")
	leaf.set_style(nsQuery)
	leaf.add_face(faceQuery, column=0, position="branch-right")

def circularOriginalNode(leaf):
	nsOriginal = NodeStyle()
	nsOriginal["fgcolor"] = "blue"
	nsOriginal["size"] = 10
	faceOriginal = AttrFace("name", fsize=15)
	leaf.set_style(nsOriginal)
	leaf.add_face(faceOriginal, column=0, position="branch-right")

from graphics import *
import graphics

graphics.queryNode = circularQueryNode
graphics.originalNode = circularOriginalNode

tree = createTree()

ts = TreeStyle()
ts.show_leaf_name = False
ts.show_scale = False
ts.show_branch_length = True
ts.margin_top = 10
ts.margin_bottom = 10
ts.margin_left = 10
ts.margin_right = 10
ts.mode = "c"

## ts.mode = "c" // "c" for circular graphic, "r" for rectangular graphic
## ts.orientation = 0 // 0 means up to down, 1 means down to up

tree.render(imageResultFileName("circular-tree"), w=200, units="mm", dpi=150, tree_style=ts)

