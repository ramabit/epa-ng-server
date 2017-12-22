from ete3 import Tree
import sys

fileName=sys.argv[1]

file = open(fileName, 'r')
fileContent = file.read()
file.close()

t = Tree(fileContent)
t.render("results.png", w=183, units="mm")
