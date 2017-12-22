from ete3 import Tree, NodeStyle
import sys

uuid=sys.argv[1]
queryLabelsArray=sys.argv[2].split(",")

newickFileName="results/" + uuid + "/epa_result.nw"
imageResultFileName="results/" + uuid + "/tree.png"

file = open(newickFileName, 'r')
fileContent = file.read()
file.close()

tree = Tree(fileContent)

ns1 = NodeStyle()
ns1["fgcolor"] = "LightSteelBlue"

for leaf in tree:
	print(leaf.name)
	if any(leaf.name in label for label in queryLabelsArray):
		leaf.set_style(ns1)
		print(leaf.name)
		#leaf.add_features(color=colors.get("green"))
        

tree.render(imageResultFileName, w=185, units="mm")

## TODO Use queryLabelsArray to apply at those labels a different color in the graphic
