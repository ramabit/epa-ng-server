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
nsNew["size"] = 10
nsNew["hz_line_type"] = 1
nsNew["hz_line_color"] = "red"

faceOriginal = AttrFace("name", fsize=5)
faceNew = AttrFace("name", fsize=10)

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

##tree.img_style["size"] = 5
##tree.img_style["fgcolor"] = "LightSteelBlue"

tree.render(imageResultFileName, w=185, units="mm", tree_style=ts)
