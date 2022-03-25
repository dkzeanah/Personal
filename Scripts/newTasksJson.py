import os
directoryInput = input("Dir name?: ")

jsonDirectory = "C:\\Files\\Programming\\" + directoryInput + "\\.vscode\\tasks.json"
vscodeDirectory = "C:\\Files\\Programming\\" + directoryInput + "\\.vscode"
newJsonSnippet = "{\n\t// See https://go.microsoft.com/fwlink/?LinkId=733558\n\t// for the documentation about the tasks.json format\n\t\"version\": \"2.0.0\",\n\t\"tasks\": [\n\t\t{\n\t\t\t\"label\": \"new git push origin main --force\",\n\t\t\t\"type\": \"shell\",\n\t\t\t\"command\": \"git push\",\n\t\t\t\"problemMatcher\": [],\n\t\t\t\"presentation\": {\n\t\t\t\t\"focus\": true\n\t\t\t}\n\t\t}\n\t]\n}"

try:
   with open(jsonDirectory, "x") as jsonFile:
      jsonFile.write(newJsonSnippet)
except FileNotFoundError:
   os.mkdir(vscodeDirectory)
   with open(jsonDirectory, "x") as jsonFile:
      jsonFile.write(newJsonSnippet)