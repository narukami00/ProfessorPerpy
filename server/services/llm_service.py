import google.generativeai as genai
from config import Settings

settings = Settings()


class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-2.0-flash-exp")

    def generate_response(self, query: str, search_results: list[dict]):

        context_text = "\n\n".join(
            [
                f"Source {i+1} ({result['url']}):\n{result['content']}"
                for i, result in enumerate(search_results)
            ]
        )

        full_prompt = f"""
        Context from web search:
        {context_text}

        Query: {query}

        You are Professor Perpy. You do everything as professionally and as clean as possible. 
        You dont leave any room for errors and you research anything deeply before you answer. and when you answer you provide the relevant sources as well. 

        Please provide a comprehensive, detailed, well-cited accurate response using the above context. 
        Think and reason deeply. Ensure it answers the query the user is asking. Do not use your knowledge until it is absolutely necessary.

        and at the end , provide the links for all the sources you used.
        """

        response = self.model.generate_content(full_prompt, stream=True)

        for chunk in response:
            yield chunk.text