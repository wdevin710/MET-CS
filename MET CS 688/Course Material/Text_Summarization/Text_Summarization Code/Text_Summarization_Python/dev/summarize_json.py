"""
Program:
Extract content from a text file located in folder "data/"
Produces three different content summaries using these 3 different packages:
    - NLKT
    - Gensim
    - spaCy
"""

import app.project_functions as pf
from gensim.summarization import summarize

""" Read Text File """
file_path = "../data/TED_1.txt"
with open(file_path, encoding='utf8') as f:
    content = f.read()  # read text file into a string

sentence_number = len(content.split("."))

""" 1) Summarize Text using NLKT """
NLTK_summarizer = pf.SummarizeNLTK()
freq_words = NLTK_summarizer.tokenize_text(content)  # For the entire Document
sent_strength = NLTK_summarizer.find_sent_strength(content)  # For each Section
summary_NLTK = NLTK_summarizer.summarize(0.3)  # For each Section

""" 2) Summarize Text using Gensim """
summary_Gensim = summarize(content, ratio=0.3)  # For the entire Document

""" 3) Summarize Text using spaCy """
spaCy_summarizer = pf.SummarizeSpaCy()
freq_words = spaCy_summarizer.tokenize_text(content)  # For the entire Document
sent_strength = spaCy_summarizer.find_sent_strength(content)  # For each Section
summary_spaCy = spaCy_summarizer.summarize(7)  # For each Section


""" Save Summaries as Text Files """
path = file_path.replace(".txt", "_NLTK_summary.txt")
pf.save_2_text_file(summary_NLTK, path)

path = file_path.replace(".txt", "_Gensim_summary.txt")
pf.save_2_text_file(summary_Gensim, path)

path = file_path.replace(".txt", "_spaCy_summary.txt")
pf.save_2_text_file(summary_spaCy, path)


print("End")

