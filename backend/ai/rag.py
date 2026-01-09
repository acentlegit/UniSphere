from llama_cpp import Llama
from sentence_transformers import SentenceTransformer
import faiss, pickle, os

llm = Llama(model_path="models/llama.gguf", n_ctx=2048)
embedder = SentenceTransformer("all-MiniLM-L6-v2")

INDEX = "index.faiss"
DOCS = "docs.pkl"

if os.path.exists(INDEX):
    index = faiss.read_index(INDEX)
    docs = pickle.load(open(DOCS, "rb"))
else:
    index = faiss.IndexFlatL2(

