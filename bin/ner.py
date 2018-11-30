from __future__ import unicode_literals
import sys
import io
import os.path
from spacy import displacy
from collections import Counter
import en_core_web_sm

nlp = en_core_web_sm.load()

file = sys.argv[1]

skip_entities = ["cardinal", "ordinal"]

sentences = []
entities = {}

with io.open(file, "r", encoding="utf-8") as f:
  for line in f.read().splitlines():
    tags = nlp(line)
    sentence = line
    found_entities = {}
    for entity in tags.ents:
      label = entity.label_.lower()

      if label in skip_entities:
        continue

      if not found_entities.get(label):
        found_entities[label] = 1
      else:
        found_entities[label] += 1
      reference = label + str(found_entities[label])
      sentence = sentence.replace(entity.text, "{"+ reference.lower() +"}")
      if not entities.get(label):
        entities[label] = []
      entities[label].append(entity.text)
    sentences.append(sentence)

for entity, names in entities.iteritems():
  entity_file = "data/entities/" + entity + ".txt"
  mode = "a" if os.path.isfile(entity_file) else "w"
  with io.open(entity_file, mode, encoding="utf-8") as f:
    f.write("\n".join(names))

with io.open(file.replace("clean", "nlp"), "w", encoding="utf-8") as dest:
  dest.write("\n".join(sentences))
