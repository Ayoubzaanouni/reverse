import tkinter as tk
from tkinter import scrolledtext
import pyperclip
import subprocess

def is_python_installed():
    try:
        subprocess.Popen(["python", "--version"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        return True
    except FileNotFoundError:
        return False

def reverse_words():
    input_sentence = input_text.get("1.0", tk.END).strip()
    reversed_sentence = ' '.join(input_sentence.split()[::-1])
    output_text.config(state=tk.NORMAL)
    output_text.delete("1.0", tk.END)
    output_text.insert(tk.END, reversed_sentence)
    output_text.config(state=tk.DISABLED)

def copy_to_clipboard():
    reversed_sentence = output_text.get("1.0", tk.END).strip()
    pyperclip.copy(reversed_sentence)

root = tk.Tk()
root.title("Reverse Words")
root.geometry("400x300")
root.configure(bg="#f0f0f0")

input_text = scrolledtext.ScrolledText(root, width=50, height=5, wrap=tk.WORD, font=("Arial", 12))
input_text.pack(pady=10)

reverse_button = tk.Button(root, text="Reverse", command=reverse_words, font=("Arial", 12))
reverse_button.pack(pady=5)

output_text = scrolledtext.ScrolledText(root, width=50, height=5, wrap=tk.WORD, font=("Arial", 12))
output_text.pack(pady=10)
output_text.config(state=tk.DISABLED)

copy_button = tk.Button(root, text="Copy to Clipboard", command=copy_to_clipboard, font=("Arial", 12))
copy_button.pack(pady=5)

if not is_python_installed():
    tk.messagebox.showerror("Error", "Python is required to run this application.")
    root.destroy()
root.mainloop()
