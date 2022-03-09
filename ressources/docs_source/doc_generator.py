#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import re
import shutil
import argparse
from pathlib import Path

class docGenerator(object):

    buildDir = 'design'
    diaOutFormat = 'png'

    """docstring for hwdocbuilder"""
    def __init__(self, arg=None):
        super(docGenerator, self).__init__()
        # Arguments
        argParse = argparse.ArgumentParser()
        argParse.add_argument("-v", "--verbose", help="Enable verbose output", action='store_true')
        args = argParse.parse_args()
        self.verbose = args.verbose

        # File searching
        if arg == None:
            self.rootPath = str(Path(__file__).parent)
        else:
            self.rootPath = str(arg)
        self.buildPath = os.path.join(self.rootPath, self.buildDir)
        self.searchRegex = re.compile('(.*yml$)|(.*drawio$)')

        self.diaList = []
        self.hrsList = []
        self.builtList = []

    def searchFiles(self):
        if self.verbose:
            print('Searching in {} for {}'.format(self.rootPath, self.searchRegex))
        for root, dirs, files in os.walk(self.rootPath):
            for file in files:
                found = self.searchRegex.match(file)
                if found:
                    if found.group(1):
                        self.hrsList.append(os.path.join(root, file))

                    if found.group(2):
                        self.diaList.append(os.path.join(root, file))
        if self.verbose:
            print("Harnesses: ", self.hrsList)
            print("Diagrams: ", self.diaList)

    def prepFolder(self):
        try:
            # ensure root folder exists
            if not os.path.exists(self.buildPath):
                if self.verbose:
                    print("creating folder: {}".format(self.buildPath))
                os.makedirs(self.buildPath)

            # ensure subfolder are ready
            for dia in self.diaList:
                commonPath = os.path.commonpath([self.rootPath, dia])
                folder = os.path.dirname(dia).replace(commonPath, '')
                folder = folder[1:]
                folder = os.path.join(self.buildPath, folder)
                if not os.path.exists(folder):
                    if self.verbose:
                        print("creating folder: {}".format(folder))
                    os.makedirs(folder)
            for hrs in self.hrsList:
                commonPath = os.path.commonpath([self.rootPath, hrs])
                folder = os.path.dirname(hrs).replace(commonPath, '')
                folder = folder[1:]
                folder = os.path.join(self.buildPath, folder)
                if not os.path.exists(folder):
                    if self.verbose:
                        print("creating folder: {}".format(folder))
                    os.makedirs(folder)
        except Exception as e:
            raise e

    def buildHrs(self):
        for hrs in self.hrsList:                        # and we'll build each member of it
            if self.verbose:
                print ("Building harness \'{}\'".format(hrs))

            # path preparation
            commonPath = os.path.commonpath([self.rootPath, hrs])
            outPath = os.path.dirname(hrs).replace(commonPath, '')
            outPath = outPath[1:]
            outPath = os.path.join(self.buildPath, outPath)

            # actual building
            resultCode = os.system("wireviz {}".format(hrs))
            if resultCode == 0:   # Try to build this harness
                self.builtList.append(str(hrs))      # Add it to the built list if successful
            else:
                print('failed with code: {}\n'.format(resultCode))

            # move to build folder and cleanup
            try:
                name, extension = os.path.basename(hrs).split('.')
                os.chdir(os.path.dirname(hrs))
                shutil.copy(name + '.bom.tsv', outPath)
                os.remove(name + '.bom.tsv')
                shutil.copy(name + '.gv', outPath)
                os.remove(name + '.gv')
                shutil.copy(name + '.html', outPath)
                os.remove(name + '.html')
                shutil.copy(name + '.png', outPath)
                os.remove(name + '.png')
                shutil.copy(name + '.svg', outPath)
                os.remove(name + '.svg')
            except Exception as e:
                raise e

    def buildDia(self):
        for dia in self.diaList:
            if self.verbose:
                print ("Building diagram \'{}\'".format(dia))
            commonPath = os.path.commonpath([self.rootPath, dia])
            outPath = os.path.dirname(dia).replace(commonPath, '')
            outPath = outPath[1:]
            outPath = os.path.join(self.buildPath, outPath)

            # Try to build this diagram
            try:
                resultCode = os.system("drawio -x -t -f {} -o {} {}".format(self.diaOutFormat, outPath, dia))
                # Add it to the built list if successful
                if resultCode == 0:
                    self.builtList.append(str(dia))
                else:
                    print ('failed with code: {}'.format(resultCode))
            except Exception as e:
                raise e

    def run(self):
        # 1. Search all supported files
        self.searchFiles()

        # 2. Prepare build folder
        self.prepFolder()

        # 4. Generate diagrams
        self.buildDia()
