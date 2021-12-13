@echo off
svn up --depth empty                                          trunk/Src
svn up --depth empty                                          trunk/Src/Delivery
svn up                                                        trunk/Src/Delivery/studio
svn up                                                        trunk/Src/Delivery/VERSION
svn up --config-option config:miscellany:use-commit-times=yes trunk/Src/C_library 
svn up --config-option config:miscellany:use-commit-times=yes trunk/Src/C
svn up                                                        trunk/Src/Eiffel
svn up                                                        trunk/Src/dotnet
svn up --depth infinity                                       trunk/Src/contrib
svn up --depth infinity                                       trunk/Src/framework
svn up --depth infinity                                       trunk/Src/library
svn up --depth empty                                          trunk/Src/tools
svn up --depth infinity                                       trunk/Src/tools/compliance_checker
svn up --depth infinity                                       trunk/Src/unstable
svn up --depth empty                                          trunk/Src/web
svn up --depth empty                                          trunk/Src/web/support
svn up                                                        trunk/Src/web/support/client
svn up                                                        trunk/research
