from ete3 import Tree, TreeStyle, NodeStyle, faces, AttrFace
import sys

uuid=sys.argv[1]
queryLabelsArray=sys.argv[2].split(",")

newickFileName="results/" + uuid + "/epa_result.nw"
imageResultFileName="results/" + uuid + "/tree.png"

file = open(newickFileName, 'r')
fileContent = file.read()
file.close()

tree = Tree(fileContent)

nsOriginal = NodeStyle()
nsOriginal["fgcolor"] = "blue"

nsNew = NodeStyle()
nsNew["fgcolor"] = "red"
nsNew["shape"] = "sphere"
nsNew["size"] = 9
nsNew["hz_line_type"] = 1
nsNew["hz_line_color"] = "red"

faceOriginal = AttrFace("name", fsize=6, text_prefix=" ")
faceNew = AttrFace("name", fsize=9, fstyle="italic", text_prefix=" ")

def newNode(leaf):
	leaf.set_style(nsNew)
	leaf.add_face(faceNew, column=0, position="branch-right")

def originalNode(leaf):
	leaf.set_style(nsOriginal)
	leaf.add_face(faceOriginal, column=0, position="branch-right")

for leaf in tree:
	if any(leaf.name in label for label in queryLabelsArray):
		newNode(leaf)	
	else:
		originalNode(leaf)
        
ts = TreeStyle()
ts.show_leaf_name = False
ts.show_scale = False
ts.show_branch_length = True
ts.margin_top = 5
ts.margin_bottom = 5
ts.margin_left = 5
ts.margin_right = 5

## ts.mode = "c" // "c" for circular graphic, "r" for rectangular graphic
## ts.orientation = 0 // If 0, tree is drawn from left-to-right. If 1, tree is drawn from right-to-left. This property only makes sense when “r” mode is used.
## ts.rotation = 0 // use 90 for vertical graphic

tree.render(imageResultFileName, w=185, units="mm", tree_style=ts)
