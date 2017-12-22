from ete3 import Tree
import sys

uuid=sys.argv[1]
queryLabelsArray=sys.argv[2].split(",")

newickFileName="results/" + uuid + "/epa_result.nw"
imageResultFileName="results/" + uuid + "/tree.png

file = open(newickFileName, 'r')
fileContent = file.read()
file.close()

t = Tree(fileContent)
t.render(imageResultFileName, w=185, units="mm")

## TODO Use queryLabelsArray to apply at those labels a different color in the graphic
