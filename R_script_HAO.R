#library("devtools", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
#install_github("sergeitarasov/ontoFAST")
library(ontoFAST)
library("igraph", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

hao_obo<-HAO
Sharkey_characters<-Sharkey_2011
hao_obo<-onto_process(hao_obo, Sharkey_characters[,1], do.annot = F)
shiny_in<<-make_shiny_in(hao_obo)
runOntoFast()

# reading in ontology and part_of relatinships only
ontology_partof=get_OBO(system.file("data_onto", "HAO.obo", package = "ontoFAST"),
                        extract_tags="everything", propagate_relationships = c("BFO:0000050"))
# atomatically annotating ontology
ontology_partof<-onto_process(ontology_partof, Sharkey_2011[,1])
# creating character paths; exluding redundant terms
tb<-paths_sunburst(ontology_partof, annotations = ontology_partof$auto_annot_characters)
# intall sunburstR package if you lack it
library(sunburstR)
# create sunburst plot
sunburst(tb)
