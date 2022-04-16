import shutil
directoryInput = input("Dir name?: ")
jsonTasksFile = "C:\\Files\\Programming\\Personal\\Files\\tasks.json"
endpathJsonTasksFile = "C:\\Files\\Programming\\" + directoryInput + "\\.vscode\\tasks.json"

shutil.copyfile(jsonTasksFile, endpathJsonTasksFile)