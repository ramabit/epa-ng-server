from ete3 import Tree, TreeStyle, NodeStyle, faces, AttrFace
import sys

def uuid():
	return sys.argv[1]

def queryLabelsArray():
	return sys.argv[2].split(",")

def newickFileName():
	return "results/" + uuid() + "/epa_result.nw"

def imageResultFileName(fileName):
	return "results/" + uuid() + "/" + fileName + ".png"

def createTree():
	file = open(newickFileName(), 'r')
	fileContent = file.read()
	file.close()
	tree = Tree(fileContent)

	for leaf in tree:
		if any(leaf.name in label for label in queryLabelsArray()):
			queryNode(leaf)	
		else:
			originalNode(leaf)

	return tree

def queryNode(leaf):
	nsQuery = NodeStyle()
	nsQuery["fgcolor"] = "red"
	nsQuery["shape"] = "sphere"
	nsQuery["size"] = 9
	nsQuery["hz_line_type"] = 1
	nsQuery["hz_line_color"] = "red"
	faceQuery = AttrFace("name", fsize=9, fstyle="italic", text_prefix=" ")
	leaf.set_style(nsQuery)
	leaf.add_face(faceQuery, column=0, position="branch-right")

def originalNode(leaf):
	nsOriginal = NodeStyle()
	nsOriginal["fgcolor"] = "blue"
	faceOriginal = AttrFace("name", fsize=6, text_prefix=" ")
	leaf.set_style(nsOriginal)
	leaf.add_face(faceOriginal, column=0, position="branch-right")

