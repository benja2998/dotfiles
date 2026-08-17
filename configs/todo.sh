#!/bin/bash

grep -E '.*? \(.*?\): ' Documents/note.txt | grep -v DONE
